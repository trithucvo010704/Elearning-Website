package com.example.elearning_api.entity;

import com.example.elearning_api.Enum.Provider;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

/**
 * Entity lưu trữ các sự kiện webhook từ các nhà cung cấp bên ngoài
 * Hiện tại hỗ trợ Stripe webhook cho thanh toán
 * 
 * @author phongdh
 * @version 1.0
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

    /**
     * ID tự tăng của webhook event
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * Nhà cung cấp webhook
     * Mặc định là STRIPE cho thanh toán
     */
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 16)
    private Provider provider = Provider.STRIPE;

    /**
     * ID sự kiện từ nhà cung cấp
     * Unique để tránh xử lý trùng lặp
     */
    @Column(name = "event_id", nullable = false, unique = true, length = 255)
    private String eventId;

    /**
     * Chữ ký xác thực webhook
     * Dùng để verify webhook đến từ nguồn hợp lệ
     */
    @Column(length = 255)
    private String signature;

    /**
     * Nội dung payload của webhook
     * Lưu dưới dạng JSON để parse khi cần
     */
    @Lob
    @Column(columnDefinition = "JSON", nullable = false)
    private String payload;

    /**
     * Trạng thái đã xử lý hay chưa
     * false: chờ xử lý, true: đã xử lý
     */
    @Column(nullable = false)
    private boolean processed = false;

    /**
     * Thời điểm xử lý webhook
     * Null nếu chưa được xử lý
     */
    @Column(name = "processed_at")
    private LocalDateTime processedAt;

}
