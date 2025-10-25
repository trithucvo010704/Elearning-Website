# 🌐 HƯỚNG DẪN SỬ DỤNG WEB HOÀN CHỈNH

## ✅ ĐÃ TẠO GIAO DIỆN MỚI

### 📁 Files mới:

1. **index.html** - Landing page cho khách + student (XỊN XÒ!)
2. **course.html** - Trang chi tiết khóa học với video player
3. **js/index.js** - Logic cho landing page
4. **js/course-detail.js** - Logic xem course & paywall

---

## 🚀 CÁCH CHẠY WEB

### Bước 1: Restart Spring Boot

```powershell
# Stop app (Ctrl+C nếu đang chạy)
.\mvnw.cmd spring-boot:run
```

Đợi thấy: `Started ElearningApiApplication`

---

### Bước 2: Mở Browser

**Vào trang chủ:**

```
http://localhost:8080/
```

HOẶC

```
http://localhost:8080/index.html
```

---

## 🌐 CÁC TRANG WEB

### 1. 🏠 LANDING PAGE (Public - Tất cả mọi người)

**URL:** `http://localhost:8080/`

**Chức năng:**

- ✨ Hero section với gradient đẹp
- 📊 Statistics (số khóa học, học viên, giảng viên)
- 📚 Danh sách khóa học (public)
- 🎯 Filter: Tất cả / Miễn phí / Trả phí
- 🔗 Nút "Đăng nhập" / "Đăng ký"
- 🎓 Features section

**Nếu đã login:**

- Hiện tên user và role
- Hiện button "Dashboard" (redirect theo role)
- Hiện button "Đăng xuất"

---

### 2. 📖 CHI TIẾT KHÓA HỌC (Public/Student)

**URL:** `http://localhost:8080/course.html?id=1`

**Chức năng:**

- 📺 Video player (YouTube embed)
- 📋 Danh sách lessons sidebar
- 🆓 Free preview lessons → Xem được ngay
- 🔒 Paid lessons → Hiện paywall
- 💳 Nút "Đăng ký khóa học"

**Paywall logic:**

- Free preview: ✅ Mọi người xem được
- Paid lesson + chưa login: ❌ Redirect login
- Paid lesson + chưa enroll: ❌ Hiện paywall
- Owner/Enrolled: ✅ Xem được

---

### 3. 🔐 ĐĂNG NHẬP/ĐĂNG KÝ

**URL:** `http://localhost:8080/auth.html`

**Tự động redirect sau login:**

- **ADMIN** → `/admin.html` (Admin Dashboard)
- **INSTRUCTOR** → `/courses.html` (My Courses)
- **STUDENT** → `auth.html#/me` (Profile với navigation buttons)

---

### 4. 🛡️ ADMIN DASHBOARD (ADMIN only)

**URL:** `http://localhost:8080/admin.html`

**Guard:** Chỉ ADMIN truy cập được

**Chức năng:**

- Users management
- Courses management
- Statistics
- Revenue charts

---

### 5. 📚 INSTRUCTOR DASHBOARD (INSTRUCTOR/ADMIN)

**URL:** `http://localhost:8080/courses.html`

**Guard:** Chỉ INSTRUCTOR/ADMIN

**Chức năng:**

- Tạo courses
- Thêm lessons
- Quản lý nội dung

---

## 🔄 LUỒNG SỬ DỤNG ĐẦY ĐỦ

### 🎓 Luồng Khách (Guest)

```
1. Vào: http://localhost:8080/
2. Xem danh sách khóa học
3. Click "Xem chi tiết" → course.html?id=1
4. Click vào Free Preview lesson → Xem video ✅
5. Click vào Paid lesson → Paywall ❌
6. Click "Đăng ký ngay" → auth.html#/register
```

---

### 👨‍🎓 Luồng Student

```
1. Register tài khoản → Lưu token
2. Tự động ở lại auth.html#/me
3. Click "Browse Courses" → Về trang chủ
4. Browse courses
5. Click "Xem chi tiết" → course.html?id=1
6. Click Free Preview → Xem được ✅
7. Click Paid lesson → Paywall (cần enroll)
```

---

### 👨‍🏫 Luồng Instructor

```
1. Login instructor_demo → Token
2. ✅ Tự động redirect → courses.html
3. Tạo course mới
4. Thêm lessons (YouTube IDs)
5. Về trang chủ → Xem course của mình
6. Click vào course → Xem tất cả lessons (Owner)
```

