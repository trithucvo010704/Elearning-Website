package com.example.elearning_api.entity;

import com.example.elearning_api.Enum.Provider;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

/**
 * Entity lưu trữ và quản lý các sự kiện webhook từ bên thứ ba
 * 
 * <p>Chức năng chính:</p>
 * <ul>
 *   <li>Nhận và lưu trữ webhook events từ payment providers (Stripe)</li>
 *   <li>Đảm bảo idempotency - không xử lý trùng lặp event</li>
 *   <li>Verify chữ ký để đảm bảo webhook từ nguồn hợp lệ</li>
 *   <li>Queue processing cho các event chưa xử lý</li>
 * </ul>
 * 
 * <p>Supported Providers:</p>
 * <ul>
 *   <li>STRIPE - Payment processing webhooks</li>
 * </ul>
 * 
 * <p>Event Types (Stripe):</p>
 * <ul>
 *   <li>checkout.session.completed - Thanh toán thành công</li>
 *   <li>payment_intent.succeeded - Payment intent hoàn tất</li>
 *   <li>charge.refunded - Hoàn tiền</li>
 * </ul>
 * 
 * @author phongdh
 * @version 1.1
 * @since 2024-12-02
 */
@Getter
@Setter
@Entity
@Table(
        name = "webhook_events",
        indexes = {
                @Index(
                        name = "idx_webhook_processed",
                        columnList = "processed, created_at"
                )
        }
)
public class WebhookEvent extends BaseEntity {

    // ==================== PRIMARY KEY ====================

    /**
     * ID tự tăng của webhook event trong database
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // ==================== PROVIDER INFORMATION ====================

    /**
     * Nhà cung cấp webhook (payment provider)
     * Mặc định là STRIPE cho thanh toán
     * Có thể mở rộng thêm providers khác trong tương lai
     */
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 16)
    private Provider provider = Provider.STRIPE;

    /**
     * ID sự kiện từ nhà cung cấp (provider's event ID)
     * Unique để đảm bảo idempotency - tránh xử lý trùng lặp
     * Ví dụ Stripe: evt_1234567890
     */
    @Column(name = "event_id", nullable = false, unique = true, length = 255)
    private String eventId;

    /**
     * Chữ ký xác thực webhook (signature)
     * Dùng để verify webhook đến từ nguồn hợp lệ
     * Stripe sử dụng HMAC-SHA256 signature
     */
    @Column(length = 255)
    private String signature;

    // ==================== PAYLOAD ====================

    /**
     * Nội dung payload của webhook
     * Lưu nguyên bản JSON từ provider để parse khi cần
     * Chứa toàn bộ thông tin về event
     */
    @Lob
    @Column(columnDefinition = "JSON", nullable = false)
    private String payload;

    // ==================== PROCESSING STATUS ====================

    /**
     * Trạng thái xử lý webhook
     * false: chờ xử lý (pending)
     * true: đã xử lý thành công (processed)
     */
    @Column(nullable = false)
    private boolean processed = false;

    /**
     * Thời điểm webhook được xử lý
     * Null nếu chưa được xử lý
     * Set khi processed = true
     */
    @Column(name = "processed_at")
    private LocalDateTime processedAt;

}
