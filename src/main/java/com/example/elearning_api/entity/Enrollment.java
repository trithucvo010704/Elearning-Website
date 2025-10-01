package com.example.elearning_api.entity;

import com.example.elearning_api.Enum.EnrollmentStatus;
import jakarta.persistence.Entity;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
// Bang nối user - course
@Getter @Setter
@Entity                                                                   // đánh dấu entity
@Table(                                                                   // cấu hình bảng
        name = "enrollments",                                                   // tên bảng
        uniqueConstraints = { @UniqueConstraint(name = "uq_enroll_user_course", columnNames = {"user_id","course_id"}) }, // user+course duy nhất
        indexes = {
                @Index(name = "idx_enroll_status_created", columnList = "status, created_at"), // thống kê theo trạng thái
                @Index(name = "idx_enroll_user_created",   columnList = "user_id, created_at") // danh sách khóa học của tôi
        }
)
public class Enrollment extends BaseEntity {                               // entity kế thừa BaseEntity

    @Id                                                                      // khóa chính
    @GeneratedValue(strategy = GenerationType.IDENTITY)                      // auto-increment
    private Long id;                                                         // cột id

    @ManyToOne(fetch = FetchType.LAZY, optional = false)                     // nhiều enroll thuộc 1 user
    @JoinColumn(name = "user_id", nullable = false,                          // map FK user_id
            foreignKey = @ForeignKey(name = "fk_enroll_user"))                     // tên FK rõ ràng
    private User user;                                                       // quan hệ User

    @ManyToOne(fetch = FetchType.LAZY, optional = false)                     // nhiều enroll thuộc 1 course
    @JoinColumn(name = "course_id", nullable = false,                        // map FK course_id
            foreignKey = @ForeignKey(name = "fk_enroll_course"))                   // tên FK rõ ràng
    private Course course;                                                   // quan hệ Course

    @Enumerated(EnumType.STRING)                                             // lưu enum kiểu STRING
    @Column(nullable = false, length = 16)                                   // cột status bắt buộc
    private EnrollmentStatus status = EnrollmentStatus.PENDING;              // mặc định PENDING
}