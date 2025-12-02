package com.example.elearning_api.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

/**
 * Entity ghi log các hoạt động quan trọng trong hệ thống E-Learning
 * 
 * <p>Chức năng chính:</p>
 * <ul>
 *   <li>Theo dõi tất cả các thao tác CRUD trên entities</li>
 *   <li>Lưu trữ thông tin người thực hiện (actor)</li>
 *   <li>Ghi nhận chi tiết thay đổi dưới dạng JSON diff</li>
 *   <li>Hỗ trợ audit trail cho compliance và debugging</li>
 * </ul>
 * 
 * <p>Use cases:</p>
 * <ul>
 *   <li>Kiểm tra ai đã thay đổi thông tin khóa học</li>
 *   <li>Truy vết các thao tác đáng ngờ</li>
 *   <li>Rollback dữ liệu khi cần thiết</li>
 *   <li>Báo cáo hoạt động cho admin</li>
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

    // ==================== ACTOR INFORMATION ====================

    /**
     * Người thực hiện hành động (actor)
     * Có thể null nếu là hành động của hệ thống (system action)
     * Ví dụ: scheduled jobs, webhook handlers
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
            name = "actor_user_id",
            foreignKey = @ForeignKey(name = "fk_audit_actor")
    )
    private User actor;

    // ==================== ACTION DETAILS ====================

    /**
     * Tên hành động được thực hiện
     * Convention: VERB_ENTITY (e.g., CREATE_USER, UPDATE_COURSE, DELETE_LESSON)
     * Độ dài tối đa: 128 ký tự
     */
    @Column(name = "action", nullable = false, length = 128)
    private String action;

    /**
     * Loại entity bị tác động
     * Ví dụ: User, Course, Enrollment, Payment
     * Độ dài tối đa: 64 ký tự
     */
    @Column(name = "entity_type", nullable = false, length = 64)
    private String entityType;

    /**
     * ID của entity bị tác động
     * Dùng để truy vết và link đến entity cụ thể
     * Có thể null cho các action không liên quan đến entity cụ thể
     */
    @Column(name = "entity_id")
    private Long entityId;

    // ==================== CHANGE DETAILS ====================

    /**
     * Chi tiết thay đổi dưới dạng JSON
     * Format: {"field": {"old": "value1", "new": "value2"}}
     * Lưu trữ giá trị cũ và mới của các field bị thay đổi
     */
    @Lob
    @Column(columnDefinition = "JSON")
    private String diff;

}
