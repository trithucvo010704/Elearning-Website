# 🌐 HƯỚNG DẪN CHẠY GIAO DIỆN WEB

## ✅ ĐÃ FIX AUTO REDIRECT THEO ROLE

### Thay đổi đã thực hiện:

1. **auth.js** - Auto redirect sau login/register
2. **auth.html** - Thêm navigation buttons
3. **admin.js** - Guard chỉ cho ADMIN
4. **courses.js** - Guard cho INSTRUCTOR/ADMIN

---

## 🚀 CÁCH CHẠY GIAO DIỆN WEB

### Bước 1: Start Spring Boot Application

```powershell
cd D:\DACN\elearning-api
.\mvnw.cmd spring-boot:run
```

Đợi thấy: `Started ElearningApiApplication in X.XXX seconds`

---

### Bước 2: Mở Browser và Truy Cập

**Mở trình duyệt (Chrome/Edge/Firefox) và vào:**

```
http://localhost:8080/auth.html
```

---

## 📱 CÁC TRANG GIAO DIỆN

### 1. Trang Đăng Nhập/Đăng Ký (Tất cả users)

```
http://localhost:8080/auth.html
```

**Chức năng:**

- Đăng nhập
- Đăng ký tài khoản mới
- Xem profile

---

### 2. Admin Dashboard (Chỉ ADMIN)

```
http://localhost:8080/admin.html
```

**Chức năng:**

- Quản lý users
- Quản lý courses
- Xem statistics
- Promote users lên INSTRUCTOR

**⚠️ Bảo vệ:** Nếu không phải ADMIN → Tự động redirect về auth.html

---

### 3. Instructor/Course Management (INSTRUCTOR + ADMIN)

```
http://localhost:8080/courses.html
```

**Chức năng:**

- Tạo courses mới
- Quản lý courses của mình
- Thêm lessons vào courses
- Xem preview video

**⚠️ Bảo vệ:** Chỉ INSTRUCTOR/ADMIN truy cập được

---

## 🔄 LUỒNG SỬ DỤNG HOÀN CHỈNH

### Luồng 1: Admin Login

```
1. Vào: http://localhost:8080/auth.html
2. Đăng nhập: admin / admin123
3. ✅ Tự động redirect → http://localhost:8080/admin.html
4. Xem statistics, quản lý users
```

---

### Luồng 2: Instructor Workflow

```
1. Vào: http://localhost:8080/auth.html
2. Đăng nhập: instructor_demo / {password}
3. ✅ Tự động redirect → http://localhost:8080/courses.html
4. Click "Add Course" → Tạo course mới
5. Click "Add Lesson" → Thêm video lessons
6. Preview lessons
```

---

### Luồng 3: Student Registration

```
1. Vào: http://localhost:8080/auth.html
2. Click "Đăng ký"
3. Điền thông tin → Register
4. ✅ Redirect → auth.html#/me (Profile page)
5. Click "Browse Courses" → Xem danh sách courses
```

---

## 🎯 AUTO REDIRECT LOGIC

| Role           | Login →         | Register →      | Có buttons                  |
| -------------- | --------------- | --------------- | --------------------------- |
| **ADMIN**      | `/admin.html`   | `/admin.html`   | Admin Dashboard, My Courses |
| **INSTRUCTOR** | `/courses.html` | `/courses.html` | My Courses                  |
| **STUDENT**    | `auth.html#/me` | `auth.html#/me` | Browse Courses              |

---

## 🛡️ SECURITY GUARDS

### Admin Dashboard (admin.html)

- Check token tồn tại
- Decode JWT → Lấy role
- Nếu role !== "ADMIN" → Redirect về courses.html
- Nếu không có token → Redirect về auth.html

### Courses Page (courses.html)

- Check token tồn tại
- Decode JWT → Lấy role
- Nếu role !== "INSTRUCTOR" && !== "ADMIN" → Redirect về auth.html

---

## 📋 TEST GIAO DIỆN

### Test 1: Admin Access

```
1. Login với: admin / admin123
2. ✅ Phải tự động vào admin.html
3. ✅ Thấy statistics dashboard
4. ✅ Click "Users" → Xem danh sách users
5. ✅ Click "Courses" → Xem danh sách courses
```

---

### Test 2: Instructor Access

```
1. Login với: instructor_demo / {password}
   (Hoặc register user mới, admin promote lên INSTRUCTOR)
2. ✅ Phải tự động vào courses.html
3. ✅ Xem "My Courses"
4. ✅ Có thể tạo course mới
5. ✅ Có thể thêm lessons
```

---

### Test 3: Student Access

```
1. Register tài khoản mới
2. ✅ Ở lại auth.html#/me
3. ✅ Thấy button "Browse Courses"
4. ❌ Không thể vào /admin.html (bị guard chặn)
5. ❌ Không thể vào /courses.html (bị guard chặn)
```

---

### Test 4: Unauthorized Access

```
1. Không login
2. Vào: http://localhost:8080/admin.html
3. ✅ Guard chặn → Alert → Redirect về /auth.html
```

---

## 🎨 STATIC FILES STRUCTURE

```
src/main/resources/static/
├── auth.html          ← Trang login/register
├── admin.html         ← Admin dashboard
├── courses.html       ← Instructor courses management
├── index.html         ← Landing page (nếu có)
├── css/
│   └── style.css      ← Custom styles
└── js/
    ├── auth.js        ← Login/register logic (ĐÃ FIX)
    ├── admin.js       ← Admin functions (ĐÃ FIX)
    └── courses.js     ← Course management (ĐÃ FIX)
```

---

## 🌐 URLS CHÍNH

| URL                                  | Trang             | Quyền truy cập   |
| ------------------------------------ | ----------------- | ---------------- |
| `http://localhost:8080/`             | Landing page      | Public           |
| `http://localhost:8080/auth.html`    | Login/Register    | Public           |
| `http://localhost:8080/admin.html`   | Admin Dashboard   | ADMIN only       |
| `http://localhost:8080/courses.html` | Course Management | INSTRUCTOR/ADMIN |

---

## 🔑 TÀI KHOẢN ĐỂ TEST

### Admin

```
URL: http://localhost:8080/auth.html
Username: admin
Password: admin123
→ Tự động vào /admin.html
```

### Instructor (nếu có)

```
URL: http://localhost:8080/auth.html
Username: instructor_demo
Password: {từ database}
→ Tự động vào /courses.html
```

### Student (tự tạo)

```
URL: http://localhost:8080/auth.html
Click "Đăng ký"
→ Ở lại /auth.html#/me
```

---

## ✅ CHECKLIST

- [x] Backend API đang chạy (port 8080)
- [x] MySQL database đang chạy
- [x] Admin user đã tồn tại
- [x] Auth.js đã fix auto redirect
- [x] Admin.js đã có guard
- [x] Courses.js đã có guard
- [ ] **Restart Spring Boot app**
- [ ] Vào http://localhost:8080/auth.html
- [ ] Login và test auto redirect

---

## 🎯 QUICK START

```powershell
# 1. Start app
.\mvnw.cmd spring-boot:run

# 2. Mở browser
# http://localhost:8080/auth.html

# 3. Login admin / admin123

# 4. ✅ Tự động vào admin dashboard!
```

---

**BẠN CHỈ CẦN:**

1. Restart Spring Boot app
2. Mở: http://localhost:8080/auth.html
3. Login → Tự động redirect! 🎉
