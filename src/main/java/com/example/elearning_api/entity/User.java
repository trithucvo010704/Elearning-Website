package com.example.elearning_api.entity;

import com.example.elearning_api.Enum.Role;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.util.Collection;
import java.util.List;

@Getter
@Setter
@Entity // Đánh dấu là entity
@Table( // cấu hình bảng
                name = "users", // tên bảng
                uniqueConstraints = { // constraint unique
                                @UniqueConstraint(name = "uq_users_username", columnNames = "username") // username duy nhất
                }, indexes = { // các index bổ trợ
                                @Index(name = "idx_users_role_created", columnList = "role, created_at") // tìm theo role/time
                })
public class User extends BaseEntity implements org.springframework.security.core.userdetails.UserDetails {

        @Column(nullable = false, length = 64)
        private String username; // Cột Username
        @Column(name = "password_hash", nullable = false, length = 255) // hash mật khẩu
        private String passwordHash;
        @Column(name = "full_name", length = 255) // họ tên (tùy chọn)
        private String fullName; // cột full_name

        @Enumerated(EnumType.STRING) // lưu enum dạng STRING
        @Column(nullable = false, length = 16) // cột role bắt buộc
        private Role role = Role.STUDENT; // mặc định STUDENT
        @Column(nullable = false) // Kiểm tra user active
        private boolean enabled = true;

        // --- Spring Security ---
        @Override
        public Collection<? extends GrantedAuthority> getAuthorities() {
                return List.of(new SimpleGrantedAuthority("ROLE_" + role.name()));
        }

        @Override
        public String getPassword() {
                return passwordHash;
        }

        @Override
        public String getUsername() {
                return username;
        }

        @Override
        public boolean isAccountNonExpired() {
                return true;
        }

        @Override
        public boolean isAccountNonLocked() {
                return true;
        }

        @Override
        public boolean isCredentialsNonExpired() {
                return true;
        }

        @Override
        public boolean isEnabled() {
                return enabled;
        }
}
