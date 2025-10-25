# 🎓 E-LEARNING PLATFORM API

Nền tảng học trực tuyến với Spring Boot + JWT Authentication + Role-based Access Control

---

## 🚀 QUICK START

### 1. Start MySQL

```powershell
Start-Service MySQL80
```

### 2. Create Database & Run Migration

```sql
CREATE DATABASE elearning;
USE elearning;
SOURCE src/main/resources/db/migration/v3.sql;
```

### 3. Start Application

```powershell
.\mvnw.cmd spring-boot:run
```

### 4. Mở Browser

```
http://localhost:8080/
```

---

## 🌐 WEB PAGES

| URL                    | Trang                | Quyền truy cập      |
| ---------------------- | -------------------- | ------------------- |
| `/`                    | Landing Page         | 🌍 Public           |
| `/course.html?id={id}` | Chi tiết khóa học    | 🌍 Public           |
| `/auth.html`           | Login/Register       | 🌍 Public           |
| `/admin.html`          | Admin Dashboard      | 🛡️ ADMIN only       |
| `/courses.html`        | Instructor Dashboard | 👨‍🏫 INSTRUCTOR/ADMIN |

---

## 🔑 TÀI KHOẢN MẶC ĐỊNH

| Username        | Password | Role       | Dashboard       |
| --------------- | -------- | ---------- | --------------- |
| admin           | admin123 | ADMIN      | `/admin.html`   |
| instructor_demo | {DB}     | INSTRUCTOR | `/courses.html` |

---

## 📋 API ENDPOINTS

### 🔐 Authentication (PUBLIC)

- `POST /api/auth/register` - Đăng ký
- `POST /api/auth/login` - Đăng nhập
- `GET /api/auth/me` - Xem profile

### 👨‍💼 Admin (ADMIN only)

- `GET /api/admin/users` - Danh sách users
- `PUT /api/admin/users/{id}/role` - Đổi role
- `GET /api/admin/statistics` - Thống kê

### 📚 Courses (INSTRUCTOR to create, Public to view)

- `GET /api/courses` - Danh sách courses (PUBLIC)
- `POST /api/courses` - Tạo course (INSTRUCTOR/ADMIN)
- `PUT /api/courses/{id}` - Update course (OWNER)
- `DELETE /api/courses/{id}` - Xóa course (OWNER)

### 🎥 Lessons

- `GET /api/courses/{id}/lessons` - Danh sách lessons (PUBLIC)
- `POST /api/courses/{id}/lessons/manual` - Thêm lesson (INSTRUCTOR/ADMIN)
- `GET /api/lessons/{id}/embed` - Lấy embed URL (AUTHENTICATED + Paywall check)

---

## 🎯 LUỒNG SỬ DỤNG

### 🌍 Khách vãng lai

```
1. http://localhost:8080/ → Landing page
2. Browse courses
3. Click "Xem chi tiết" → Chi tiết course
4. Xem Free Preview lessons
5. Paid lessons → Paywall → Đăng ký
```

### 👨‍🎓 Student

```
1. Register/Login
2. Browse courses
3. Xem Free Preview ✅
4. Paid lessons → Paywall (cần enroll)
```

### 👨‍🏫 Instructor

```
1. Login → Auto redirect /courses.html
2. Tạo course
3. Thêm lessons (YouTube IDs)
4. Quản lý nội dung
```

### 👨‍💼 Admin

```
1. Login admin/admin123 → Auto redirect /admin.html
2. Quản lý users
3. Promote users → INSTRUCTOR
4. Quản lý courses
5. Xem statistics
```

---

## 🎨 UI FEATURES

### Landing Page:

- ✨ Gradient hero section
- 📊 Animated stats counters
- 🎨 Modern course cards với hover effects
- 🔍 Filter: All / Free / Paid
- 📱 Fully responsive

### Course Detail:

- 📺 YouTube embed player
- 📋 Lessons sidebar
- 🔒 Paywall overlay cho paid content
- ✅ Free/Paid badges
- ⏱️ Duration display

### Auto Redirect:

- ADMIN → `/admin.html`
- INSTRUCTOR → `/courses.html`
- STUDENT → Stay on current page

