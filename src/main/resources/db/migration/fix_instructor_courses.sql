-- =============================================
-- FIX INSTRUCTOR DATA
-- Assigns all courses to instructor_demo (User ID 2)
-- =============================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- 1. Remove existing assignments for this user to prevent duplicates
DELETE FROM course_instructors WHERE user_id = 2;

-- 2. Assign ALL courses to user 2
INSERT INTO course_instructors (course_id, user_id, role, created_at, updated_at)
SELECT id, 2, 'OWNER', NOW(), NOW() FROM courses;

-- 3. Verify
SELECT COUNT(*) as assigned_courses FROM course_instructors WHERE user_id = 2;

SET FOREIGN_KEY_CHECKS = 1;
