# Hướng dẫn sửa password cho instructor_demo

## Vấn đề
Password hash trong database không đúng định dạng BCrypt, gây lỗi khi đăng nhập.

## Giải pháp

### Cách 1: Sử dụng API endpoint (Khuyến nghị)
1. Khởi động server Spring Boot
2. Gọi endpoint để generate hash:
   ```
   GET http://localhost:8080/api/auth/hash/Instructor123!
   ```
3. Copy hash từ response
4. Chạy SQL update:
   ```sql
   UPDATE users 
   SET password_hash = '<hash_từ_response>' 
   WHERE username = 'instructor_demo';
   ```

### Cách 2: Sử dụng file SQL update
Chạy file SQL đã được tạo:
```bash
mysql -u root -p your_database_name < src/main/resources/db/migration/fix_instructor_demo_password.sql
```

### Cách 3: Tạo hash mới và cập nhật thủ công
1. Sử dụng BCrypt online generator: https://bcrypt-generator.com/
   - Password: `Instructor123!`
   - Rounds: `10`
2. Copy hash được generate (60 ký tự, bắt đầu bằng `$2a$10$`)
3. Chạy SQL:
   ```sql
   UPDATE users 
   SET password_hash = '<hash_mới>' 
   WHERE username = 'instructor_demo';
   ```

## Thông tin tài khoản
- **Username**: `instructor_demo`
- **Password**: `Instructor123!`
- **Role**: `INSTRUCTOR`

## Lưu ý
- BCrypt hash phải có đúng 60 ký tự
- Hash phải bắt đầu bằng `$2a$10$` (hoặc `$2b$10$`, `$2y$10$`)
- Hash trong `schema.sql` đã được cập nhật với format đúng