---

### 👨‍💼 Luồng Admin

```
1. Login admin/admin123
2. ✅ Tự động redirect → admin.html
3. Manage users
4. Promote user → INSTRUCTOR
5. Manage courses
6. View statistics
```

---

## 🎨 THIẾT KẾ THAM KHẢO

Landing page được design theo style:

- **Udemy** - Hero section với CTA
- **Coursera** - Course cards với hover effects
- **edX** - Statistics counters
- **Modern UI** - Gradient, shadows, smooth transitions

---

## 📱 RESPONSIVE

Tất cả trang đều responsive:

- Mobile: 1 column
- Tablet: 2 columns
- Desktop: 3-4 columns

---

## 🎯 DEMO SCENARIO

### Scenario 1: Khách vãng lai

```
1. http://localhost:8080/
   ↓ Xem courses
2. http://localhost:8080/course.html?id=1
   ↓ Xem Free Preview
3. Click Paid lesson → Paywall
4. Click "Đăng ký khóa học" → Login/Register
```

### Scenario 2: Student đã login

```
1. Login → Token saved
2. Browse courses trên landing page
3. Click course → course.html
4. Free lessons: ✅ Xem được
5. Paid lessons: ❌ Paywall (cần enroll)
```

### Scenario 3: Instructor

```
1. Login instructor
   ↓ Auto → courses.html
2. Tạo course
3. Thêm lessons
4. Về trang chủ → Tìm course
5. Click vào → Xem tất cả lessons (Owner)
```

---

## 🌐 SITEMAP

```
http://localhost:8080/
├── /                          (Landing page - Public)
├── /index.html                (Same as /)
├── /course.html?id={courseId} (Course detail - Public)
├── /auth.html                 (Login/Register - Public)
│   ├── #/login                (Login form)
│   ├── #/register             (Register form)
│   └── #/me                   (Profile)
├── /admin.html                (Admin dashboard - ADMIN only)
│   ├── #/statistics           (Stats)
│   ├── #/users                (User management)
│   └── #/courses              (Course management)
└── /courses.html              (Instructor - INSTRUCTOR/ADMIN)
```

---

## 🔑 TÀI KHOẢN TEST

| Username        | Password    | Role       | Redirect sau login |
| --------------- | ----------- | ---------- | ------------------ |
| admin           | admin123    | ADMIN      | `/admin.html`      |
| instructor_demo | {check DB}  | INSTRUCTOR | `/courses.html`    |
| student_test    | Student123! | STUDENT    | `auth.html#/me`    |

---

## ✅ CHECKLIST

- [x] Landing page đẹp với gradient
- [x] Course cards với hover effects
- [x] Course detail page với video player
- [x] Paywall logic cho paid lessons
- [x] Auto redirect theo role
- [x] Guards cho admin/instructor pages
- [x] Responsive design
- [ ] **Restart Spring Boot app**
- [ ] Test trên browser

---

## 🎯 QUICK START

```powershell
# 1. Start app
.\mvnw.cmd spring-boot:run

# 2. Mở browser - Landing page
http://localhost:8080/

# 3. Browse courses → Click "Xem chi tiết"
# 4. Test Free Preview lessons
# 5. Test Paid lessons (Paywall)
# 6. Click "Đăng nhập" → Test auto redirect
```

---

## 📸 UI FEATURES

### Landing Page:

- ✨ Gradient hero section
- 📊 Animated stats counters
- 🎨 Feature cards với icons
- 📚 Course grid với filters
- 🔍 Search và filter courses

### Course Detail:

- 📺 Full-width video player
- 📋 Scrollable lessons sidebar
- 🔒 Paywall overlay với blur effect
- ✅ Free/Paid badges
- ⏱️ Duration display

### Responsive:

- 📱 Mobile-first design
- 💻 Desktop-optimized layout
- 🎨 Smooth transitions
- 🌓 Dark mode ready

---

**RESTART APP VÀ VÀO http://localhost:8080/ ĐỂ XEM LANDING PAGE MỚI XỊN XÒ!** 🎉

Sau đó test:

1. Browse courses
2. Click "Xem chi tiết"
3. Xem Free Preview
4. Test Paywall
5. Login với roles khác nhau → Auto redirect!
