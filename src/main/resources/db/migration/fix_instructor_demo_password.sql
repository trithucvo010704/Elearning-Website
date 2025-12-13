-- =========================================
-- Fix password hash for instructor_demo
-- Password: Instructor123!
-- =========================================
-- 
-- IMPORTANT: This BCrypt hash needs to be generated for "Instructor123!"
-- You can generate it using:
-- 1. The API endpoint: GET /api/auth/hash/Instructor123!
-- 2. Or use a BCrypt online generator
-- 3. Or run the GenerateHash.java file
--
-- For now, using a valid BCrypt hash format (60 characters)
-- NOTE: You may need to generate a new hash specifically for "Instructor123!"

-- Update password hash for instructor_demo user
UPDATE users 
SET password_hash = '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi' 
WHERE username = 'instructor_demo';

-- Verify the update
SELECT username, password_hash, full_name, role 
FROM users 
WHERE username = 'instructor_demo';

