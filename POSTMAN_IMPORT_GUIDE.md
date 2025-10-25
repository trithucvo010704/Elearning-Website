# 📦 HƯỚNG DẪN IMPORT VÀ TEST API BẰNG POSTMAN

## 🎯 FILES CẦN IMPORT

1. **E-Learning-API-Complete.postman_collection.json** - Collection chứa tất cả API
2. **E-Learning-Complete.postman_environment.json** - Environment variables

---

## 📥 BƯỚC 1: IMPORT VÀO POSTMAN

### Import Collection

1. Mở Postman
2. Click **Import** (góc trái trên)
3. Kéo thả file `E-Learning-API-Complete.postman_collection.json`
4. Click **Import**

### Import Environment

1. Click **Import** lần nữa
2. Kéo thả file `E-Learning-Complete.postman_environment.json`
3. Click **Import**

### Chọn Environment

1. Click dropdown góc phải trên (hiện "No Environment")
2. Chọn **"E-Learning Complete Environment"**

---

## ▶️ BƯỚC 2: CHẠY COLLECTION

### Option 1: Run toàn bộ (Khuyến nghị)

1. Click vào Collection **"E-Learning API - Complete Test Flow"**
2. Click **Run** (góc phải)
3. Đảm bảo tất cả requests được chọn ✅
4. Click **Run E-Learning API - Complete Test Flow**

**⏱️ Thời gian:** ~10-15 giây

**✅ Kết quả mong đợi:**

- Tất cả tests PASS (màu xanh)
- Tổng: ~20 tests pass

### Option 2: Chạy từng request thủ công

1. Mở Collection
2. Click vào từng request theo thứ tự
3. Click **Send**

---

## 🔄 LUỒNG TEST TỰ ĐỘNG

### 1️⃣ Authentication (4 requests)

```
1.1 Login Admin
    ↓ Lưu ADMIN_TOKEN vào environment
1.2 Register Student
    ↓ Lưu STUDENT_TOKEN, STUDENT_ID
1.3 Register Instructor (as STUDENT)
    ↓ Lưu INSTRUCTOR_CANDIDATE_ID
1.4 Get My Profile
    ↓ Test token hoạt động
```

### 2️⃣ Admin - User Management (4 requests)

```
2.1 Get All Users
    ↓ Xem danh sách users
2.2 Promote User to INSTRUCTOR
    ↓ Nâng cấp user lên INSTRUCTOR
2.3 Login Instructor (Get New Token)
    ↓ Lưu INSTRUCTOR_TOKEN với role mới
2.4 Get All Instructors
    ↓ Verify promotion thành công
```

### 3️⃣ Courses (4 requests)

```
3.1 Instructor Create Course
    ↓ Lưu COURSE_ID
3.2 Get All Courses (Public)
    ↓ Xem danh sách courses
3.3 Get My Courses (Instructor)
    ↓ Xem courses của instructor
3.4 Update Course
    ↓ Test edit quyền owner
```

### 4️⃣ Lessons (3 requests)

```
4.1 Create Lesson - Free Preview
    ↓ Lưu LESSON_FREE_ID
4.2 Create Lesson - Paid
    ↓ Lưu LESSON_PAID_ID
4.3 Get All Lessons (Public)
    ↓ Xem danh sách lessons
```

### 5️⃣ Video Access & Paywall ⭐ QUAN TRỌNG (3 requests)

```
5.1 Student Watch Free Lesson (OK)
    ✅ canWatch: true

5.2 Student Watch Paid Lesson (PAYWALL)
    ❌ canWatch: false ← PAYWALL WORKING!

5.3 Instructor Watch Paid Lesson (OK - Owner)
    ✅ canWatch: true
```

### 6️⃣ Admin - Course Management (2 requests)

```
6.1 Admin Get All Courses
    ↓ Xem tất cả courses
6.2 Admin Get Statistics
    ↓ Xem thống kê
```

---

## 📊 KIỂM TRA KẾT QUẢ

### Tests Pass

Mỗi request có **Test Scripts** tự động kiểm tra:

✅ Status code đúng (200, 201, etc.)  
✅ Response có dữ liệu đúng format  
✅ Token được lưu vào environment  
✅ Paywall hoạt động đúng

### Xem Environment Variables

