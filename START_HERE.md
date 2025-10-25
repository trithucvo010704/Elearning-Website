# 🚀 BẮT ĐẦU TẠI ĐÂY!

## ⚡ QUICK START - 3 BƯỚC

### 1️⃣ Start Spring Boot App

```powershell
.\mvnw.cmd spring-boot:run
```

### 2️⃣ Mở Browser

```
http://localhost:8080/
```

### 3️⃣ Enjoy! 🎉

---

## 🌐 CÁC TRANG WEB ĐÃ TẠO

### 🏠 Landing Page (MỚI - XỊN!)

```
http://localhost:8080/
```

- Hero section với gradient đẹp
- Danh sách khóa học
- Filter: All/Free/Paid
- Statistics counters
- **DÀNH CHO:** Khách, Student

---

### 📖 Chi Tiết Khóa Học (MỚI)

```
http://localhost:8080/course.html?id=1
```

- Video player (YouTube embed)
- Danh sách lessons
- Free preview ✅
- Paid lessons → Paywall 🔒
- **DÀNH CHO:** Tất cả

---

### 🔐 Đăng Nhập/Đăng Ký

```
http://localhost:8080/auth.html
```

- Login form
- Register form
- **AUTO REDIRECT sau login:**
  - ADMIN → `/admin.html`
  - INSTRUCTOR → `/courses.html`
  - STUDENT → `auth.html#/me`

---

### 🛡️ Admin Dashboard

```
http://localhost:8080/admin.html
```

- Quản lý users
- Quản lý courses
- Statistics
- **GUARD:** Chỉ ADMIN

---

### 📚 Instructor Dashboard

```
http://localhost:8080/courses.html
```

- Tạo courses
- Thêm lessons
- Quản lý nội dung
- **GUARD:** INSTRUCTOR/ADMIN

---

## 🔑 LOGIN ĐỂ TEST

### Admin:

```
Username: admin
Password: admin123
→ Tự động vào /admin.html
```

### Instructor:

```
Username: instructor_demo
Password: {check database}
→ Tự động vào /courses.html
```

### Student:

```
Đăng ký tài khoản mới
→ Ở lại auth.html với navigation buttons
```

---

## 📊 FLOW DIAGRAM

```
┌─────────────────────────────────────┐
│  http://localhost:8080/             │
│  🏠 Landing Page (Public)           │
├─────────────────────────────────────┤
│  - Browse courses                   │
│  - Click "Xem chi tiết"             │
│  - Click "Đăng nhập/Đăng ký"        │
└──────────────┬──────────────────────┘
               │
               ├─→ /course.html?id=1
               │   📖 Chi tiết course
               │   - Free preview ✅
               │   - Paid → Paywall 🔒
               │
               └─→ /auth.html
                   🔐 Login/Register
                   │
                   ├─→ ADMIN → /admin.html
                   │   🛡️ Admin Dashboard
                   │
                   ├─→ INSTRUCTOR → /courses.html
                   │   📚 My Courses
                   │
                   └─→ STUDENT → auth.html#/me
                       👤 Profile + Nav buttons
```

---

## 📁 FILES QUAN TRỌNG

| File                                                | Mục đích                |
| --------------------------------------------------- | ----------------------- |
| **README.md**                                       | Tổng quan project       |
| **START_HERE.md**                                   | ← BẠN ĐANG ĐỌC FILE NÀY |
| **COMPLETE_WEB_GUIDE.md**                           | Hướng dẫn web chi tiết  |
| **POSTMAN_IMPORT_GUIDE.md**                         | Test API                |
| **E-Learning-API-Complete.postman_collection.json** | Import vào Postman      |

---

## ✅ ĐÃ FIX TẤT CẢ

- ✅ JWT Authentication
- ✅ Password hash matching
- ✅ UserPrincipal injection
- ✅ Duplicate slug auto-suffix
- ✅ Database auto-sync (ddl-auto: update)
- ✅ course_instructors table
- ✅ Security guards
- ✅ Auto redirect theo role
- ✅ Public APIs (GET courses, lessons)
- ✅ Landing page xịn xò
- ✅ Course detail page
- ✅ Paywall logic

---

## 🎯 DEMO SCENARIOS

### Scenario 1: Khách xem course

```
1. Mở http://localhost:8080/
2. Click course "Java Spring Boot"
3. Click lesson "Introduction" (Free) → Xem video ✅
4. Click lesson "Advanced" (Paid) → Paywall ❌
5. Click "Đăng ký khóa học" → Login/Register
```

### Scenario 2: Admin quản lý

```
1. Login: admin/admin123
2. → Tự động /admin.html
3. Promote user → INSTRUCTOR
4. Xem statistics
5. Manage courses
```

### Scenario 3: Instructor tạo course

```
1. Login instructor
2. → Tự động /courses.html
3. Add New Course
4. Add Lessons (YouTube IDs)
5. Về trang chủ → Tìm course
6. Xem tất cả lessons (Owner)
```

---

## 🆘 NEED HELP?

### App không start?

→ Check MySQL đang chạy

### Login lỗi 500?

→ Gọi `/api/auth/hash/admin123` để lấy hash mới

### Create course lỗi?

→ Check bảng `course_instructors` đã tồn tại chưa

### Web không hiển thị?

→ Check port 8080, clear browser cache

---

## 📞 CONTACT

Nếu cần hỗ trợ, check các file MD hoặc xem console logs!

---

**🎉 CHÚC BẠN SỬ DỤNG VUI VẺ! 🎉**

**MỞ http://localhost:8080/ NGAY ĐỂ TRẢI NGHIỆM!** 🚀
