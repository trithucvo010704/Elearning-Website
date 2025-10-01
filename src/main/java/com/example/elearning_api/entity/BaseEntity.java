package com.example.elearning_api.entity;
import jakarta.persistence.Column;        // import annotation cột
import jakarta.persistence.MappedSuperclass; // để kế thừa mapping
import jakarta.persistence.PrePersist;    // hook trước khi insert
import jakarta.persistence.PreUpdate;     // hook trước khi update
import java.time.LocalDateTime;           // kiểu thời gian
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@MappedSuperclass // đánh dấu lớp cha cho các entity khác kế thừa
public class BaseEntity {
    @Column(name="created_at",nullable = false,updatable = false) // map voi cot Created_at
    private LocalDateTime createdAt; // Ngay khoi tao
    @Column(name = "updated_at", nullable = false) // map cột updated_at
    protected LocalDateTime updatedAt; // thời điểm cập nhật
    @Column(name = "deleted_at") // map cột deleted_at (soft-delete)
    protected LocalDateTime deletedAt; // thời điểm xóa mềm (có thể null)
    @PrePersist  // Anootation de khi ma Java chay no se tu duyet va xet thoi diem khoi tao
    protected void prePersist() { // Dat protected vi giup ghi de
        LocalDateTime now = LocalDateTime.now(); // lay ngay gio hien tai
        this.createdAt = now;
        this.updatedAt = now;
    }
    @PreUpdate // Tuong tu Prepersit dung de cap nhat
    protected void preUpdate() {
        LocalDateTime now = LocalDateTime.now();
        this.updatedAt = now ;
    }
}
