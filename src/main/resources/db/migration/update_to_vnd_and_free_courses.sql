-- =============================================
-- UPDATE TO VND CURRENCY AND FREE COURSES
-- This file:
-- 1. Converts all courses currency from USD to VND
-- 2. Makes first 10 courses (ID 1-10) FREE (price_cents = 0)
-- 3. Makes all lessons in free courses FREE (free_preview = true)
-- =============================================

SET FOREIGN_KEY_CHECKS = 0;

-- =============================================
-- STEP 1: Make first 10 courses FREE first
-- =============================================
-- Set price_cents = 0 for courses with ID 1-10 (before currency conversion)
UPDATE courses 
SET price_cents = 0
WHERE id BETWEEN 1 AND 10;

-- =============================================
-- STEP 2: Convert all courses currency to VND
-- =============================================
-- Note: Converting USD to VND at approximate rate 1 USD = 24,000 VND
-- You can adjust the conversion rate as needed

UPDATE courses SET currency = 'VND' WHERE currency = 'USD';

-- Convert price from USD cents to VND (only for paid courses, skip free ones)
-- Example: 29900 USD cents = 299 USD = 299 * 24000 = 7,176,000 VND cents
UPDATE courses 
SET price_cents = price_cents * 240 
WHERE currency = 'VND' AND price_cents > 0;

-- =============================================
-- STEP 3: Make all lessons in free courses FREE
-- =============================================
-- Set free_preview = true for all lessons in courses 1-10
UPDATE video_lessons 
SET free_preview = true
WHERE course_id BETWEEN 1 AND 10;

SET FOREIGN_KEY_CHECKS = 1;

-- =============================================
-- VERIFICATION QUERIES
-- =============================================
-- Run these queries to verify the changes:

-- Check currency conversion
-- SELECT id, title, price_cents, currency FROM courses ORDER BY id LIMIT 15;

-- Check free courses
-- SELECT id, title, price_cents, currency FROM courses WHERE price_cents = 0;

-- Check free lessons
-- SELECT course_id, COUNT(*) as total_lessons, SUM(CASE WHEN free_preview = true THEN 1 ELSE 0 END) as free_lessons
-- FROM video_lessons WHERE course_id BETWEEN 1 AND 10 GROUP BY course_id;

-- =============================================
-- UPDATE COMPLETED
-- - All courses now use VND currency
-- - First 10 courses (ID 1-10) are FREE
-- - All lessons in free courses are FREE (free_preview = true)
-- =============================================

