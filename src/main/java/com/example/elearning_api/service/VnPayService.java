package com.example.elearning_api.service;

import com.example.elearning_api.config.VnPayConfig;
import com.example.elearning_api.entity.Payment;
import com.example.elearning_api.entity.Order;
import com.example.elearning_api.repository.OrderRepository;
import com.example.elearning_api.repository.PaymentRepository;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;
import com.example.elearning_api.Enum.PaymentStatus;
import com.example.elearning_api.Enum.Provider;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
public class VnPayService {

    private final VnPayConfig config;
    private final PaymentRepository paymentRepository; // giả sử bạn có entity Payment
    private final OrderRepository orderRepo;

    public VnPayService(VnPayConfig config, PaymentRepository paymentRepository, OrderRepository orderRepo) {
        this.config = config;
        this.paymentRepository = paymentRepository;
        this.orderRepo = orderRepo;
    }

    public String createPayment(Long orderId, Long amount, String ipAddress) {
        try {
            String vnp_TxnRef = orderId.toString(); // hoặc kết hợp timestamp cho unique
            String vnp_OrderInfo = "Thanh toan don hang #" + orderId;
            String vnp_CreateDate = DateTimeFormatter.ofPattern("yyyyMMddHHmmss")
                    .format(LocalDateTime.now());
            String vnp_ExpireDate = DateTimeFormatter.ofPattern("yyyyMMddHHmmss")
                    .format(LocalDateTime.now().plusMinutes(15));

            Map<String, String> vnpParams = new HashMap<>();
            vnpParams.put("vnp_Version", config.getVersion());
            vnpParams.put("vnp_Command", config.getCommand());
            vnpParams.put("vnp_TmnCode", config.getTmnCode());
            vnpParams.put("vnp_Amount", String.valueOf(amount * 100)); // VNPAY yêu cầu nhân 100 :contentReference[oaicite:4]{index=4}
            vnpParams.put("vnp_CurrCode", config.getCurrCode());
            vnpParams.put("vnp_TxnRef", vnp_TxnRef);
            vnpParams.put("vnp_OrderInfo", vnp_OrderInfo);
            vnpParams.put("vnp_OrderType", "other");
            vnpParams.put("vnp_Locale", config.getLocale());
            vnpParams.put("vnp_ReturnUrl", config.getReturnUrl());
            vnpParams.put("vnp_IpAddr", ipAddress);
            vnpParams.put("vnp_CreateDate", vnp_CreateDate);
            vnpParams.put("vnp_ExpireDate", vnp_ExpireDate);

            // Build dữ liệu string sorted by key
            List<String> fieldNames = new ArrayList<>(vnpParams.keySet());
            Collections.sort(fieldNames);
            StringBuilder hashData = new StringBuilder();
            StringBuilder query = new StringBuilder();
            for (String fieldName : fieldNames) {
                String value = vnpParams.get(fieldName);
                if (value != null && value.length() > 0) {
                    // nối hashData
                    hashData.append(fieldName).append("=").append(URLEncoder.encode(value, StandardCharsets.US_ASCII.toString()));
                    query.append(fieldName).append("=").append(URLEncoder.encode(value, StandardCharsets.US_ASCII.toString()));
                    if (!fieldName.equals(fieldNames.get(fieldNames.size() -1))) {
                        hashData.append("&");
                        query.append("&");
                    }
                }
            }
            String secureHash = hmacSHA512(config.getHashSecret(), hashData.toString());
            query.append("&vnp_SecureHash=").append(secureHash);

            String paymentUrl = config.getPayUrl() + "?" + query.toString();

            // Lưu thông tin Payment
            Payment payment = new Payment();
            payment.setStatus(PaymentStatus.PENDING);
            payment.setAmountCents(amount * 100); // lưu dạng cents (theo entity)
            payment.setCurrency("VND");
            payment.setProvider(Provider.VNPAY);
            payment.setVnpTxnRef(vnp_TxnRef);

            // lấy order từ repo (tuỳ anh có orderRepo hay không)
            Order order = orderRepo.findById(orderId)
                    .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Order not found"));
            payment.setOrder(order);
            payment.setUser(order.getUser());
            payment.setCourse(order.getCourse());

            paymentRepository.save(payment);
            return paymentUrl;
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("Error generating VNPay payment URL", e);
        }
    }

    public boolean validateCallback(Map<String, String> params) {
        String secureHash = params.get("vnp_SecureHash");
        if (secureHash == null) {
            return false;
        }
        // Remove secure hash and hash type if exist
        params.remove("vnp_SecureHash");
        params.remove("vnp_SecureHashType");

        List<String> fieldNames = new ArrayList<>(params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        for (String fieldName : fieldNames) {
            String value = params.get(fieldName);
            if (value != null && value.length() > 0) {
                hashData.append(fieldName).append("=").append(value);
                if (!fieldName.equals(fieldNames.get(fieldNames.size() -1))) {
                    hashData.append("&");
                }
            }
        }
        String calculatedHash = hmacSHA512(config.getHashSecret(), hashData.toString());
        return calculatedHash.equals(secureHash);
    }

    private String hmacSHA512(String key, String data) {
        try {
            Mac hmac = Mac.getInstance("HmacSHA512");
            byte[] hmacKey = key.getBytes(StandardCharsets.UTF_8);
            SecretKeySpec secretKey = new SecretKeySpec(hmacKey, "HmacSHA512");
            hmac.init(secretKey);
            byte[] bytes = hmac.doFinal(data.getBytes(StandardCharsets.UTF_8));
            StringBuilder hash = new StringBuilder(2 * bytes.length);
            for (byte b : bytes) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hash.append('0');
                }
                hash.append(hex);
            }
            return hash.toString();
        } catch (Exception e) {
            throw new RuntimeException("Error while hashing data for VNPay", e);
        }
    }
}

