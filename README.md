# E-LEARNING PLATFORM

Nen tang hoc truc tuyen voi Spring Boot + JWT Authentication + Role-based Access Control + VNPay Payment Integration

---

## CAC BUOC CHAY DU AN

### Buoc 1: Khoi dong MySQL

```powershell
Start-Service MySQL80
```

Hoac khoi dong MySQL tu Services (Windows) hoac MySQL Workbench.

### Buoc 2: Tao Database

Mo MySQL Workbench hoac MySQL Command Line va chay cac lenh sau:

```sql
CREATE DATABASE elearning CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE elearning;
SOURCE D:/learning/semeter/semeter7/do_an_chuyen_nganh/Elearning-Website/src/main/resources/db/migration/v3.sql;
SOURCE D:/learning/semeter/semeter7/do_an_chuyen_nganh/Elearning-Website/src/main/resources/db/migration/v4_course_instructors.sql;
```

Luu y: Thay doi duong dan SOURCE cho phu hop voi vi tri thu muc du an cua ban.

### Buoc 3: Cau hinh ket noi Database

Mo file `src/main/resources/application.yml` va kiem tra cau hinh:

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/elearning
    username: root
    password: YOUR_MYSQL_PASSWORD
  jpa:
    hibernate:
      ddl-auto: update
```

Thay `YOUR_MYSQL_PASSWORD` bang mat khau MySQL cua ban.

### Buoc 4: Build va Chay Ung Dung

```powershell
cd D:\learning\semeter\semeter7\do_an_chuyen_nganh\Elearning-Website
.\mvnw.cmd clean compile
.\mvnw.cmd spring-boot:run
```

Doi cho den khi thay thong bao:

```
Started ElearningApiApplication in X.XXX seconds
```

### Buoc 5: Mo Trinh Duyet

Mo trinh duyet web (Chrome, Firefox, Edge) va truy cap:

```
http://localhost:8080/
```

---

## CAU TRUC DU AN

### Thu muc Backend

```
src/main/java/com/example/elearning_api/
├── config/                    # Cau hinh Spring Security, CORS, VNPay
│   ├── SecurityConfig.java    # Cau hinh JWT, authentication
│   ├── VnPayConfig.java       # Cau hinh VNPay payment gateway
│   ├── VideoProps.java        # Cau hinh video provider
│   └── WebConfig.java         # Cau hinh CORS
├── controller/                # REST API Controllers
│   ├── AdminController.java   # API quan ly admin
│   ├── AuthController.java    # API dang nhap, dang ky
│   ├── CourseController.java  # API quan ly khoa hoc
│   ├── LessonController.java  # API quan ly bai hoc
│   └── VnPayController.java   # API thanh toan VNPay
├── dto/                       # Data Transfer Objects
│   ├── admin/                 # DTO cho admin
│   ├── auth/                  # DTO cho authentication
│   ├── course/                # DTO cho course
│   ├── lesson/                # DTO cho lesson
│   └── payment/               # DTO cho payment
├── entity/                    # JPA Entities (Database tables)
│   ├── User.java              # Bang users
│   ├── Course.java            # Bang courses
│   ├── VideoLesson.java       # Bang video_lessons
│   ├── Enrollment.java        # Bang enrollments
│   ├── Order.java             # Bang orders
│   ├── OrderItem.java         # Bang order_items
│   ├── Payment.java           # Bang payments
│   └── CourseInstructor.java  # Bang course_instructors
├── Enum/                      # Enumerations
│   ├── Role.java              # STUDENT, INSTRUCTOR, ADMIN
│   ├── EnrollmentStatus.java  # PENDING, ACTIVE, REFUNDED
│   ├── OrderStatus.java       # PENDING, PAID, CANCELED, REFUNDED
│   └── PaymentStatus.java     # PENDING, SUCCESS, FAILED
├── exception/                 # Exception handling
│   └── GlobalExceptionHandler.java
├── repository/                # JPA Repositories
│   ├── UserRepository.java
│   ├── CourseRepository.java
│   ├── VideoLessonRepo.java
│   ├── EnrollmentRepository.java
│   ├── OrderRepository.java
│   └── PaymentRepository.java
├── security/                  # Security components
│   ├── JwtService.java        # JWT token generation & validation
│   ├── JwtAuthenticationFilter.java
│   ├── UserPrincipal.java     # Custom user details
│   └── CourseSecurity.java    # Course access control
├── service/                   # Business logic
│   ├── auth/                  # Authentication services
│   ├── admin/                 # Admin services
│   ├── GatingService.java     # Video access control
│   ├── LessonService.java     # Lesson management
│   ├── VnPayService.java      # VNPay payment processing
│   └── YoutubeProvider.java   # YouTube video integration
└── util/                      # Utility classes
    └── SlugUtil.java          # URL slug generation
