package com.example.elearning_api.entity;
import jakarta.persistence.*;

import java.time.LocalDateTime;           // kiểu thời gian
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@MappedSuperclass // đánh dấu lớp cha cho các entity khác kế thừa
public class BaseEntity {
    // FK tự sinh
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "created_at", nullable = false, updatable = false) // map với cột created_at
    private LocalDateTime createdAt; // Ngày khởi tạo

    @Column(name = "updated_at", nullable = false) // map cột updated_at
    protected LocalDateTime updatedAt; // thời điểm cập nhật

    @Column(name = "deleted_at") // map cột deleted_at (soft-delete)
    protected LocalDateTime deletedAt; // thời điểm xóa mềm (có thể null)

    @PrePersist // Annotation để khi Java chạy nó sẽ tự duyệt và xét thời điểm khởi tạo
    protected void prePersist() { // Đặt protected vì giúp ghi đè
        LocalDateTime currentTime = LocalDateTime.now(); // lấy ngày giờ hiện tại
        this.createdAt = currentTime;
        this.updatedAt = currentTime;
    }

    @PreUpdate // Tương tự PrePersist dùng để cập nhật
    protected void preUpdate() {
        LocalDateTime currentTime = LocalDateTime.now();
        this.updatedAt = currentTime;
    }
}
