package com.example.elearning_api.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

/**
 * Entity theo dõi tiến độ học tập của học viên trong hệ thống E-Learning
 * 
 * <p>Chức năng chính:</p>
 * <ul>
 *   <li>Lưu trữ thời gian xem video của từng bài học</li>
 *   <li>Đánh dấu trạng thái hoàn thành bài học</li>
 *   <li>Hỗ trợ resume video từ vị trí đã xem trước đó</li>
 *   <li>Tính toán phần trăm hoàn thành khóa học</li>
 * </ul>
 * 
 * <p>Quan hệ:</p>
 * <ul>
 *   <li>ManyToOne với Enrollment - mỗi tiến độ thuộc một ghi danh</li>
 *   <li>ManyToOne với VideoLesson - theo dõi từng bài học cụ thể</li>
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
        name = "lesson_progress",
        uniqueConstraints = {
                @UniqueConstraint(
                        name = "uq_enroll_lesson",
                        columnNames = {"enrollment_id", "lesson_id"}
                )
        },
        indexes = {
                @Index(
                        name = "idx_lp_enroll_updated",
                        columnList = "enrollment_id, updated_at"
                )
        }
)
public class LessonProgress extends BaseEntity {

    // ==================== RELATIONSHIPS ====================

    /**
     * Liên kết đến enrollment (ghi danh) của học viên
     * Mỗi tiến độ thuộc về một enrollment cụ thể
     * Không thể null - bắt buộc phải có enrollment
     */
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(
            name = "enrollment_id",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_lp_enroll")
    )
    private Enrollment enrollment;

    /**
     * Liên kết đến bài học video cần theo dõi
     * Theo dõi tiến độ của từng bài học riêng biệt
     * Không thể null - bắt buộc phải có lesson
     */
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(
            name = "lesson_id",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_lp_lesson")
    )
    private VideoLesson lesson;

    // ==================== PROGRESS FIELDS ====================

    /**
     * Số giây đã xem của video
     * Dùng để resume video từ vị trí đã xem
     * Mặc định là 0 khi chưa xem
     */
    @Column(name = "watched_sec", nullable = false)
    private Integer watchedSec = 0;

    /**
     * Trạng thái hoàn thành bài học
     * true: đã hoàn thành xem hết video
     * false: chưa hoàn thành (mặc định)
     */
    @Column(nullable = false)
    private boolean completed = false;

}