```

### Thu muc Frontend

```
src/main/resources/static/
├── index.html                 # Trang chu (Landing page)
├── auth.html                  # Trang dang nhap/dang ky
├── course.html                # Trang chi tiet khoa hoc
├── courses.html               # Trang quan ly khoa hoc (Instructor)
├── admin.html                 # Trang quan ly admin
├── css/
│   └── style.css              # Custom CSS styles
└── js/
    ├── index.js               # Logic trang chu
    ├── auth.js                # Logic dang nhap/dang ky
    ├── course-detail.js       # Logic chi tiet khoa hoc
    ├── courses.js             # Logic quan ly khoa hoc
    └── admin.js               # Logic admin dashboard
```

### Thu muc Database

```
src/main/resources/db/migration/
├── v1+v2.sql                  # Schema version 1 & 2
├── v3.sql                     # Schema version 3 (main)
└── v4_course_instructors.sql  # Course instructors table
```

---

## CHUC NANG CHINH

### 1. Authentication & Authorization

- Dang ky tai khoan moi
- Dang nhap voi username va password
- JWT token-based authentication
- Role-based access control (STUDENT, INSTRUCTOR, ADMIN)
- Auto redirect theo role sau khi dang nhap

### 2. Quan Ly Khoa Hoc (Course Management)

#### Danh cho Instructor/Admin:
- Tao khoa hoc moi
- Chinh sua thong tin khoa hoc
- Xoa khoa hoc
- Them bai hoc vao khoa hoc
- Quan ly gia khoa hoc
- Upload thumbnail
- Set trang thai public/draft

#### Danh cho Student:
- Xem danh sach khoa hoc
- Loc khoa hoc (Tat ca / Mien phi / Tra phi)
- Xem chi tiet khoa hoc
- Dang ky khoa hoc

### 3. Quan Ly Bai Hoc (Lesson Management)

- Them bai hoc bang YouTube URL hoac Video ID
- Tu dong extract Video ID tu URL
- Sap xep thu tu bai hoc
- Dat thoi luong bai hoc
- Cho phep xem thu mien phi (Free Preview)
- Xem truoc video (Instructor)
- Xoa bai hoc

### 4. Video Player

- Nhung video YouTube
- Kiem soat quyen xem (Gating)
- Paywall cho noi dung tra phi
- Xem thu mien phi cho bai hoc duoc danh dau
- Auto-play va dieu huong giua cac bai hoc

### 5. Thanh Toan VNPay

- Tich hop cong thanh toan VNPay
- Tao don hang (Order)
- Xu ly thanh toan
- Redirect sau thanh toan thanh cong/that bai
- Tu dong cap nhat trang thai enrollment
- IPN (Instant Payment Notification) webhook

### 6. Enrollment System

- Dang ky khoa hoc tu dong sau thanh toan
- Kiem tra trang thai enrollment
- Hien thi trang thai "Da dang ky" tren UI
- Cap nhat quyen truy cap video sau khi enrolled

### 7. Admin Dashboard

- Quan ly nguoi dung
- Thay doi role nguoi dung
- Xem thong ke he thong
- Quan ly tat ca khoa hoc
- Xem danh sach enrollments
- Xem lich su thanh toan

### 8. UI/UX Features

- Responsive design (Mobile, Tablet, Desktop)
- Modern gradient design
- Smooth animations va transitions
- Toast notifications
- Loading states
- Error handling voi thong bao ro rang
- Auto-suggestion cho form inputs
- Client-side validation

---

## DATABASE SCHEMA

### Bang USERS
Luu tru thong tin nguoi dung

```sql
- id: BIGINT (Primary Key)
- username: VARCHAR(64) UNIQUE
- password_hash: VARCHAR(255)
- full_name: VARCHAR(255)
- role: ENUM('STUDENT', 'INSTRUCTOR', 'ADMIN')
- enabled: TINYINT(1)
- created_at: DATETIME
- updated_at: DATETIME
- deleted_at: DATETIME (Soft delete)
```

### Bang COURSES
Luu tru thong tin khoa hoc

```sql
- id: BIGINT (Primary Key)
- title: VARCHAR(255)
- slug: VARCHAR(255) UNIQUE
- description: TEXT
- price_cents: INT (Gia theo cent, VD: 100000 = 1000 VND)
- currency: VARCHAR(10) (VD: VND, USD)
- published: TINYINT(1)
- thumbnail_url: TEXT
- created_at: DATETIME
- updated_at: DATETIME
- deleted_at: DATETIME
```

### Bang VIDEO_LESSONS
Luu tru thong tin bai hoc video

```sql
- id: BIGINT (Primary Key)
- course_id: BIGINT (Foreign Key -> courses.id)
- title: VARCHAR(255)
- order_index: INT
- s3_key: VARCHAR(512) (Luu YouTube video ID voi format "yt:VIDEO_ID")
- duration_sec: INT (Thoi luong tinh bang giay)
- free_preview: TINYINT(1) (Cho phep xem thu mien phi)
- created_at: DATETIME
- updated_at: DATETIME
- deleted_at: DATETIME
UNIQUE: (course_id, order_index)
```

### Bang COURSE_INSTRUCTORS
Quan he nhieu-nhieu giua Course va User (Instructor)

```sql
- id: BIGINT (Primary Key)
- course_id: BIGINT (Foreign Key -> courses.id)
- user_id: BIGINT (Foreign Key -> users.id)
- role: ENUM('OWNER', 'TEACHER', 'ASSISTANT')
- created_at: DATETIME
- updated_at: DATETIME
UNIQUE: (course_id, user_id)
```

### Bang ENROLLMENTS
Luu trang thai dang ky khoa hoc cua nguoi dung

```sql
- id: BIGINT (Primary Key)
- user_id: BIGINT (Foreign Key -> users.id)
- course_id: BIGINT (Foreign Key -> courses.id)
- status: ENUM('PENDING', 'ACTIVE', 'REFUNDED')
- created_at: DATETIME
- updated_at: DATETIME
- deleted_at: DATETIME
UNIQUE: (user_id, course_id)
```

### Bang ORDERS
Luu thong tin don hang

```sql
- id: BIGINT (Primary Key)
- user_id: BIGINT (Foreign Key -> users.id)
- status: ENUM('PENDING', 'REQUIRES_PAYMENT', 'PAID', 'CANCELED', 'REFUNDED')
- total_amount_cents: INT
- currency: VARCHAR(10)
- created_at: DATETIME
- updated_at: DATETIME
- deleted_at: DATETIME
```

### Bang ORDER_ITEMS
Chi tiet cac item trong don hang

```sql
- id: BIGINT (Primary Key)
- order_id: BIGINT (Foreign Key -> orders.id)
- course_id: BIGINT (Foreign Key -> courses.id)
- unit_price_cents: INT
- quantity: INT
- title_snapshot: VARCHAR(255)
- created_at: DATETIME
- updated_at: DATETIME
```

### Bang PAYMENTS
Luu lich su thanh toan

```sql
- id: BIGINT (Primary Key)
- user_id: BIGINT (Foreign Key -> users.id)
- course_id: BIGINT (Foreign Key -> courses.id)
- order_id: BIGINT (Foreign Key -> orders.id)
- enrollment_id: BIGINT (Foreign Key -> enrollments.id)
- provider: ENUM('VNPAY', 'MOMO', 'STRIPE')
- status: ENUM('PENDING', 'SUCCESS', 'FAILED')
- amount_cents: INT
- currency: VARCHAR(10)
- vnp_txn_ref: VARCHAR(255) UNIQUE (Ma giao dich VNPay)
- created_at: DATETIME
- updated_at: DATETIME
```

### Cac Bang Khac

- **LESSON_PROGRESS**: Theo doi tien do hoc tap
- **CHAT_HISTORY**: Lich su chat (neu co)
- **AUDIT_LOG**: Log hanh dong quan trong
- **WEBHOOK_EVENT**: Log webhook events tu payment gateway

---

## API ENDPOINTS

### Authentication APIs (Public)

```
POST   /api/auth/register          - Dang ky tai khoan moi
POST   /api/auth/login             - Dang nhap
GET    /api/auth/me                - Lay thong tin user hien tai
```

### Course APIs

```
GET    /api/courses                           - Lay danh sach khoa hoc (Public)
GET    /api/courses/{id}/enrollment-status    - Kiem tra trang thai enrollment
POST   /api/courses                           - Tao khoa hoc moi (INSTRUCTOR/ADMIN)
PUT    /api/courses/{id}                      - Cap nhat khoa hoc (OWNER)
DELETE /api/courses/{id}                      - Xoa khoa hoc (OWNER)
```

### Lesson APIs

```
GET    /api/courses/{courseId}/lessons        - Lay danh sach bai hoc (Public)
POST   /api/courses/{courseId}/lessons/manual - Them bai hoc (INSTRUCTOR/ADMIN)
GET    /api/lessons/{id}/embed                - Lay embed URL (Authenticated)
GET    /api/lessons/{id}/preview              - Xem truoc (INSTRUCTOR/ADMIN)
DELETE /api/lessons/{id}                      - Xoa bai hoc (INSTRUCTOR/ADMIN)
```

### Payment APIs

```
POST   /api/payment/vnpay/course/{courseId}/checkout  - Tao payment cho khoa hoc
GET    /api/payment/vnpay/return                      - Return URL sau thanh toan
POST   /api/payment/vnpay/ipn                         - IPN webhook tu VNPay
```

### Admin APIs (ADMIN only)

```
GET    /api/admin/users              - Lay danh sach users
PUT    /api/admin/users/{id}/role    - Thay doi role user
GET    /api/admin/statistics         - Lay thong ke he thong
```

---

## CAU HINH

### Application Configuration (application.yml)

```yaml
server:
  port: 8080

