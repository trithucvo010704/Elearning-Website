package com.example.elearning_api.controller;

import com.example.elearning_api.Enum.OrderStatus;
import com.example.elearning_api.Enum.PaymentStatus;
import com.example.elearning_api.dto.payment.CreatePaymentRequest;
import com.example.elearning_api.entity.Course;
import com.example.elearning_api.entity.Enrollment;
import com.example.elearning_api.entity.Order;
import com.example.elearning_api.entity.Payment;
import com.example.elearning_api.repository.CourseRepository;
import com.example.elearning_api.repository.EnrollmentRepository;
import com.example.elearning_api.repository.OrderRepository;
import com.example.elearning_api.repository.PaymentRepository;
import com.example.elearning_api.security.UserPrincipal; // đổi lại đúng package của bạn
import com.example.elearning_api.service.VnPayService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/payment/vnpay")
public class VnPayController {

    private final VnPayService vnPayService;
    private final PaymentRepository paymentRepository;
    private final CourseRepository courseRepository;
    private final OrderRepository orderRepository;
    private final EnrollmentRepository enrollmentRepository;

    public VnPayController(VnPayService vnPayService,
                           PaymentRepository paymentRepository,
                           CourseRepository courseRepository,
                           OrderRepository orderRepository,
                           EnrollmentRepository enrollmentRepository) {
        this.vnPayService = vnPayService;
        this.paymentRepository = paymentRepository;
        this.courseRepository = courseRepository;
        this.orderRepository = orderRepository;
        this.enrollmentRepository = enrollmentRepository;
    }

    // ========= NÚT "ĐĂNG KÝ NGAY" GỌI VÀO ĐÂY =========
    @PostMapping("/course/{courseId}/checkout")
    public ResponseEntity<Map<String, String>> checkoutCourse(
            @PathVariable Long courseId,
            @AuthenticationPrincipal UserPrincipal user,
            HttpServletRequest request
    ) {
        if (user == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Unauthenticated");
        }

        Course course = courseRepository.findByIdAndDeletedAtIsNull(courseId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Course not found"));

        if (course.getPriceCents() == 0) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Course is free");
        }

        // Tạo Order PENDING
        Order order = new Order();
        order.setUser(user.getUser());
        order.setCourse(course);
        order.setStatus(OrderStatus.PENDING);
        order.setCurrency(course.getCurrency());
        order.setTotalAmountCents(course.getPriceCents());
        orderRepository.save(order);

        long amountVnd = course.getPriceCents() / 100L;
        String clientIp = request.getRemoteAddr();

        // Tạo Payment + URL VNPay
        String paymentUrl = vnPayService.createPayment(order.getId(), amountVnd, clientIp);

        Map<String, String> response = new HashMap<>();
        response.put("url", paymentUrl);
        response.put("orderId", order.getId().toString());
        return ResponseEntity.ok(response);
    }

    // ========= DÙNG NẾU MUỐN GỌI THỦ CÔNG BẰNG orderId + amount =========
    @PostMapping("/create")
    public ResponseEntity<Map<String, String>> createPayment(@RequestBody CreatePaymentRequest req,
                                                             HttpServletRequest request) {
        String ipAddress = request.getRemoteAddr();
        String paymentUrl = vnPayService.createPayment(req.getOrderId(), req.getAmount(), ipAddress);
        Map<String, String> response = new HashMap<>();
        response.put("url", paymentUrl);
        return ResponseEntity.ok(response);
    }

    // ========= USER REDIRECT VỀ =========
    @GetMapping("/return")
    public ResponseEntity<String> returnUrl(@RequestParam Map<String,String> allParams) {
        boolean valid = vnPayService.validateCallback(allParams);
        String txnRef = allParams.get("vnp_TxnRef");
        String rspCode = allParams.get("vnp_ResponseCode");

        Payment payment = paymentRepository.findByVnpTxnRef(txnRef)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Payment not found"));

        if (valid && "00".equals(rspCode)) {
            payment.setStatus(PaymentStatus.SUCCESS);
            paymentRepository.save(payment);
            handlePaymentSuccess(payment);
            return ResponseEntity.ok("Thanh toan thanh cong");
        } else {
            payment.setStatus(PaymentStatus.FAILED);
            paymentRepository.save(payment);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Thanh toan that bai");
        }
    }

    // ========= IPN (SERVER-TO-SERVER) =========
    @PostMapping("/ipn")
    public ResponseEntity<String> ipnUrl(@RequestParam Map<String,String> allParams) {
        if (!vnPayService.validateCallback(allParams)) {
            return ResponseEntity.badRequest().body("Invalid signature");
        }
        String txnRef = allParams.get("vnp_TxnRef");
        String rspCode = allParams.get("vnp_ResponseCode");

        Payment payment = paymentRepository.findByVnpTxnRef(txnRef)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Payment not found"));

        if ("00".equals(rspCode)) {
            payment.setStatus(PaymentStatus.SUCCESS);
            paymentRepository.save(payment);
            handlePaymentSuccess(payment);
        } else {
            payment.setStatus(PaymentStatus.FAILED);
            paymentRepository.save(payment);
        }

        return ResponseEntity.ok("{\"RspCode\": \"00\", \"Message\": \"Confirm Success\"}");
    }

    // ========= SAU KHI PAYMENT SUCCESS: CẬP NHẬT ORDER + ENROLL =========
    private void handlePaymentSuccess(Payment payment) {
        Order order = payment.getOrder();
        if (order == null) return;

        if (order.getStatus() != OrderStatus.PAID) {
            order.setStatus(OrderStatus.PAID);
            orderRepository.save(order);
        }

        // Nếu chưa có enrollment thì tạo (tránh trùng giữa return + ipn)
        if (payment.getEnrollment() == null) {
            Enrollment enrollment = java.util.Optional
                    .ofNullable(enrollmentRepository.findByUserAndCourse(order.getUser(), order.getCourse()))
                    .orElseGet(() -> {
                        Enrollment e = new Enrollment();
                        e.setUser(order.getUser());
                        e.setCourse(order.getCourse());
                        // set thêm field khác nếu có
                        return enrollmentRepository.save(e);
                    });

            payment.setEnrollment(enrollment);
            paymentRepository.save(payment);
        }
    }
}
