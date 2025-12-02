package com.example.elearning_api.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

/**
 * Entity theo dõi tiến độ học tập của học viên
 * Lưu trữ thông tin về thời gian xem video và trạng thái hoàn thành bài học
 * 
 * @author phongdh
 * @version 1.0
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

    /**
     * Liên kết đến enrollment (ghi danh) của học viên
     * Mỗi tiến độ thuộc về một enrollment cụ thể
     */
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(
            name = "enrollment_id",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_lp_enroll")
    )
    private Enrollment enrollment;

    /**
     * Liên kết đến bài học video
     * Theo dõi tiến độ của từng bài học riêng biệt
     */
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(
            name = "lesson_id",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_lp_lesson")
    )
    private VideoLesson lesson;

    /**
     * Số giây đã xem của video
     * Dùng để resume video từ vị trí đã xem
     */
    @Column(name = "watched_sec", nullable = false)
    private Integer watchedSec = 0;

    /**
     * Trạng thái hoàn thành bài học
     * true: đã hoàn thành, false: chưa hoàn thành
     */
    @Column(nullable = false)
    private boolean completed = false;

}
