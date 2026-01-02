package com.example.elearning_api.entity;

import com.example.elearning_api.Enum.CourseStatus;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table( // cấu hình bảng
        name = "courses", // tên bảng
        uniqueConstraints = { @UniqueConstraint(name = "uq_courses_slug", columnNames = "slug") }, // slug duy nhất
        indexes = { @Index(name = "idx_courses_pub_created", columnList = "published, created_at DESC") } // list theo
                                                                                                          // publish/time
)
public class Course extends BaseEntity {
    @Column(nullable = false, length = 255)
    private String title; // tiêu đề khóa học

    // Slug một chuỗi ký tự thân thiện với người dùng và công cụ tìm kiếm, thường
    // được dùng trong URL.
    @Column(nullable = false, length = 255) // slug bắt buộc
    private String slug; // cột slug

    @Lob // TEXT dài
    @Column // map description
    private String description; // mô tả

    @Column(name = "price_cents", nullable = false) // giá (cent)
    private Integer priceCents = 0; // cột price_cents

    @Column(nullable = false, length = 10) // đơn vị tiền tệ
    private String currency = "USD"; // cột currency

    @Column(nullable = false) // cờ publish
    private boolean published = false; // cột published

    @Lob // URL có thể dài
    @Column(name = "thumbnail_url") // map thumbnail_url
    private String thumbnailUrl; // URL ảnh bìa

    @Enumerated(EnumType.STRING)
    @Column(length = 20, nullable = false) // trạng thái khóa học
    private CourseStatus status = CourseStatus.DRAFT; // DRAFT, PUBLISHED, ARCHIVED
}