spring:
  datasource:
    url: jdbc:mysql://localhost:3306/elearning
    username: root
    password: YOUR_PASSWORD
    driver-class-name: com.mysql.cj.jdbc.Driver
  jpa:
    hibernate:
      ddl-auto: update
    show-sql: false
    properties:
      hibernate:
        format_sql: true
        dialect: org.hibernate.dialect.MySQL8Dialect

app:
  jwt:
    secret: change-this-very-long-secret-string-1234567890
    expirySeconds: 86400

  vnpay:
    tmnCode: YOUR_TMN_CODE
    hashSecret: YOUR_HASH_SECRET
    payUrl: https://sandbox.vnpayment.vn/paymentv2/vpcpay.html
    returnUrl: http://localhost:8080/api/payment/vnpay/return
    ipnUrl: http://localhost:8080/api/payment/vnpay/ipn
    version: 2.1.0
    command: pay
    currCode: VND
    locale: vn
```

### VNPay Configuration

De su dung chuc nang thanh toan VNPay, ban can:

1. Dang ky tai khoan VNPay Sandbox: https://sandbox.vnpayment.vn/
2. Lay thong tin TMN Code va Hash Secret
3. Cap nhat vao file `application.yml`
4. Cau hinh Return URL va IPN URL

---

## TAI KHOAN MAC DINH

### Admin Account

```
URL: http://localhost:8080/auth.html
Username: admin
Password: admin123
Dashboard: /admin.html
```

Admin account duoc tao tu dong khi khoi dong ung dung lan dau.

### Tao Tai Khoan Instructor

1. Dang nhap voi tai khoan Admin
2. Vao Admin Dashboard
3. Tim user can promote
4. Thay doi Role thanh INSTRUCTOR
5. User do se co quyen tao va quan ly khoa hoc

---

## LUONG SU DUNG

### Student Workflow

```
1. Truy cap trang chu: http://localhost:8080/
2. Xem danh sach khoa hoc
3. Dang ky tai khoan (neu chua co)
4. Dang nhap
5. Chon khoa hoc muon hoc
6. Xem Free Preview lessons
7. Click "Dang ky ngay" cho khoa hoc tra phi
8. Thanh toan qua VNPay
9. Sau thanh toan thanh cong, tu dong enrolled
10. Xem tat ca video trong khoa hoc
```

### Instructor Workflow

```
1. Admin promote user len INSTRUCTOR
2. Dang nhap voi tai khoan Instructor
3. Tu dong redirect den /courses.html
4. Click "Create Course"
5. Dien thong tin khoa hoc (title, description, price, thumbnail)
6. Click "Add Lesson"
7. Nhap thong tin bai hoc:
   - Title
   - YouTube URL hoac Video ID
   - Thu tu (tu dong suggest)
   - Thoi luong
   - Free preview (neu muon)