### Guards:

- Admin page → Chỉ ADMIN
- Courses page → INSTRUCTOR/ADMIN
- Invalid token → Redirect `/auth.html`

---

## 🛠️ TECH STACK

### Backend:

- Java 17+
- Spring Boot 3.x
- Spring Security + JWT
- MySQL 8.x
- Hibernate/JPA

### Frontend:

- HTML5
- Bootstrap 5.3.3
- Vanilla JavaScript
- Bootstrap Icons
- YouTube Embed API

---

## 📝 FILES STRUCTURE

```
elearning-api/
├── src/main/resources/static/
│   ├── index.html              ← Landing page (MỚI, XỊN!)
│   ├── course.html             ← Course detail (MỚI)
│   ├── auth.html               ← Login/Register (ĐÃ FIX)
│   ├── admin.html              ← Admin dashboard
│   ├── courses.html            ← Instructor dashboard
│   ├── css/style.css
│   └── js/
│       ├── index.js            ← Landing logic (MỚI)
│       ├── course-detail.js    ← Course + Paywall (MỚI)
│       ├── auth.js             ← Auth (ĐÃ FIX auto redirect)
│       ├── admin.js            ← Admin (ĐÃ FIX guard)
│       └── courses.js          ← Courses (ĐÃ FIX guard)
├── COMPLETE_WEB_GUIDE.md       ← Đọc file này!
├── POSTMAN_IMPORT_GUIDE.md     ← Test API
└── ...
```

---

## 🧪 TESTING

### Test Backend API:

```powershell
# Import Postman collection
E-Learning-API-Complete.postman_collection.json

# Run all tests → 20/20 pass ✅
```

### Test Web UI:

1. **Landing page:** http://localhost:8080/
2. **Login admin:** → Auto redirect admin.html ✅
3. **Login instructor:** → Auto redirect courses.html ✅
4. **Login student:** → Stay with nav buttons ✅
5. **Course detail:** Click course → Xem lessons
6. **Paywall:** Free ✅ / Paid ❌

---

## 📖 DOCUMENTATION

| File                        | Mục đích                     |
| --------------------------- | ---------------------------- |
| **COMPLETE_WEB_GUIDE.md**   | Hướng dẫn sử dụng web đầy đủ |
| **POSTMAN_IMPORT_GUIDE.md** | Test API với Postman         |
| **HUONG_DAN_CHAY_WEB.md**   | Hướng dẫn chạy web           |
| **DEBUG_LOGIN_ERROR.md**    | Debug login issues           |

---

## 🔧 CONFIGURATION

### application.yml

```yaml
server:
  port: 8080

spring:
  datasource:
    url: jdbc:mysql://localhost:3306/elearning
    username: root
    password: Trithuc23@
  jpa:
    hibernate:
      ddl-auto: update # Auto create/update tables

app:
  jwt:
    secret: change-this-very-long-secret-string-1234567890
    expirySeconds: 86400 # 24 hours
```

---

## 🐛 TROUBLESHOOTING

### Lỗi 500 khi login

→ Xem `DEBUG_LOGIN_ERROR.md`

### Lỗi 401 Unauthorized

→ Token hết hạn, login lại

### Lỗi 403 Forbidden

→ Không đủ quyền, check role

### Admin không redirect

→ Check `auth.js` đã fix chưa, restart app

---

## 📦 BUILD

```powershell
# Build JAR file
mvn clean package -DskipTests

# Run JAR
java -jar target/elearning-api-0.0.1-SNAPSHOT.jar
```

---

## 🎉 FEATURES

✅ JWT Authentication  
✅ Role-based Access Control (ADMIN, INSTRUCTOR, STUDENT)  
✅ Auto redirect theo role  
✅ Landing page xịn xò  
✅ Course detail page với video player  
✅ Paywall cho paid content  
✅ Admin dashboard  
✅ Instructor dashboard  
✅ Responsive design  
✅ Modern UI với Bootstrap 5  
✅ Smooth transitions & animations

---

**MỞ http://localhost:8080/ ĐỂ XEM LANDING PAGE MỚI!** 🚀
