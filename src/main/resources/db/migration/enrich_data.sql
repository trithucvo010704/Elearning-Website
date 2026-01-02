-- =============================================
-- ENRICH DATA: INCREASE PRICE & FILL MORE LESSONS
-- Based on init_data.sql logic
-- This script assumes init_data.sql has been run (lessons 1-6 exist)
-- =============================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- 1. Increase Course Prices by 100 times
-- =========================================
UPDATE courses SET price_cents = price_cents * 100;

-- 2. Fill more lessons (7-20) for all courses
-- =========================================
-- Ensure we don't have duplicates if re-run (though order_index constraint prevents it)

-- Lesson 7
INSERT IGNORE INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at)
SELECT id, CONCAT('Bài học 7: Chuyên đề mở rộng 1 - ', title), 7, CONCAT('yt:l7_', id), 1800, false, NOW(), NOW() FROM courses;

-- Lesson 8
INSERT IGNORE INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at)
SELECT id, CONCAT('Bài học 8: Chuyên đề mở rộng 2 - ', title), 8, CONCAT('yt:l8_', id), 1900, false, NOW(), NOW() FROM courses;

-- Lesson 9
INSERT IGNORE INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at)
SELECT id, CONCAT('Bài học 9: Thực hành nâng cao 1 - ', title), 9, CONCAT('yt:l9_', id), 2500, false, NOW(), NOW() FROM courses;

-- Lesson 10
INSERT IGNORE INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at)
SELECT id, CONCAT('Bài học 10: Thực hành nâng cao 2 - ', title), 10, CONCAT('yt:l10_', id), 2200, false, NOW(), NOW() FROM courses;

-- Lesson 11
INSERT IGNORE INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at)
SELECT id, CONCAT('Bài học 11: Phân tích Case Study 1 - ', title), 11, CONCAT('yt:l11_', id), 2100, false, NOW(), NOW() FROM courses;

-- Lesson 12
INSERT IGNORE INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at)
SELECT id, CONCAT('Bài học 12: Phân tích Case Study 2 - ', title), 12, CONCAT('yt:l12_', id), 2300, false, NOW(), NOW() FROM courses;

-- Lesson 13
INSERT IGNORE INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at)
SELECT id, CONCAT('Bài học 13: Tối ưu hiệu năng - ', title), 13, CONCAT('yt:l13_', id), 1950, false, NOW(), NOW() FROM courses;

-- Lesson 14
INSERT IGNORE INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at)
SELECT id, CONCAT('Bài học 14: Bảo mật ứng dụng - ', title), 14, CONCAT('yt:l14_', id), 2050, false, NOW(), NOW() FROM courses;

-- Lesson 15
INSERT IGNORE INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at)
SELECT id, CONCAT('Bài học 15: Kiểm thử và Debug - ', title), 15, CONCAT('yt:l15_', id), 2400, false, NOW(), NOW() FROM courses;

-- Lesson 16
INSERT IGNORE INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at)
SELECT id, CONCAT('Bài học 16: Triển khai (Deployment) - ', title), 16, CONCAT('yt:l16_', id), 2600, false, NOW(), NOW() FROM courses;

-- Lesson 17
INSERT IGNORE INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at)
SELECT id, CONCAT('Bài học 17: Giám sát hệ thống - ', title), 17, CONCAT('yt:l17_', id), 1700, false, NOW(), NOW() FROM courses;

-- Lesson 18
INSERT IGNORE INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at)
SELECT id, CONCAT('Bài học 18: Bảo trì và Nâng cấp - ', title), 18, CONCAT('yt:l18_', id), 1850, false, NOW(), NOW() FROM courses;

-- Lesson 19
INSERT IGNORE INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at)
SELECT id, CONCAT('Bài học 19: Tổng kết khóa học - ', title), 19, CONCAT('yt:l19_', id), 1500, false, NOW(), NOW() FROM courses;

-- Lesson 20
INSERT IGNORE INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at)
SELECT id, CONCAT('Bài học 20: Đồ án cuối khóa - ', title), 20, CONCAT('yt:l20_', id), 3600, false, NOW(), NOW() FROM courses;

SET FOREIGN_KEY_CHECKS = 1;
