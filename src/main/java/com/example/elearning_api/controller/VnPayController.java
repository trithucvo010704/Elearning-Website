package com.example.elearning_api.controller;

import com.example.elearning_api.Enum.PaymentStatus;
import com.example.elearning_api.entity.Payment;
import com.example.elearning_api.repository.PaymentRepository;
import com.example.elearning_api.service.VnPayService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/payment/vnpay")
public class VnPayController {

    private final VnPayService vnPayService;
    private final PaymentRepository paymentRepository;

    public VnPayController(VnPayService vnPayService, PaymentRepository paymentRepository) {
        this.vnPayService = vnPayService;
        this.paymentRepository = paymentRepository;
    }

    @PostMapping("/create")
    public ResponseEntity<Map<String, String>> createPayment(@RequestBody CreatePaymentRequest req, HttpServletRequest request) {
        String ipAddress = request.getRemoteAddr();
        String paymentUrl = vnPayService.createPayment(req.getOrderId(), req.getAmount(), ipAddress);
        Map<String, String> response = new HashMap<>();
        response.put("url", paymentUrl);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/return")
    public ResponseEntity<String> returnUrl(@RequestParam Map<String,String> allParams) {
        // người dùng redirect về đây sau thanh toán
        boolean valid = vnPayService.validateCallback(allParams);
        String txnRef = allParams.get("vnp_TxnRef");
        String rspCode = allParams.get("vnp_ResponseCode");
        Payment payment = paymentRepository.findByTxnRef(txnRef).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Payment not found"));
        if (valid && "00".equals(rspCode)) {
            payment.setStatus(PaymentStatus.SUCCESS);
            paymentRepository.save(payment);
            return ResponseEntity.ok("Thanh toan thanh cong");
        } else {
            payment.setStatus(PaymentStatus.FAILED);
            paymentRepository.save(payment);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Thanh toan that bai");
        }
    }

    @PostMapping("/ipn")
    public ResponseEntity<String> ipnUrl(@RequestParam Map<String,String> allParams) {
        // IPN (server-to-server) callback từ VNPAY — nên xử lý tương tự nhưng trả lại định dạng JSON/văn bản như VNPAY yêu cầu
        if (!vnPayService.validateCallback(allParams)) {
            return ResponseEntity.badRequest().body("Invalid signature");
        }
        String txnRef = allParams.get("vnp_TxnRef");
        String rspCode = allParams.get("vnp_ResponseCode");
        Payment payment = paymentRepository.findByTxnRef(txnRef).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Payment not found"));
        if ("00".equals(rspCode)) {
            payment.setStatus(PaymentStatus.SUCCESS);
            paymentRepository.save(payment);
        } else {
            payment.setStatus(PaymentStatus.FAILED);
            paymentRepository.save(payment);
        }
        // Trả lại cho VNPAY
        return ResponseEntity.ok("{\"RspCode\": \"00\", \"Message\": \"Confirm Success\"}");
    }
}

