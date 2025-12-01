-- =========================================
-- E-Learning DB Schema (Complete Version)
-- MySQL 8.x  |  Engine: InnoDB  |  Charset: utf8mb4
-- 
-- Version: Complete (Gộp từ v1-v6)
-- Notes:
-- - Login bằng username (KHÔNG có email_verifications/password_resets)
-- - Tối ưu index cho tra cứu phổ biến (catalog, enroll, payment, webhook)
-- - Tất cả foreign keys đều dùng ON DELETE CASCADE để hỗ trợ xóa course
-- =========================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- =========================================
-- 1. USERS
-- =========================================
CREATE TABLE IF NOT EXISTS users (
    id              BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username        VARCHAR(64)  NOT NULL,
    password_hash   VARCHAR(255) NOT NULL,
    full_name       VARCHAR(255),
    role            ENUM('STUDENT','INSTRUCTOR','ADMIN') NOT NULL DEFAULT 'STUDENT',
    enabled         TINYINT(1) NOT NULL DEFAULT 1,
    created_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at      DATETIME NULL,
    CONSTRAINT uq_users_username UNIQUE (username),
    INDEX idx_users_role_created (role, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================
-- 2. COURSES
-- =========================================
CREATE TABLE IF NOT EXISTS courses (
    id              BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title           VARCHAR(255) NOT NULL,
    slug            VARCHAR(255) NOT NULL,
    description     TEXT,
    price_cents     INT NOT NULL DEFAULT 0,
    currency        VARCHAR(10) NOT NULL DEFAULT 'USD',
    published       TINYINT(1) NOT NULL DEFAULT 0,
    thumbnail_url   TEXT,
    status          ENUM('DRAFT','PUBLISHED','ARCHIVED') NOT NULL DEFAULT 'DRAFT',
    created_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at      DATETIME NULL,
    CONSTRAINT uq_courses_slug UNIQUE (slug),
    INDEX idx_courses_pub_created (published, created_at DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================
-- 3. COURSE INSTRUCTORS
-- =========================================
CREATE TABLE IF NOT EXISTS course_instructors (
    id              BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    course_id       BIGINT NOT NULL,
    user_id         BIGINT NOT NULL,
    role            ENUM('OWNER','INSTRUCTOR','TA') NOT NULL DEFAULT 'INSTRUCTOR',
    created_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at      DATETIME NULL,
    CONSTRAINT fk_ci_course FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    CONSTRAINT fk_ci_user   FOREIGN KEY (user_id)   REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT uq_course_instructor UNIQUE (course_id, user_id),
    INDEX idx_ci_course (course_id),
    INDEX idx_ci_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================
-- 4. VIDEO LESSONS
-- =========================================
CREATE TABLE IF NOT EXISTS video_lessons (
    id              BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    course_id       BIGINT NOT NULL,
    title           VARCHAR(255) NOT NULL,
    order_index     INT NOT NULL,
    s3_key          VARCHAR(512) NOT NULL,
    duration_sec    INT,
    free_preview    TINYINT(1) NOT NULL DEFAULT 0,
    created_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at      DATETIME NULL,
    CONSTRAINT fk_lessons_course FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    CONSTRAINT uq_lesson_course_order UNIQUE (course_id, order_index),
    INDEX idx_lessons_course (course_id, id),
    INDEX idx_lessons_course_order (course_id, order_index)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================
-- 5. ENROLLMENTS
-- =========================================
CREATE TABLE IF NOT EXISTS enrollments (
    id              BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id         BIGINT NOT NULL,
    course_id       BIGINT NOT NULL,
    status          ENUM('PENDING','ACTIVE','REFUNDED') NOT NULL DEFAULT 'PENDING',
    created_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at      DATETIME NULL,
    CONSTRAINT uq_enroll_user_course UNIQUE (user_id, course_id),
    CONSTRAINT fk_enroll_user   FOREIGN KEY (user_id)  REFERENCES users(id)   ON DELETE CASCADE,
    CONSTRAINT fk_enroll_course FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    INDEX idx_enroll_status_created (status, created_at),
    INDEX idx_enroll_user_created (user_id, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================
-- 6. ORDERS
-- =========================================
CREATE TABLE IF NOT EXISTS orders (
    id                   BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id              BIGINT NOT NULL,
    status               ENUM('PENDING','REQUIRES_PAYMENT','PAID','CANCELED','REFUNDED') NOT NULL DEFAULT 'PENDING',
    total_amount_cents   INT NOT NULL DEFAULT 0,
    currency             VARCHAR(10) NOT NULL DEFAULT 'USD',
    created_at           DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at           DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at           DATETIME NULL,
    CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_orders_user_created (user_id, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================
-- 7. ORDER ITEMS
-- =========================================
CREATE TABLE IF NOT EXISTS order_items (
    id                 BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id           BIGINT NOT NULL,
    course_id          BIGINT NOT NULL,
    unit_price_cents   INT NOT NULL,
    quantity           INT NOT NULL DEFAULT 1,
    title_snapshot     VARCHAR(255),
    created_at         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_items_order  FOREIGN KEY (order_id)  REFERENCES orders(id)   ON DELETE CASCADE,
    CONSTRAINT fk_items_course FOREIGN KEY (course_id) REFERENCES courses(id)  ON DELETE CASCADE,
    CONSTRAINT uq_order_course_once UNIQUE (order_id, course_id),
    INDEX idx_items_order (order_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================
-- 8. PAYMENTS
-- =========================================
CREATE TABLE IF NOT EXISTS payments (
    id                      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id                 BIGINT NOT NULL,
    course_id               BIGINT NOT NULL,
    enrollment_id           BIGINT NULL,
    order_id                BIGINT NULL,
    stripe_session_id       VARCHAR(255) UNIQUE,
    stripe_payment_intent   VARCHAR(255) UNIQUE,
    stripe_event_id         VARCHAR(255) UNIQUE,
    amount_cents            INT NOT NULL,
    currency                VARCHAR(10) NOT NULL DEFAULT 'USD',
    provider                ENUM('STRIPE') NOT NULL DEFAULT 'STRIPE',
    method                  VARCHAR(64) NULL,
    refunded_amount_cents   INT NOT NULL DEFAULT 0,
    status                  ENUM('REQUIRES_PAYMENT','PAID','FAILED','REFUNDED') NOT NULL,
    created_at              DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at              DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at              DATETIME NULL,
    CONSTRAINT fk_pay_user       FOREIGN KEY (user_id)       REFERENCES users(id)        ON DELETE CASCADE,
    CONSTRAINT fk_pay_course     FOREIGN KEY (course_id)     REFERENCES courses(id)      ON DELETE CASCADE,
    CONSTRAINT fk_pay_enrollment FOREIGN KEY (enrollment_id) REFERENCES enrollments(id)  ON DELETE SET NULL,
    CONSTRAINT fk_pay_order      FOREIGN KEY (order_id)      REFERENCES orders(id)       ON DELETE SET NULL,
    INDEX idx_pay_user_course (user_id, course_id),
    INDEX idx_pay_status_created (status, created_at),
    INDEX idx_pay_order_created (order_id, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================
-- 9. LESSON PROGRESS
-- =========================================
CREATE TABLE IF NOT EXISTS lesson_progress (
    id              BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    enrollment_id   BIGINT NOT NULL,
    lesson_id       BIGINT NOT NULL,
    watched_sec     INT NOT NULL DEFAULT 0,
    completed       TINYINT(1) NOT NULL DEFAULT 0,
    updated_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_enroll_lesson UNIQUE (enrollment_id, lesson_id),
    CONSTRAINT fk_lp_enroll FOREIGN KEY (enrollment_id) REFERENCES enrollments(id)  ON DELETE CASCADE,
    CONSTRAINT fk_lp_lesson FOREIGN KEY (lesson_id)     REFERENCES video_lessons(id) ON DELETE CASCADE,
    INDEX idx_lp_enroll_updated (enrollment_id, updated_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================
-- 10. CHAT HISTORIES
-- =========================================
CREATE TABLE IF NOT EXISTS chat_histories (
    id              BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id         BIGINT NOT NULL,
    course_id       BIGINT NOT NULL,
    message_role    ENUM('USER','AI') NOT NULL,
    content         TEXT NOT NULL,
    created_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at      DATETIME NULL,
    CONSTRAINT fk_chat_user   FOREIGN KEY (user_id)  REFERENCES users(id)   ON DELETE CASCADE,
    CONSTRAINT fk_chat_course FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    INDEX idx_chat_user_course_created (user_id, course_id, created_at DESC),
    INDEX idx_chat_course_created (course_id, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================
-- 11. WEBHOOK EVENTS
-- =========================================
CREATE TABLE IF NOT EXISTS webhook_events (
    id            BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    provider      ENUM('STRIPE') NOT NULL,
    event_id      VARCHAR(255) NOT NULL UNIQUE,
    signature     VARCHAR(255),
    payload       JSON NOT NULL,
    processed     TINYINT(1) NOT NULL DEFAULT 0,
    processed_at  DATETIME NULL,
    created_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_webhook_processed (processed, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================
-- 12. AUDIT LOGS
-- =========================================
CREATE TABLE IF NOT EXISTS audit_logs (
    id            BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    actor_user_id BIGINT NULL,
    action        VARCHAR(128) NOT NULL,
    entity_type   VARCHAR(64) NOT NULL,
    entity_id     BIGINT NULL,
    diff          JSON NULL,
    created_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_audit_entity (entity_type, entity_id),
    INDEX idx_audit_actor (actor_user_id, created_at),
    CONSTRAINT fk_audit_actor FOREIGN KEY (actor_user_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;

-- =========================================
-- DEFAULT USERS
-- =========================================

-- Admin User
-- Username: admin
-- Password: admin123
-- Role: ADMIN
INSERT INTO users (username, password_hash, full_name, role, enabled, created_at, updated_at)
VALUES (
    'admin',
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
    'System Administrator',
    'ADMIN',
    1,
    NOW(),
    NOW()
);

-- Demo Instructor
-- Username: instructor_demo
-- Password: Instructor123!
-- Role: INSTRUCTOR
INSERT INTO users (username, password_hash, full_name, role, enabled, created_at, updated_at)
VALUES (
    'instructor_demo',
    '$2a$10$rPqDZXq7pJyJXqOcQqZ8eOYN5qF8QXZ8vQ3Z8eOYN5qF8QXZ8vQ3Ze',
    'Demo Instructor',
    'INSTRUCTOR',
    1,
    NOW(),
    NOW()
);

-- =========================================
-- HƯỚNG DẪN SỬ DỤNG
-- =========================================
-- 1. Tạo database:
--    CREATE DATABASE elearning CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
--
-- 2. Chọn database:
--    USE elearning;
--
-- 3. Chạy file này:
--    mysql -u root -p elearning < src/main/resources/db/migration/schema.sql
--
-- 4. Sau đó chạy file.sql để insert dữ liệu mẫu:
--    mysql -u root -p elearning < src/main/resources/db/migration/file.sql
-- =========================================

