package com.example.elearning_api.entity;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(                                                                       // cấu hình bảng
        name = "audit_logs",                                                        // tên bảng
        indexes = {
                @Index(name = "idx_audit_entity", columnList = "entity_type, entity_id"), // tìm theo thực thể
                @Index(name = "idx_audit_actor",  columnList = "actor_user_id, created_at") // tìm theo actor/time
        }
)
public class AuditLog extends BaseEntity {

    @Id                                                                          // khóa chính
    @GeneratedValue(strategy = GenerationType.IDENTITY)                          // auto-increment
    private Long id;                                                             // cột id

    @ManyToOne(fetch = FetchType.LAZY)                                           // actor có thể null (system)
    @JoinColumn(name = "actor_user_id", foreignKey = @ForeignKey(name = "fk_audit_actor")) // FK actor
    private User actor;                                                          // người thực hiện (nếu có)

    @Column(name = "action", nullable = false, length = 128)                     // tên hành động
    private String action;                                                       // cột action

    @Column(name = "entity_type", nullable = false, length = 64)                 // loại thực thể
    private String entityType;                                                   // cột entity_type

    @Column(name = "entity_id")                                                  // id thực thể
    private Long entityId;                                                       // cột entity_id

    @Lob                                                                         // JSON diff có thể dài
    @Column(columnDefinition = "JSON")                                           // kiểu JSON MySQL
    private String diff;                                                         // thay đổi chi tiết

}
