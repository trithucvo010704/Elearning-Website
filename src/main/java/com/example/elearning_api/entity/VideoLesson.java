package com.example.elearning_api.entity;

import jakarta.persistence.*;

@Entity                                                             // đánh dấu entity
@Table(                                                             // cấu hình bảng
        name = "video_lessons",                                           // tên bảng
        uniqueConstraints = { @UniqueConstraint(name = "uq_lesson_course_order", columnNames = {"course_id","order_index"}) }, // unique theo course + thứ tự
        indexes = {
                @Index(name = "idx_lessons_course",       columnList = "course_id, id"),        // index tra cứu theo khóa học
                @Index(name = "idx_lessons_course_order", columnList = "course_id, order_index")// index cho sắp xếp
        }
)
public class VideoLesson {
        @Id                                                               // khóa chính
        @GeneratedValue(strategy = GenerationType.IDENTITY)               // auto-increment
        private Long id;                                                  // cột id

        @ManyToOne(fetch = FetchType.LAZY, optional = false)              // nhiều bài học thuộc 1 khóa
        @JoinColumn(name = "course_id", nullable = false,                 // map khóa ngoại course_id
                foreignKey = @ForeignKey(name = "fk_lessons_course"))           // tên FK rõ ràng
        private Course course;                                            // quan hệ tới Course

        @Column(nullable = false, length = 255)                           // tiêu đề bắt buộc
        private String title;                                             // cột title

        @Column(name = "order_index", nullable = false)                   // thứ tự hiển thị
        private Integer orderIndex;                                       // cột order_index

        @Column(name = "s3_key", nullable = false, length = 512)          // key file S3
        private String s3Key;                                             // cột s3_key

        @Column(name = "duration_sec")                                    // thời lượng giây (tùy chọn)
        private Integer durationSec;                                      // cột duration_sec

        @Column(name = "free_preview", nullable = false)                  // cờ cho phép xem trước
        private boolean freePreview = false;                              // cột free_preview
}
