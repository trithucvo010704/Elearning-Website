// src/main/java/com/yourorg/elearning/entity/LessonProgress.java
package com.example.elearning_api.entity;                                   // gói entity

import jakarta.persistence.*;                                             // import JPA
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(                                                                   // cấu hình bảng
        name = "lesson_progress",                                               // tên bảng
        uniqueConstraints = { @UniqueConstraint(name = "uq_enroll_lesson", columnNames = {"enrollment_id","lesson_id"}) }, // unique per enrollment+lesson
        indexes = { @Index(name = "idx_lp_enroll_updated", columnList = "enrollment_id, updated_at") } // tra cứu theo enrollment/time
)
public class LessonProgress extends BaseEntity {                           // entity kế thừa BaseEntity

    @Id                                                                      // khóa chính
    @GeneratedValue(strategy = GenerationType.IDENTITY)                      // auto-increment
    private Long id;                                                         // cột id

    @ManyToOne(fetch = FetchType.LAZY, optional = false)                     // thuộc 1 enrollment
    @JoinColumn(name = "enrollment_id", nullable = false,                    // map FK enrollment_id
            foreignKey = @ForeignKey(name = "fk_lp_enroll"))                       // tên FK
    private Enrollment enrollment;                                           // quan hệ Enrollment

    @ManyToOne(fetch = FetchType.LAZY, optional = false)                     // tham chiếu 1 lesson
    @JoinColumn(name = "lesson_id", nullable = false,                        // map FK lesson_id
            foreignKey = @ForeignKey(name = "fk_lp_lesson"))                       // tên FK
    private VideoLesson lesson;                                              // quan hệ VideoLesson

    @Column(name = "watched_sec", nullable = false)                          // số giây đã xem
    private Integer watchedSec = 0;                                          // cột watched_sec

    @Column(nullable = false)                                                // trạng thái hoàn tất
    private boolean completed = false;                                       // cột completed

}
