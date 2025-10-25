-- ========================================
-- V4: Add course_instructors table
-- ========================================
USE elearning;

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

-- ========================================
-- HƯỚNG DẪN CHẠY:
-- ========================================
-- Option 1: MySQL Workbench
--   File → Open SQL Script → Chọn file này → Execute
--
-- Option 2: MySQL Command Line
--   mysql -u root -p elearning < src/main/resources/db/migration/v4_course_instructors.sql
--
-- Option 3: Copy-paste
--   Copy câu CREATE TABLE trên vào MySQL Workbench
-- ========================================

