package com.example.elearning_api.entity;

import com.example.elearning_api.Enum.Role;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity // Danh dau la entity
@Table(                                                // cấu hình bảng
        name = "users",                                      // tên bảng
        uniqueConstraints = {                                // constraint unique
                @UniqueConstraint(name = "uq_users_username", columnNames = "username") // username duy nhất
        },
        indexes = {                                          // các index bổ trợ
                @Index(name = "idx_users_role_created", columnList = "role, created_at") // tìm theo role/time
        }
)
public class User extends BaseEntity {
    @Id // FK
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Tu dong tang
    private Long id ;

    @Column(nullable = false, length = 64)
    private String username; // Cot Username
    @Column(name = "password_hash", nullable = false, length = 255) // hash mật khẩu
    private String passwordHash;
    @Column(name = "full_name", length = 255)            // họ tên (tùy chọn)
    private String fullName;                             // cột full_name

    @Enumerated(EnumType.STRING)                         // lưu enum dạng STRING
    @Column(nullable = false, length = 16)               // cột role bắt buộc
    private Role role = Role.STUDENT;                    // mặc định STUDENT

}
