-- =============================================
-- CLEAN UP COURSES & LESSONS ONLY
-- Use this if you want to clear course data without resetting Users
-- =============================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- 1. Delete dependent tables first (or rely on Cascade if configured)
-- To be safe and thorough:
DELETE FROM lesson_progress;
DELETE FROM video_lessons;
DELETE FROM course_instructors;
DELETE FROM enrollments;
DELETE FROM order_items;
DELETE FROM payments;
DELETE FROM chat_histories;

-- 2. Delete Courses
DELETE FROM courses;

-- Reset Auto Increment for Courses and Lessons
ALTER TABLE courses AUTO_INCREMENT = 1;
ALTER TABLE video_lessons AUTO_INCREMENT = 1;

SET FOREIGN_KEY_CHECKS = 1;
