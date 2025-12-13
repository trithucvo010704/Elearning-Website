# Mật khẩu chưa hash cho các User trong file.sql

## Lưu ý
- Tất cả mật khẩu trong file.sql đều được hash bằng BCrypt
- Hash hiện tại trong file.sql: `$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi`
- **QUAN TRỌNG**: Hash này có thể không phải là hash của "password123". 
- Để sử dụng mật khẩu "password123", bạn cần tạo hash mới bằng BCrypt và cập nhật vào file.sql
- Hoặc bạn có thể đăng nhập và đổi mật khẩu qua ứng dụng

## Danh sách User và Mật khẩu

### Users từ schema.sql (Default Users)

1. **admin**
   - Username: `admin`
   - Password: `admin123`
   - Role: ADMIN

2. **instructor_demo**
   - Username: `instructor_demo`
   - Password: `Instructor123!`
   - Role: INSTRUCTOR

### Users từ file.sql (Sample Data)

Tất cả các user sau đều dùng mật khẩu: **password123**

#### STUDENTS (User ID 1-10, 25-29)

1. **john_doe** (ID: 1)
   - Full Name: John Doe
   - Role: STUDENT
   - Password: `password123`

2. **jane_smith** (ID: 2)
   - Full Name: Jane Smith
   - Role: STUDENT
   - Password: `password123`

3. **mike_wilson** (ID: 3)
   - Full Name: Mike Wilson
   - Role: STUDENT
   - Password: `password123`

4. **sarah_johnson** (ID: 4)
   - Full Name: Sarah Johnson
   - Role: STUDENT
   - Password: `password123`

5. **david_brown** (ID: 5)
   - Full Name: David Brown
   - Role: STUDENT
   - Password: `password123`

6. **lisa_garcia** (ID: 6)
   - Full Name: Lisa Garcia
   - Role: STUDENT
   - Password: `password123`

7. **tom_anderson** (ID: 7)
   - Full Name: Tom Anderson
   - Role: STUDENT
   - Password: `password123`

8. **emma_davis** (ID: 8)
   - Full Name: Emma Davis
   - Role: STUDENT
   - Password: `password123`

9. **alex_miller** (ID: 9)
   - Full Name: Alex Miller
   - Role: STUDENT
   - Password: `password123`

10. **sophie_taylor** (ID: 10)
    - Full Name: Sophie Taylor
    - Role: STUDENT
    - Password: `password123`


#### INSTRUCTORS (User ID 11-20)

1. **prof_nguyen** (ID: 11)
   - Full Name: Prof. Nguyen Van A
   - Role: INSTRUCTOR
   - Password: `password123`

2. **dr_smith** (ID: 12)
   - Full Name: Dr. Sarah Smith
   - Role: INSTRUCTOR
   - Password: `password123`

3. **master_lee** (ID: 13)
   - Full Name: Master Lee Chen
   - Role: INSTRUCTOR
   - Password: `password123`

4. **expert_kim** (ID: 14)
   - Full Name: Expert Kim Soo
   - Role: INSTRUCTOR
   - Password: `password123`

5. **teacher_yamada** (ID: 15)
   - Full Name: Teacher Yamada
   - Role: INSTRUCTOR
   - Password: `password123`

6. **instructor_patel** (ID: 16)
   - Full Name: Instructor Patel
   - Role: INSTRUCTOR
   - Password: `password123`

7. **coach_rodriguez** (ID: 17)
   - Full Name: Coach Rodriguez
   - Role: INSTRUCTOR
   - Password: `password123`

8. **mentor_johnson** (ID: 18)
   - Full Name: Mentor Johnson
   - Role: INSTRUCTOR
   - Password: `password123`

9. **tutor_wang** (ID: 19)
   - Full Name: Tutor Wang Li
   - Role: INSTRUCTOR
   - Password: `password123`

#### ADMINS (User ID 20-24)

1. **admin_system** (ID: 20)
   - Full Name: System Administrator
   - Role: ADMIN
   - Password: `password123`

2. **admin_support** (ID: 21)
   - Full Name: Support Admin
   - Role: ADMIN
   - Password: `password123`

3. **admin_content** (ID: 22)
   - Full Name: Content Admin
   - Role: ADMIN
   - Password: `password123`

4. **admin_tech** (ID: 23)
   - Full Name: Tech Admin
   - Role: ADMIN
   - Password: `password123`

5. **admin_finance** (ID: 24)
   - Full Name: Finance Admin
   - Role: ADMIN
   - Password: `password123`

#### STUDENTS (tiếp theo - User ID 25-29)

11. **student_robert** (ID: 25)
    - Full Name: Robert Kim
    - Role: STUDENT
    - Password: `password123`

12. **student_maria** (ID: 26)
    - Full Name: Maria Santos
    - Role: STUDENT
    - Password: `password123`

13. **student_james** (ID: 27)
    - Full Name: James Wilson
    - Role: STUDENT
    - Password: `password123`

14. **student_anna** (ID: 28)
    - Full Name: Anna Chen
    - Role: STUDENT
    - Password: `password123`

15. **student_kevin** (ID: 29)
    - Full Name: Kevin Park
    - Role: STUDENT
    - Password: `password123`

## Tóm tắt

- **Tổng số user**: 30 users (từ file.sql) + 2 users (từ schema.sql) = 32 users
- **Mật khẩu mặc định cho tất cả user trong file.sql**: `password123`
- **Mật khẩu admin**: `admin123`
- **Mật khẩu instructor_demo**: `Instructor123!`

## Cách sử dụng

1. Đăng nhập với bất kỳ user nào bằng username và mật khẩu tương ứng
2. Để thay đổi mật khẩu, sử dụng chức năng đổi mật khẩu trong ứng dụng
3. Hash mật khẩu được tạo bằng BCrypt với cost factor 10