8. Submit de them bai hoc
9. Lap lai cho cac bai hoc khac
10. Xem truoc video de kiem tra
```

### Admin Workflow

```
1. Dang nhap voi admin/admin123
2. Tu dong redirect den /admin.html
3. Xem thong ke he thong:
   - Tong so users
   - Tong so courses
   - Tong so enrollments
   - Doanh thu
4. Quan ly users:
   - Xem danh sach users
   - Thay doi role
   - Vo hieu hoa tai khoan
5. Quan ly courses:
   - Xem tat ca courses
   - Xoa courses vi pham
```

---

## CONG NGHE SU DUNG

### Backend Technologies

- Java 17
- Spring Boot 3.5.6
- Spring Security (JWT Authentication)
- Spring Data JPA (Hibernate)
- MySQL 8.x
- Maven (Build tool)
- Lombok (Reduce boilerplate code)
- Jakarta Validation (Bean validation)

### Frontend Technologies

- HTML5
- CSS3
- JavaScript (ES6+)
- Bootstrap 5.3.3
- Bootstrap Icons
- YouTube Embed API

### Payment Gateway

- VNPay Payment Gateway
- VNPay Sandbox for testing

---

## XU LY LOI THUONG GAP

### Loi: Cannot connect to MySQL

**Nguyen nhan:** MySQL service chua chay hoac cau hinh ket noi sai

**Giai phap:**
```powershell
# Kiem tra MySQL dang chay
Get-Service MySQL80

