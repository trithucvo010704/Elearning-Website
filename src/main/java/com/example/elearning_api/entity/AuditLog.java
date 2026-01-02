package com.example.elearning_api.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

/**
 * Entity ghi log các hoạt động trong hệ thống
 * Dùng để theo dõi, kiểm tra và debug các thao tác của người dùng
 * 
 * @author phongdh
 * @version 1.0
 */
@Getter
@Setter
@Entity
@Table(
        name = "audit_logs",
        indexes = {
                @Index(
                        name = "idx_audit_entity",
                        columnList = "entity_type, entity_id"
                ),
                @Index(
                        name = "idx_audit_actor",
                        columnList = "actor_user_id, created_at"
                )
        }
)
public class AuditLog extends BaseEntity {

    /**
     * Người thực hiện hành động
     * Có thể null nếu là hành động của hệ thống (system action)
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
            name = "actor_user_id",
            foreignKey = @ForeignKey(name = "fk_audit_actor")
    )
    private User actor;

    /**
     * Tên hành động được thực hiện
     * Ví dụ: CREATE_USER, UPDATE_COURSE, DELETE_LESSON
     */
    @Column(name = "action", nullable = false, length = 128)
    private String action;

    /**
     * Loại entity bị tác động
     * Ví dụ: User, Course, Enrollment
     */
    @Column(name = "entity_type", nullable = false, length = 64)
    private String entityType;

    /**
     * ID của entity bị tác động
     * Dùng để truy vết entity cụ thể
     */
    @Column(name = "entity_id")
    private Long entityId;

    /**
     * Chi tiết thay đổi dưới dạng JSON
     * Lưu trữ giá trị cũ và mới của các field bị thay đổi
     */
    @Lob
    @Column(columnDefinition = "JSON")
    private String diff;

}