1. Click icon 👁️ (Environment Quick Look) góc phải trên
2. Xem các biến đã được lưu:
   - `ADMIN_TOKEN` - Token của admin
   - `INSTRUCTOR_TOKEN` - Token của instructor
   - `STUDENT_TOKEN` - Token của student
   - `COURSE_ID` - ID của course vừa tạo
   - `LESSON_FREE_ID` - ID của free lesson
   - `LESSON_PAID_ID` - ID của paid lesson

---

## 🔍 DEBUG KHI CÓ LỖI

### Lỗi "Could not send request"

→ Spring Boot chưa chạy

**Fix:**

```powershell
cd D:\DACN\elearning-api
mvn spring-boot:run
```

### Lỗi 401 Unauthorized

→ Token sai hoặc hết hạn

**Fix:**

1. Chạy lại request **1.1 Login Admin**
2. Hoặc clear environment và chạy lại toàn bộ

### Lỗi 403 Forbidden

→ Role không đúng

**Fix:**

- Kiểm tra đang dùng đúng token không
- Admin API phải dùng `ADMIN_TOKEN`
- Course create phải dùng `INSTRUCTOR_TOKEN`

### Lỗi 500 Internal Server Error

→ Lỗi server

**Fix:**

1. Xem console Spring Boot
2. Kiểm tra MySQL đang chạy
3. Kiểm tra database `elearning` tồn tại

---

## 💡 TIPS

### 1. Clear Environment để test lại

1. Click icon 👁️ góc phải
2. Click **Edit**
3. Xóa hết giá trị của các biến (để trống)
4. Save
5. Chạy lại collection

### 2. Test từng phần riêng

Có thể chạy từng folder riêng:

- **1. Authentication** - Test auth
- **5. Video Access & Paywall** - Test paywall

### 3. Xem Console logs

Mở **Postman Console** (View → Show Postman Console) để xem:

- Tokens được lưu
- IDs được lưu
- Debug messages

### 4. Customize test data

Có thể sửa body của requests:

- Username khác
- Course title khác
- Lesson title khác

---

## 🎯 EXPECTED RESULTS

### ✅ ALL PASS (20 tests)

| Folder                       | Tests  | Expected Pass |
| ---------------------------- | ------ | ------------- |
| 1. Authentication            | 4      | 4 ✅          |
| 2. Admin - User Management   | 4      | 4 ✅          |
| 3. Courses                   | 4      | 4 ✅          |
| 4. Lessons                   | 3      | 3 ✅          |
| 5. Video Access & Paywall    | 3      | 3 ✅          |
| 6. Admin - Course Management | 2      | 2 ✅          |
| **TOTAL**                    | **20** | **20 ✅**     |

### Paywall Test Results

**Request 5.2** - Student xem paid lesson:

```json
{
  "canWatch": false,  ← ĐÚNG! Paywall hoạt động
  "provider": "youtube",
  "videoId": null,
  "embedUrl": null
}
```

**Request 5.3** - Owner xem paid lesson:

```json
{
  "canWatch": true,  ← ĐÚNG! Owner được xem
  "provider": "youtube",
  "videoId": "9SGDpanrc8U",
  "embedUrl": "https://..."
}
```

---

## 📝 TÀI KHOẢN TRONG DATABASE

Từ screenshot bạn cung cấp, đã có sẵn:

| ID  | Username        | Role       | Password Hash |
| --- | --------------- | ---------- | ------------- |
| 7   | testuser2       | STUDENT    | $2a$10$...    |
| 8   | trith0cv0233    | STUDENT    | $2a$10$...    |
| 9   | 03435425        | STUDENT    | $2a$10$...    |
| 10  | **admin**       | **ADMIN**  | $2a$10$...    |
| 11  | instructor_demo | INSTRUCTOR | $2a$10$...    |

**Collection sẽ tạo thêm:**

- `student_new` - STUDENT (từ register)
- `instructor_new` - INSTRUCTOR (từ register + promote)

---

## 🚀 CHẠY NGAY!

1. Import 2 files JSON
2. Chọn Environment
3. Click **Run**
4. Xem kết quả: **20/20 tests PASS** ✅

---

**Happy Testing! 🎉**

_Nếu có lỗi, xem phần DEBUG ở trên hoặc check console Spring Boot_