# Khoi dong MySQL neu chua chay
Start-Service MySQL80

# Kiem tra username/password trong application.yml
```

### Loi: 401 Unauthorized

**Nguyen nhan:** JWT token het han hoac khong hop le

**Giai phap:**
- Dang nhap lai de lay token moi
- Kiem tra localStorage trong DevTools
- Xoa token cu: `localStorage.removeItem('token')`

### Loi: 403 Forbidden

**Nguyen nhan:** User khong co quyen truy cap

**Giai phap:**
- Kiem tra role cua user
- Admin can co role ADMIN
- Instructor can co role INSTRUCTOR hoac ADMIN

### Loi: 422 Unprocessable Entity khi them bai hoc

**Nguyen nhan:** Du lieu khong hop le

**Giai phap:**
- Kiem tra dinh dang YouTube Video ID
- Kiem tra orderIndex khong bi trung
- Kiem tra cac field required khong de trong

### Loi: Duplicate entry for key 'uq_lesson_course_order'

**Nguyen nhan:** OrderIndex bi trung trong cung khoa hoc

**Giai phap:**
- He thong se tu dong suggest orderIndex tiep theo
- Hoac su dung orderIndex khac

### Loi: Video khong phat duoc

**Nguyen nhan:** 
- YouTube Video ID sai
- Video bi han che nhung vao
- User chua enrolled vao khoa hoc

**Giai phap:**
- Kiem tra Video ID chinh xac
- Thu voi video YouTube khac
- Dam bao user da enrolled (doi voi paid courses)

---

## BUILD VA DEPLOY

### Build JAR file

```powershell
.\mvnw.cmd clean package -DskipTests
```

File JAR se duoc tao tai: `target/elearning-api-0.0.1-SNAPSHOT.jar`

### Chay JAR file

```powershell
java -jar target/elearning-api-0.0.1-SNAPSHOT.jar
```

### Deploy len Server

1. Upload JAR file len server
2. Cau hinh MySQL tren server
3. Cap nhat application.yml voi thong tin server
4. Chay JAR file voi systemd hoac screen

```bash
# Vi du voi screen
screen -S elearning
java -jar elearning-api-0.0.1-SNAPSHOT.jar
# Ctrl+A+D de detach
```

---

## TEST API VOI POSTMAN

File Postman Collection da duoc cung cap trong du an:

```
E-Learning-API-Complete.postman_collection.json
E-Learning-Complete.postman_environment.json
```

### Cach import:

1. Mo Postman
2. Click Import
3. Chon file `.postman_collection.json`
4. Import file `.postman_environment.json`
5. Chon Environment "E-Learning Complete"
6. Chay cac request theo thu tu

### Test Flow:

```
1. Register Student
2. Login Student (Luu token)
3. Register Instructor
4. Login Admin (Luu token)
5. Promote User to Instructor
6. Create Course
7. Add Lessons
8. Enroll Student
9. Test Payment Flow
10. Verify Enrollment Status
```

---

## LIEN HE VA HO TRO

Neu gap van de trong qua trinh su dung, vui long:

1. Kiem tra phan "Xu ly loi thuong gap" trong file nay
2. Kiem tra log cua ung dung
3. Kiem tra browser console (F12) de xem loi JavaScript
4. Kiem tra Network tab de xem API responses

---

## THONG TIN THEM

### Browser Support

- Chrome (Recommended)
- Firefox
- Edge
- Safari

### Responsive Design

Giao dien duoc toi uu cho:
- Desktop (1920x1080 va lon hon)
- Laptop (1366x768)
- Tablet (768x1024)
- Mobile (375x667 va lon hon)

### Security Features

- Password hashing voi BCrypt
- JWT token-based authentication
- Role-based access control
- CORS configuration
- SQL injection prevention (JPA)
- XSS prevention
- CSRF protection for state-changing operations

---

## LICENSE

Project nay duoc phat trien cho muc dich hoc tap va nghien cuu.
