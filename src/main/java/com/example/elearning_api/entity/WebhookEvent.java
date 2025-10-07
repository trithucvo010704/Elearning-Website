package com.example.elearning_api.entity;


import com.example.elearning_api.Enum.Provider;
import jakarta.persistence.*;                                                // import JPA
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;                                              // kiểu thời gian
@Getter
@Setter
@Entity                                                                       // đánh dấu entity
@Table(                                                                       // cấu hình bảng
        name = "webhook_events",                                                    // tên bảng
        indexes = { @Index(name = "idx_webhook_processed", columnList = "processed, created_at") } // xử lý hàng đợi
)
public class WebhookEvent extends BaseEntity {                                 // entity kế thừa BaseEntity
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)                                                 // enum STRING
    @Column(nullable = false, length = 16)                                       // cột provider
    private Provider provider = Provider.STRIPE;                                  // mặc định STRIPE

    @Column(name = "event_id", nullable = false, unique = true, length = 255)    // id sự kiện duy nhất
    private String eventId;                                                      // cột event_id

    @Column(length = 255)                                                        // chữ ký webhook
    private String signature;                                                    // cột signature

    @Lob                                                                         // JSON dài
    @Column(columnDefinition = "JSON", nullable = false)                         // kiểu JSON MySQL
    private String payload;                                                      // nội dung payload

    @Column(nullable = false)                                                    // trạng thái xử lý
    private boolean processed = false;                                           // cột processed

    @Column(name = "processed_at")                                               // thời điểm xử lý
    private LocalDateTime processedAt;                                           // cột processed_at

}

