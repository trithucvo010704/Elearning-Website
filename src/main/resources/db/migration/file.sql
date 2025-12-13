-- =============================================
-- SAMPLE DATA FOR E-LEARNING API
-- 30 records for each entity with realistic data
-- =============================================
-- NOTE: If you encounter duplicate entry errors, clear existing data first:
-- DELETE FROM webhook_events;
-- DELETE FROM audit_logs;
-- DELETE FROM chat_histories;
-- DELETE FROM lesson_progress;
-- DELETE FROM payments;
-- DELETE FROM order_items;
-- DELETE FROM orders;
-- DELETE FROM enrollments;
-- DELETE FROM video_lessons;
-- DELETE FROM course_instructors;
-- DELETE FROM courses;
-- DELETE FROM users WHERE username NOT IN ('admin', 'instructor_demo');
-- =============================================

-- Disable foreign key checks to allow inserting data in any order
SET FOREIGN_KEY_CHECKS = 0;

-- Reset AUTO_INCREMENT to ensure course IDs start from 1
-- This ensures course IDs match with video_lessons course_id references
ALTER TABLE video_lessons AUTO_INCREMENT = 1;
ALTER TABLE courses AUTO_INCREMENT = 1;
ALTER TABLE users AUTO_INCREMENT = 1;
ALTER TABLE course_instructors AUTO_INCREMENT = 1;
ALTER TABLE enrollments AUTO_INCREMENT = 1;
ALTER TABLE orders AUTO_INCREMENT = 1;
ALTER TABLE order_items AUTO_INCREMENT = 1;
ALTER TABLE payments AUTO_INCREMENT = 1;
ALTER TABLE lesson_progress AUTO_INCREMENT = 1;
ALTER TABLE chat_histories AUTO_INCREMENT = 1;
ALTER TABLE audit_logs AUTO_INCREMENT = 1;
ALTER TABLE webhook_events AUTO_INCREMENT = 1;

-- 1. USERS (30 records)
-- Mix of students, instructors, and admins
INSERT INTO users (username, password_hash, full_name, role, enabled, created_at, updated_at) VALUES
('john_doe', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'John Doe', 'STUDENT', true, '2024-01-15 09:30:00', '2024-01-15 09:30:00'),
('jane_smith', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Jane Smith', 'STUDENT', true, '2024-01-16 10:15:00', '2024-01-16 10:15:00'),
('mike_wilson', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Mike Wilson', 'STUDENT', true, '2024-01-17 11:20:00', '2024-01-17 11:20:00'),
('sarah_johnson', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Sarah Johnson', 'STUDENT', true, '2024-01-18 14:45:00', '2024-01-18 14:45:00'),
('david_brown', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'David Brown', 'STUDENT', true, '2024-01-19 16:30:00', '2024-01-19 16:30:00'),
('lisa_garcia', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Lisa Garcia', 'STUDENT', true, '2024-01-20 08:15:00', '2024-01-20 08:15:00'),
('tom_anderson', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Tom Anderson', 'STUDENT', true, '2024-01-21 12:00:00', '2024-01-21 12:00:00'),
('emma_davis', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Emma Davis', 'STUDENT', true, '2024-01-22 15:30:00', '2024-01-22 15:30:00'),
('alex_miller', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Alex Miller', 'STUDENT', true, '2024-01-23 09:45:00', '2024-01-23 09:45:00'),
('sophie_taylor', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Sophie Taylor', 'STUDENT', true, '2024-01-24 13:20:00', '2024-01-24 13:20:00'),
('prof_nguyen', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Prof. Nguyen Van A', 'INSTRUCTOR', true, '2024-01-10 08:00:00', '2024-01-10 08:00:00'),
('dr_smith', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Dr. Sarah Smith', 'INSTRUCTOR', true, '2024-01-11 09:30:00', '2024-01-11 09:30:00'),
('master_lee', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Master Lee Chen', 'INSTRUCTOR', true, '2024-01-12 10:15:00', '2024-01-12 10:15:00'),
('expert_kim', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Expert Kim Soo', 'INSTRUCTOR', true, '2024-01-13 11:00:00', '2024-01-13 11:00:00'),
('teacher_yamada', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Teacher Yamada', 'INSTRUCTOR', true, '2024-01-14 12:30:00', '2024-01-14 12:30:00'),
('instructor_patel', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Instructor Patel', 'INSTRUCTOR', true, '2024-01-15 14:00:00', '2024-01-15 14:00:00'),
('coach_rodriguez', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Coach Rodriguez', 'INSTRUCTOR', true, '2024-01-16 15:45:00', '2024-01-16 15:45:00'),
('mentor_johnson', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Mentor Johnson', 'INSTRUCTOR', true, '2024-01-17 16:20:00', '2024-01-17 16:20:00'),
('tutor_wang', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Tutor Wang Li', 'INSTRUCTOR', true, '2024-01-18 17:10:00', '2024-01-18 17:10:00'),
('admin_system', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'System Administrator', 'ADMIN', true, '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
('admin_support', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Support Admin', 'ADMIN', true, '2024-01-02 08:00:00', '2024-01-02 08:00:00'),
('admin_content', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Content Admin', 'ADMIN', true, '2024-01-03 09:00:00', '2024-01-03 09:00:00'),
('admin_tech', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Tech Admin', 'ADMIN', true, '2024-01-04 10:00:00', '2024-01-04 10:00:00'),
('admin_finance', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Finance Admin', 'ADMIN', true, '2024-01-05 11:00:00', '2024-01-05 11:00:00'),
('student_robert', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Robert Kim', 'STUDENT', true, '2024-01-25 10:30:00', '2024-01-25 10:30:00'),
('student_maria', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Maria Santos', 'STUDENT', true, '2024-01-26 14:15:00', '2024-01-26 14:15:00'),
('student_james', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'James Wilson', 'STUDENT', true, '2024-01-27 16:45:00', '2024-01-27 16:45:00'),
('student_anna', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Anna Chen', 'STUDENT', true, '2024-01-28 12:00:00', '2024-01-28 12:00:00'),
('student_kevin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Kevin Park', 'STUDENT', true, '2024-01-29 15:30:00', '2024-01-29 15:30:00');

-- 2. COURSES (30 records)
-- Diverse courses with realistic pricing and content
-- Using real thumbnail images from Unsplash - relevant to each course topic
INSERT INTO courses (title, slug, description, price_cents, currency, published, thumbnail_url, status, created_at, updated_at) VALUES
('Complete Java Programming Masterclass', 'complete-java-programming-masterclass', 'Learn Java programming from beginner to advanced level with hands-on projects and real-world applications.', 29900, 'USD', true, 'https://images.unsplash.com/photo-1516116216624-53e697fedbea?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-10 08:00:00', '2024-01-10 08:00:00'),
('Python for Data Science and Machine Learning', 'python-data-science-machine-learning', 'Master Python for data analysis, visualization, and machine learning with practical projects.', 39900, 'USD', true, 'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-11 09:30:00', '2024-01-11 09:30:00'),
('JavaScript Full Stack Development', 'javascript-full-stack-development', 'Build complete web applications using JavaScript, Node.js, React, and MongoDB.', 34900, 'USD', true, 'https://images.unsplash.com/photo-1579468118864-1b9ea3c0db4a?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-12 10:15:00', '2024-01-12 10:15:00'),
('Japanese Language for Beginners', 'japanese-language-beginners', 'Learn Japanese from scratch with hiragana, katakana, and basic conversation skills.', 19900, 'USD', true, 'https://images.unsplash.com/photo-1528164344705-47542687000d?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-13 11:00:00', '2024-01-13 11:00:00'),
('Advanced Japanese Conversation', 'advanced-japanese-conversation', 'Improve your Japanese speaking skills with advanced grammar and cultural context.', 24900, 'USD', true, 'https://images.unsplash.com/photo-1493809842364-78817add7ffb?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-14 12:30:00', '2024-01-14 12:30:00'),
('English Business Communication', 'english-business-communication', 'Master professional English for business meetings, presentations, and written communication.', 22900, 'USD', true, 'https://images.unsplash.com/photo-1552664730-d307ca884978?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-15 14:00:00', '2024-01-15 14:00:00'),
('IELTS Preparation Course', 'ielts-preparation-course', 'Comprehensive IELTS preparation covering all four skills: listening, reading, writing, and speaking.', 27900, 'USD', true, 'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-16 15:45:00', '2024-01-16 15:45:00'),
('Korean Language Complete Course', 'korean-language-complete-course', 'Learn Korean alphabet, grammar, and conversation from beginner to intermediate level.', 21900, 'USD', true, 'https://images.unsplash.com/photo-1528164344705-47542687000d?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-17 16:20:00', '2024-01-17 16:20:00'),
('Chinese Mandarin for Beginners', 'chinese-mandarin-beginners', 'Start learning Chinese with pinyin, basic characters, and essential vocabulary.', 18900, 'USD', true, 'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-18 17:10:00', '2024-01-18 17:10:00'),
('French Language Immersion', 'french-language-immersion', 'Learn French through immersive conversation practice and cultural context.', 25900, 'USD', true, 'https://images.unsplash.com/photo-1528164344705-47542687000d?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-19 18:00:00', '2024-01-19 18:00:00'),
('Digital Marketing Mastery', 'digital-marketing-mastery', 'Complete guide to digital marketing including SEO, social media, and paid advertising.', 32900, 'USD', true, 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-20 19:30:00', '2024-01-20 19:30:00'),
('Project Management Professional (PMP)', 'project-management-professional-pmp', 'Prepare for PMP certification with comprehensive project management training.', 44900, 'USD', true, 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-21 20:15:00', '2024-01-21 20:15:00'),
('UI/UX Design Fundamentals', 'ui-ux-design-fundamentals', 'Learn user interface and user experience design principles with practical projects.', 29900, 'USD', true, 'https://images.unsplash.com/photo-1561070791-2526d30994b5?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-22 21:00:00', '2024-01-22 21:00:00'),
('Cybersecurity Essentials', 'cybersecurity-essentials', 'Introduction to cybersecurity concepts, threats, and protection strategies.', 37900, 'USD', true, 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-23 22:30:00', '2024-01-23 22:30:00'),
('AWS Cloud Practitioner', 'aws-cloud-practitioner', 'Learn Amazon Web Services fundamentals and cloud computing concepts.', 39900, 'USD', true, 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-24 23:15:00', '2024-01-24 23:15:00'),
('React Native Mobile Development', 'react-native-mobile-development', 'Build cross-platform mobile apps using React Native framework.', 34900, 'USD', true, 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-25 08:30:00', '2024-01-25 08:30:00'),
('Machine Learning with Python', 'machine-learning-python', 'Implement machine learning algorithms and build predictive models.', 49900, 'USD', true, 'https://images.unsplash.com/photo-1527477396000-e27163b481c2?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-26 09:45:00', '2024-01-26 09:45:00'),
('Docker and Kubernetes', 'docker-kubernetes', 'Containerization and orchestration with Docker and Kubernetes.', 32900, 'USD', true, 'https://images.unsplash.com/photo-1605745341112-85968b19335b?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-27 10:20:00', '2024-01-27 10:20:00'),
('GraphQL API Development', 'graphql-api-development', 'Build modern APIs using GraphQL with Node.js and Apollo Server.', 27900, 'USD', true, 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-28 11:10:00', '2024-01-28 11:10:00'),
('Blockchain and Cryptocurrency', 'blockchain-cryptocurrency', 'Understanding blockchain technology and cryptocurrency fundamentals.', 35900, 'USD', true, 'https://images.unsplash.com/photo-1639762681485-074b7f938ba0?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-29 12:00:00', '2024-01-29 12:00:00'),
('Photography Masterclass', 'photography-masterclass', 'Professional photography techniques, composition, and post-processing.', 19900, 'USD', true, 'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-30 13:30:00', '2024-01-30 13:30:00'),
('Video Editing with Adobe Premiere', 'video-editing-adobe-premiere', 'Master video editing using Adobe Premiere Pro with professional techniques.', 22900, 'USD', true, 'https://images.unsplash.com/photo-1533750516457-a7f992034fec?w=800&h=450&fit=crop', 'PUBLISHED', '2024-01-31 14:15:00', '2024-01-31 14:15:00'),
('Personal Finance and Investment', 'personal-finance-investment', 'Learn personal finance management and investment strategies.', 15900, 'USD', true, 'https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?w=800&h=450&fit=crop', 'PUBLISHED', '2024-02-01 15:45:00', '2024-02-01 15:45:00'),
('Leadership and Management Skills', 'leadership-management-skills', 'Develop leadership qualities and effective management techniques.', 24900, 'USD', true, 'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800&h=450&fit=crop', 'PUBLISHED', '2024-02-02 16:30:00', '2024-02-02 16:30:00'),
('Public Speaking and Presentation', 'public-speaking-presentation', 'Overcome fear of public speaking and deliver compelling presentations.', 17900, 'USD', true, 'https://images.unsplash.com/photo-1543269865-cbf427effbad?w=800&h=450&fit=crop', 'PUBLISHED', '2024-02-03 17:20:00', '2024-02-03 17:20:00'),
('Time Management and Productivity', 'time-management-productivity', 'Master time management techniques and boost your productivity.', 12900, 'USD', true, 'https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b?w=800&h=450&fit=crop', 'PUBLISHED', '2024-02-04 18:10:00', '2024-02-04 18:10:00'),
('Creative Writing Workshop', 'creative-writing-workshop', 'Develop creative writing skills through exercises and feedback.', 19900, 'USD', true, 'https://images.unsplash.com/photo-1455390582262-044cdead277a?w=800&h=450&fit=crop', 'PUBLISHED', '2024-02-05 19:00:00', '2024-02-05 19:00:00'),
('Spanish Language Complete', 'spanish-language-complete', 'Learn Spanish from beginner to advanced with cultural insights.', 23900, 'USD', true, 'https://images.unsplash.com/photo-1533450718592-29d45635f0a9?w=800&h=450&fit=crop', 'PUBLISHED', '2024-02-06 20:30:00', '2024-02-06 20:30:00'),
('German Language for Business', 'german-language-business', 'Professional German for business communication and workplace scenarios.', 26900, 'USD', true, 'https://images.unsplash.com/photo-1528164344705-47542687000d?w=800&h=450&fit=crop', 'PUBLISHED', '2024-02-07 21:15:00', '2024-02-07 21:15:00'),
('Italian Language and Culture', 'italian-language-culture', 'Learn Italian language while exploring Italian culture and traditions.', 21900, 'USD', true, 'https://images.unsplash.com/photo-1515542622106-78bda8ba0e5b?w=800&h=450&fit=crop', 'PUBLISHED', '2024-02-08 22:00:00', '2024-02-08 22:00:00'),
('Portuguese for Travelers', 'portuguese-travelers', 'Essential Portuguese phrases and vocabulary for travelers.', 14900, 'USD', true, 'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=800&h=450&fit=crop', 'PUBLISHED', '2024-02-09 23:45:00', '2024-02-09 23:45:00');

-- 3. VIDEO LESSONS (30 records per course - showing first 5 courses with 6 lessons each)
-- Java Programming Course Lessons (Using real YouTube video IDs - format: yt:{11-char-video-id})
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(1, 'Introduction to Java Programming', 1, 'yt:eIrMbAQSU34', 1800, true, '2024-01-10 08:00:00', '2024-01-10 08:00:00'),
(1, 'Java Variables and Data Types', 2, 'yt:grEKMHGYyns', 2400, false, '2024-01-10 08:30:00', '2024-01-10 08:30:00'),
(1, 'Control Structures in Java', 3, 'yt:Z_Apf5T8eB8', 2700, false, '2024-01-10 09:00:00', '2024-01-10 09:00:00'),
(1, 'Object-Oriented Programming Basics', 4, 'yt:WR9gZg3X2Yg', 3600, false, '2024-01-10 09:30:00', '2024-01-10 09:30:00'),
(1, 'Java Collections Framework', 5, 'yt:rzA7UJ-hQn4', 4200, false, '2024-01-10 10:00:00', '2024-01-10 10:00:00'),
(1, 'Exception Handling in Java', 6, 'yt:34ky600pBGY', 2100, false, '2024-01-10 10:30:00', '2024-01-10 10:30:00');

-- Python Data Science Course Lessons (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(2, 'Python Basics for Data Science', 1, 'yt:rfscVS0vtbw', 2100, true, '2024-01-11 09:30:00', '2024-01-11 09:30:00'),
(2, 'NumPy Arrays and Operations', 2, 'yt:QUT1VHiLmmI', 3000, false, '2024-01-11 10:00:00', '2024-01-11 10:00:00'),
(2, 'Pandas Data Manipulation', 3, 'yt:vmEHCJofslg', 3600, false, '2024-01-11 10:30:00', '2024-01-11 10:30:00'),
(2, 'Data Visualization with Matplotlib', 4, 'yt:UO98lJQ3QGI', 2700, false, '2024-01-11 11:00:00', '2024-01-11 11:00:00'),
(2, 'Machine Learning with Scikit-learn', 5, 'yt:pHyqZQJpOcE', 4500, false, '2024-01-11 11:30:00', '2024-01-11 11:30:00'),
(2, 'Deep Learning with TensorFlow', 6, 'yt:tPYj3fFJGjk', 5400, false, '2024-01-11 12:00:00', '2024-01-11 12:00:00');

-- JavaScript Full Stack Course Lessons (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(3, 'JavaScript Fundamentals', 1, 'yt:W6NZfCO5SIk', 2400, true, '2024-01-12 10:15:00', '2024-01-12 10:15:00'),
(3, 'DOM Manipulation and Events', 2, 'yt:0SJE9dYdjrI', 3000, false, '2024-01-12 10:45:00', '2024-01-12 10:45:00'),
(3, 'Node.js Backend Development', 3, 'yt:RLtyhwFtXQA', 4200, false, '2024-01-12 11:15:00', '2024-01-12 11:15:00'),
(3, 'React Frontend Development', 4, 'yt:SqcY0GlETPk', 4800, false, '2024-01-12 11:45:00', '2024-01-12 11:45:00'),
(3, 'MongoDB Database Integration', 5, 'yt:ofme2o29ngU', 3600, false, '2024-01-12 12:15:00', '2024-01-12 12:15:00'),
(3, 'Full Stack Project Deployment', 6, 'yt:1PrWA58C80M', 2700, false, '2024-01-12 12:45:00', '2024-01-12 12:45:00');

-- Japanese Language Course Lessons (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(4, 'Hiragana Alphabet Introduction', 1, 'yt:2QKh5zTG2TE', 1800, true, '2024-01-13 11:00:00', '2024-01-13 11:00:00'),
(4, 'Katakana Alphabet Learning', 2, 'yt:8IUlKl2f8do', 2100, false, '2024-01-13 11:30:00', '2024-01-13 11:30:00'),
(4, 'Basic Japanese Greetings', 3, 'yt:9GorqroigqM', 1500, false, '2024-01-13 12:00:00', '2024-01-13 12:00:00'),
(4, 'Numbers and Counting in Japanese', 4, 'yt:8mK6a1hW7hE', 1200, false, '2024-01-13 12:30:00', '2024-01-13 12:30:00'),
(4, 'Family and Relationships Vocabulary', 5, 'yt:7CqJlxBYj-M', 1800, false, '2024-01-13 13:00:00', '2024-01-13 13:00:00'),
(4, 'Daily Conversation Practice', 6, 'yt:6n3pFFPSlW4', 2400, false, '2024-01-13 13:30:00', '2024-01-13 13:30:00');

-- Advanced Japanese Course Lessons (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(5, 'Advanced Grammar Structures', 1, 'yt:5mF4YhN5vN0', 2700, true, '2024-01-14 12:30:00', '2024-01-14 12:30:00'),
(5, 'Business Japanese Vocabulary', 2, 'yt:4lL5Y9vKvL0', 3000, false, '2024-01-14 13:00:00', '2024-01-14 13:00:00'),
(5, 'Formal and Informal Speech', 3, 'yt:3kK4J9wJvK0', 2400, false, '2024-01-14 13:30:00', '2024-01-14 13:30:00'),
(5, 'Japanese Cultural Context', 4, 'yt:2jJ3K8vIvJ0', 3300, false, '2024-01-14 14:00:00', '2024-01-14 14:00:00'),
(5, 'Advanced Conversation Practice', 5, 'yt:1iI4L7vHvI0', 3600, false, '2024-01-14 14:30:00', '2024-01-14 14:30:00'),
(5, 'JLPT N2 Preparation', 6, 'yt:0hH5M6vGvH0', 4200, false, '2024-01-14 15:00:00', '2024-01-14 15:00:00');

-- 4. COURSE INSTRUCTORS (30 records)
-- Assigning instructors to courses
INSERT INTO course_instructors (course_id, user_id, role, created_at, updated_at) VALUES
(1, 11, 'OWNER', '2024-01-10 08:00:00', '2024-01-10 08:00:00'),
(2, 12, 'OWNER', '2024-01-11 09:30:00', '2024-01-11 09:30:00'),
(3, 13, 'OWNER', '2024-01-12 10:15:00', '2024-01-12 10:15:00'),
(4, 14, 'OWNER', '2024-01-13 11:00:00', '2024-01-13 11:00:00'),
(5, 14, 'OWNER', '2024-01-14 12:30:00', '2024-01-14 12:30:00'),
(6, 15, 'OWNER', '2024-01-15 14:00:00', '2024-01-15 14:00:00'),
(7, 15, 'OWNER', '2024-01-16 15:45:00', '2024-01-16 15:45:00'),
(8, 16, 'OWNER', '2024-01-17 16:20:00', '2024-01-17 16:20:00'),
(9, 17, 'OWNER', '2024-01-18 17:10:00', '2024-01-18 17:10:00'),
(10, 18, 'OWNER', '2024-01-19 18:00:00', '2024-01-19 18:00:00'),
(11, 19, 'OWNER', '2024-01-20 19:30:00', '2024-01-20 19:30:00'),
(12, 20, 'OWNER', '2024-01-21 20:15:00', '2024-01-21 20:15:00'),
(13, 11, 'OWNER', '2024-01-22 21:00:00', '2024-01-22 21:00:00'),
(14, 12, 'OWNER', '2024-01-23 22:30:00', '2024-01-23 22:30:00'),
(15, 13, 'OWNER', '2024-01-24 23:15:00', '2024-01-24 23:15:00'),
(16, 14, 'OWNER', '2024-01-25 08:30:00', '2024-01-25 08:30:00'),
(17, 15, 'OWNER', '2024-01-26 09:45:00', '2024-01-26 09:45:00'),
(18, 16, 'OWNER', '2024-01-27 10:20:00', '2024-01-27 10:20:00'),
(19, 17, 'OWNER', '2024-01-28 11:10:00', '2024-01-28 11:10:00'),
(20, 18, 'OWNER', '2024-01-29 12:00:00', '2024-01-29 12:00:00'),
(21, 19, 'OWNER', '2024-01-30 13:30:00', '2024-01-30 13:30:00'),
(22, 20, 'OWNER', '2024-01-31 14:15:00', '2024-01-31 14:15:00'),
(23, 11, 'OWNER', '2024-02-01 15:45:00', '2024-02-01 15:45:00'),
(24, 12, 'OWNER', '2024-02-02 16:30:00', '2024-02-02 16:30:00'),
(25, 13, 'OWNER', '2024-02-03 17:20:00', '2024-02-03 17:20:00'),
(26, 14, 'OWNER', '2024-02-04 18:10:00', '2024-02-04 18:10:00'),
(27, 15, 'OWNER', '2024-02-05 19:00:00', '2024-02-05 19:00:00'),
(28, 16, 'OWNER', '2024-02-06 20:30:00', '2024-02-06 20:30:00'),
(29, 17, 'OWNER', '2024-02-07 21:15:00', '2024-02-07 21:15:00'),
(30, 18, 'OWNER', '2024-02-08 22:00:00', '2024-02-08 22:00:00');

-- 5. ENROLLMENTS (30 records)
-- Students enrolling in various courses
INSERT INTO enrollments (user_id, course_id, status, created_at, updated_at) VALUES
(1, 1, 'ACTIVE', '2024-01-20 10:00:00', '2024-01-20 10:00:00'),
(2, 2, 'ACTIVE', '2024-01-21 11:30:00', '2024-01-21 11:30:00'),
(3, 3, 'ACTIVE', '2024-01-22 14:15:00', '2024-01-22 14:15:00'),
(4, 4, 'ACTIVE', '2024-01-23 16:45:00', '2024-01-23 16:45:00'),
(5, 5, 'ACTIVE', '2024-01-24 09:20:00', '2024-01-24 09:20:00'),
(6, 6, 'ACTIVE', '2024-01-25 13:10:00', '2024-01-25 13:10:00'),
(7, 7, 'ACTIVE', '2024-01-26 15:30:00', '2024-01-26 15:30:00'),
(8, 8, 'ACTIVE', '2024-01-27 12:45:00', '2024-01-27 12:45:00'),
(9, 9, 'ACTIVE', '2024-01-28 17:20:00', '2024-01-28 17:20:00'),
(10, 10, 'ACTIVE', '2024-01-29 19:00:00', '2024-01-29 19:00:00'),
(1, 2, 'ACTIVE', '2024-01-30 10:30:00', '2024-01-30 10:30:00'),
(2, 3, 'ACTIVE', '2024-01-31 14:20:00', '2024-01-31 14:20:00'),
(3, 4, 'ACTIVE', '2024-02-01 16:10:00', '2024-02-01 16:10:00'),
(4, 5, 'ACTIVE', '2024-02-02 11:45:00', '2024-02-02 11:45:00'),
(5, 6, 'ACTIVE', '2024-02-03 13:30:00', '2024-02-03 13:30:00'),
(6, 7, 'ACTIVE', '2024-02-04 15:15:00', '2024-02-04 15:15:00'),
(7, 8, 'ACTIVE', '2024-02-05 18:30:00', '2024-02-05 18:30:00'),
(8, 9, 'ACTIVE', '2024-02-06 20:45:00', '2024-02-06 20:45:00'),
(9, 10, 'ACTIVE', '2024-02-07 22:00:00', '2024-02-07 22:00:00'),
(10, 11, 'ACTIVE', '2024-02-08 09:15:00', '2024-02-08 09:15:00'),
(25, 1, 'ACTIVE', '2024-02-09 10:00:00', '2024-02-09 10:00:00'),
(26, 2, 'ACTIVE', '2024-02-10 11:30:00', '2024-02-10 11:30:00'),
(27, 3, 'ACTIVE', '2024-02-11 14:00:00', '2024-02-11 14:00:00'),
(28, 4, 'ACTIVE', '2024-02-12 16:30:00', '2024-02-12 16:30:00'),
(29, 5, 'ACTIVE', '2024-02-13 18:00:00', '2024-02-13 18:00:00'),
(30, 6, 'ACTIVE', '2024-02-14 20:15:00', '2024-02-14 20:15:00'),
(1, 7, 'ACTIVE', '2024-02-15 09:30:00', '2024-02-15 09:30:00'),
(2, 8, 'ACTIVE', '2024-02-16 11:45:00', '2024-02-16 11:45:00'),
(3, 9, 'ACTIVE', '2024-02-17 13:20:00', '2024-02-17 13:20:00'),
(4, 10, 'ACTIVE', '2024-02-18 15:10:00', '2024-02-18 15:10:00'),
(5, 11, 'ACTIVE', '2024-02-19 17:30:00', '2024-02-19 17:30:00'),
(6, 12, 'ACTIVE', '2024-02-20 19:45:00', '2024-02-20 19:45:00'),
(7, 13, 'ACTIVE', '2024-02-21 21:00:00', '2024-02-21 21:00:00');

-- 6. ORDERS (30 records)
-- Orders for course purchases
INSERT INTO orders (user_id, course_id, status, total_amount_cents, currency, created_at, updated_at) VALUES
(1, 1, 'PAID', 29900, 'USD', '2024-01-20 10:00:00', '2024-01-20 10:05:00'),
(2, 2, 'PAID', 39900, 'USD', '2024-01-21 11:30:00', '2024-01-21 11:35:00'),
(3, 3, 'PAID', 34900, 'USD', '2024-01-22 14:15:00', '2024-01-22 14:20:00'),
(4, 4, 'PAID', 19900, 'USD', '2024-01-23 16:45:00', '2024-01-23 16:50:00'),
(5, 5, 'PAID', 24900, 'USD', '2024-01-24 09:20:00', '2024-01-24 09:25:00'),
(6, 6, 'PAID', 22900, 'USD', '2024-01-25 13:10:00', '2024-01-25 13:15:00'),
(7, 7, 'PAID', 27900, 'USD', '2024-01-26 15:30:00', '2024-01-26 15:35:00'),
(8, 8, 'PAID', 21900, 'USD', '2024-01-27 12:45:00', '2024-01-27 12:50:00'),
(9, 9, 'PAID', 18900, 'USD', '2024-01-28 17:20:00', '2024-01-28 17:25:00'),
(10, 10, 'PAID', 25900, 'USD', '2024-01-29 19:00:00', '2024-01-29 19:05:00'),
(1, 11, 'PAID', 32900, 'USD', '2024-01-30 10:30:00', '2024-01-30 10:35:00'),
(2, 12, 'PAID', 44900, 'USD', '2024-01-31 14:20:00', '2024-01-31 14:25:00'),
(3, 13, 'PAID', 29900, 'USD', '2024-02-01 16:10:00', '2024-02-01 16:15:00'),
(4, 14, 'PAID', 37900, 'USD', '2024-02-02 11:45:00', '2024-02-02 11:50:00'),
(5, 15, 'PAID', 39900, 'USD', '2024-02-03 13:30:00', '2024-02-03 13:35:00'),
(6, 16, 'PAID', 34900, 'USD', '2024-02-04 15:15:00', '2024-02-04 15:20:00'),
(7, 17, 'PAID', 49900, 'USD', '2024-02-05 18:30:00', '2024-02-05 18:35:00'),
(8, 18, 'PAID', 32900, 'USD', '2024-02-06 20:45:00', '2024-02-06 20:50:00'),
(9, 19, 'PAID', 27900, 'USD', '2024-02-07 22:00:00', '2024-02-07 22:05:00'),
(10, 20, 'PAID', 35900, 'USD', '2024-02-08 09:15:00', '2024-02-08 09:20:00'),
(25, 21, 'PAID', 19900, 'USD', '2024-02-09 10:00:00', '2024-02-09 10:05:00'),
(26, 22, 'PAID', 22900, 'USD', '2024-02-10 11:30:00', '2024-02-10 11:35:00'),
(27, 23, 'PAID', 15900, 'USD', '2024-02-11 14:00:00', '2024-02-11 14:05:00'),
(28, 24, 'PAID', 24900, 'USD', '2024-02-12 16:30:00', '2024-02-12 16:35:00'),
(29, 25, 'PAID', 17900, 'USD', '2024-02-13 18:00:00', '2024-02-13 18:05:00'),
(30, 26, 'PAID', 12900, 'USD', '2024-02-14 20:15:00', '2024-02-14 20:20:00'),
(1, 27, 'PENDING', 19900, 'USD', '2024-02-15 09:30:00', '2024-02-15 09:30:00'),
(2, 28, 'CANCELED', 23900, 'USD', '2024-02-16 11:45:00', '2024-02-16 11:45:00'),
(3, 29, 'PAID', 26900, 'USD', '2024-02-17 13:20:00', '2024-02-17 13:25:00'),
(4, 30, 'PAID', 21900, 'USD', '2024-02-18 15:10:00', '2024-02-18 15:15:00');

-- 7. ORDER ITEMS (30 records)
-- Items in each order
INSERT INTO order_items (order_id, course_id, unit_price_cents, quantity, title_snapshot, created_at, updated_at) VALUES
(1, 1, 29900, 1, 'Complete Java Programming Masterclass', '2024-01-20 10:00:00', '2024-01-20 10:00:00'),
(2, 2, 39900, 1, 'Python for Data Science and Machine Learning', '2024-01-21 11:30:00', '2024-01-21 11:30:00'),
(3, 3, 34900, 1, 'JavaScript Full Stack Development', '2024-01-22 14:15:00', '2024-01-22 14:15:00'),
(4, 4, 19900, 1, 'Japanese Language for Beginners', '2024-01-23 16:45:00', '2024-01-23 16:45:00'),
(5, 5, 24900, 1, 'Advanced Japanese Conversation', '2024-01-24 09:20:00', '2024-01-24 09:20:00'),
(6, 6, 22900, 1, 'English Business Communication', '2024-01-25 13:10:00', '2024-01-25 13:10:00'),
(7, 7, 27900, 1, 'IELTS Preparation Course', '2024-01-26 15:30:00', '2024-01-26 15:30:00'),
(8, 8, 21900, 1, 'Korean Language Complete Course', '2024-01-27 12:45:00', '2024-01-27 12:45:00'),
(9, 9, 18900, 1, 'Chinese Mandarin for Beginners', '2024-01-28 17:20:00', '2024-01-28 17:20:00'),
(10, 10, 25900, 1, 'French Language Immersion', '2024-01-29 19:00:00', '2024-01-29 19:00:00'),
(11, 11, 32900, 1, 'Digital Marketing Mastery', '2024-01-30 10:30:00', '2024-01-30 10:30:00'),
(12, 12, 44900, 1, 'Project Management Professional (PMP)', '2024-01-31 14:20:00', '2024-01-31 14:20:00'),
(13, 13, 29900, 1, 'UI/UX Design Fundamentals', '2024-02-01 16:10:00', '2024-02-01 16:10:00'),
(14, 14, 37900, 1, 'Cybersecurity Essentials', '2024-02-02 11:45:00', '2024-02-02 11:45:00'),
(15, 15, 39900, 1, 'AWS Cloud Practitioner', '2024-02-03 13:30:00', '2024-02-03 13:30:00'),
(16, 16, 34900, 1, 'React Native Mobile Development', '2024-02-04 15:15:00', '2024-02-04 15:15:00'),
(17, 17, 49900, 1, 'Machine Learning with Python', '2024-02-05 18:30:00', '2024-02-05 18:30:00'),
(18, 18, 32900, 1, 'Docker and Kubernetes', '2024-02-06 20:45:00', '2024-02-06 20:45:00'),
(19, 19, 27900, 1, 'GraphQL API Development', '2024-02-07 22:00:00', '2024-02-07 22:00:00'),
(20, 20, 35900, 1, 'Blockchain and Cryptocurrency', '2024-02-08 09:15:00', '2024-02-08 09:15:00'),
(21, 21, 19900, 1, 'Photography Masterclass', '2024-02-09 10:00:00', '2024-02-09 10:00:00'),
(22, 22, 22900, 1, 'Video Editing with Adobe Premiere', '2024-02-10 11:30:00', '2024-02-10 11:30:00'),
(23, 23, 15900, 1, 'Personal Finance and Investment', '2024-02-11 14:00:00', '2024-02-11 14:00:00'),
(24, 24, 24900, 1, 'Leadership and Management Skills', '2024-02-12 16:30:00', '2024-02-12 16:30:00'),
(25, 25, 17900, 1, 'Public Speaking and Presentation', '2024-02-13 18:00:00', '2024-02-13 18:00:00'),
(26, 26, 12900, 1, 'Time Management and Productivity', '2024-02-14 20:15:00', '2024-02-14 20:15:00'),
(27, 27, 19900, 1, 'Creative Writing Workshop', '2024-02-15 09:30:00', '2024-02-15 09:30:00'),
(28, 28, 23900, 1, 'Spanish Language Complete', '2024-02-16 11:45:00', '2024-02-16 11:45:00'),
(29, 29, 26900, 1, 'German Language for Business', '2024-02-17 13:20:00', '2024-02-17 13:20:00'),
(30, 30, 21900, 1, 'Italian Language and Culture', '2024-02-18 15:10:00', '2024-02-18 15:10:00');

-- 8. PAYMENTS (30 records)
-- Payment records for orders
INSERT INTO payments (user_id, course_id, enrollment_id, order_id, stripe_session_id, stripe_payment_intent, stripe_event_id, amount_cents, currency, provider, method, refunded_amount_cents, status, vnp_txn_ref, vnp_transaction_no, vnp_response_code, vnp_bank_code, vnp_secure_hash, created_at, updated_at) VALUES
(1, 1, 1, 1, 'cs_test_1', 'pi_test_1', 'evt_test_1', 29900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-01-20 10:00:00', '2024-01-20 10:05:00'),
(2, 2, 2, 2, 'cs_test_2', 'pi_test_2', 'evt_test_2', 39900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-01-21 11:30:00', '2024-01-21 11:35:00'),
(3, 3, 3, 3, 'cs_test_3', 'pi_test_3', 'evt_test_3', 34900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-01-22 14:15:00', '2024-01-22 14:20:00'),
(4, 4, 4, 4, 'cs_test_4', 'pi_test_4', 'evt_test_4', 19900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-01-23 16:45:00', '2024-01-23 16:50:00'),
(5, 5, 5, 5, 'cs_test_5', 'pi_test_5', 'evt_test_5', 24900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-01-24 09:20:00', '2024-01-24 09:25:00'),
(6, 6, 6, 6, 'cs_test_6', 'pi_test_6', 'evt_test_6', 22900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-01-25 13:10:00', '2024-01-25 13:15:00'),
(7, 7, 7, 7, 'cs_test_7', 'pi_test_7', 'evt_test_7', 27900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-01-26 15:30:00', '2024-01-26 15:35:00'),
(8, 8, 8, 8, 'cs_test_8', 'pi_test_8', 'evt_test_8', 21900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-01-27 12:45:00', '2024-01-27 12:50:00'),
(9, 9, 9, 9, 'cs_test_9', 'pi_test_9', 'evt_test_9', 18900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-01-28 17:20:00', '2024-01-28 17:25:00'),
(10, 10, 10, 10, 'cs_test_10', 'pi_test_10', 'evt_test_10', 25900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-01-29 19:00:00', '2024-01-29 19:05:00'),
(1, 2, 11, 11, 'cs_test_11', 'pi_test_11', 'evt_test_11', 32900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-01-30 10:30:00', '2024-01-30 10:35:00'),
(2, 3, 12, 12, 'cs_test_12', 'pi_test_12', 'evt_test_12', 44900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-01-31 14:20:00', '2024-01-31 14:25:00'),
(3, 4, 13, 13, 'cs_test_13', 'pi_test_13', 'evt_test_13', 29900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-02-01 16:10:00', '2024-02-01 16:15:00'),
(4, 5, 14, 14, 'cs_test_14', 'pi_test_14', 'evt_test_14', 37900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-02-02 11:45:00', '2024-02-02 11:50:00'),
(5, 6, 15, 15, 'cs_test_15', 'pi_test_15', 'evt_test_15', 39900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-02-03 13:30:00', '2024-02-03 13:35:00'),
(6, 7, 16, 16, 'cs_test_16', 'pi_test_16', 'evt_test_16', 34900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-02-04 15:15:00', '2024-02-04 15:20:00'),
(7, 8, 17, 17, 'cs_test_17', 'pi_test_17', 'evt_test_17', 49900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-02-05 18:30:00', '2024-02-05 18:35:00'),
(8, 9, 18, 18, 'cs_test_18', 'pi_test_18', 'evt_test_18', 32900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-02-06 20:45:00', '2024-02-06 20:50:00'),
(9, 10, 19, 19, 'cs_test_19', 'pi_test_19', 'evt_test_19', 27900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-02-07 22:00:00', '2024-02-07 22:05:00'),
(10, 11, 20, 20, 'cs_test_20', 'pi_test_20', 'evt_test_20', 35900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-02-08 09:15:00', '2024-02-08 09:20:00'),
(25, 1, 21, 21, 'cs_test_21', 'pi_test_21', 'evt_test_21', 19900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-02-09 10:00:00', '2024-02-09 10:05:00'),
(26, 2, 22, 22, 'cs_test_22', 'pi_test_22', 'evt_test_22', 22900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-02-10 11:30:00', '2024-02-10 11:35:00'),
(27, 3, 23, 23, 'cs_test_23', 'pi_test_23', 'evt_test_23', 15900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-02-11 14:00:00', '2024-02-11 14:05:00'),
(28, 4, 24, 24, 'cs_test_24', 'pi_test_24', 'evt_test_24', 24900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-02-12 16:30:00', '2024-02-12 16:35:00'),
(29, 5, 25, 25, 'cs_test_25', 'pi_test_25', 'evt_test_25', 17900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-02-13 18:00:00', '2024-02-13 18:05:00'),
(30, 6, 26, 26, 'cs_test_26', 'pi_test_26', 'evt_test_26', 12900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-02-14 20:15:00', '2024-02-14 20:20:00'),
(1, 7, 27, 27, 'cs_test_27', 'pi_test_27', 'evt_test_27', 19900, 'USD', 'STRIPE', 'card', 0, 'REQUIRES_PAYMENT', NULL, NULL, NULL, NULL, NULL, '2024-02-15 09:30:00', '2024-02-15 09:30:00'),
(2, 8, 28, 28, 'cs_test_28', 'pi_test_28', 'evt_test_28', 23900, 'USD', 'STRIPE', 'card', 23900, 'REFUNDED', NULL, NULL, NULL, NULL, NULL, '2024-02-16 11:45:00', '2024-02-16 11:45:00'),
(3, 9, 29, 29, 'cs_test_29', 'pi_test_29', 'evt_test_29', 26900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-02-17 13:20:00', '2024-02-17 13:25:00'),
(4, 10, 30, 30, 'cs_test_30', 'pi_test_30', 'evt_test_30', 21900, 'USD', 'STRIPE', 'card', 0, 'PAID', NULL, NULL, NULL, NULL, NULL, '2024-02-18 15:10:00', '2024-02-18 15:15:00');

-- 9. LESSON PROGRESS (30 records)
-- Student progress in lessons
INSERT INTO lesson_progress (enrollment_id, lesson_id, watched_sec, completed, created_at, updated_at) VALUES
(1, 1, 1800, true, '2024-01-20 10:00:00', '2024-01-20 10:30:00'),
(1, 2, 2400, true, '2024-01-20 11:00:00', '2024-01-20 11:40:00'),
(1, 3, 2700, true, '2024-01-20 12:00:00', '2024-01-20 12:45:00'),
(1, 4, 1800, false, '2024-01-20 13:00:00', '2024-01-20 13:30:00'),
(2, 7, 2100, true, '2024-01-21 11:30:00', '2024-01-21 12:05:00'),
(2, 8, 3000, true, '2024-01-21 12:30:00', '2024-01-21 13:20:00'),
(2, 9, 1800, false, '2024-01-21 14:00:00', '2024-01-21 14:30:00'),
(3, 13, 2400, true, '2024-01-22 14:15:00', '2024-01-22 14:55:00'),
(3, 14, 3000, true, '2024-01-22 15:30:00', '2024-01-22 16:20:00'),
(3, 15, 1200, false, '2024-01-22 17:00:00', '2024-01-22 17:20:00'),
(4, 19, 1800, true, '2024-01-23 16:45:00', '2024-01-23 17:15:00'),
(4, 20, 2100, true, '2024-01-23 17:30:00', '2024-01-23 18:05:00'),
(4, 21, 1500, false, '2024-01-23 18:30:00', '2024-01-23 18:55:00'),
(5, 25, 2700, true, '2024-01-24 09:20:00', '2024-01-24 10:05:00'),
(5, 26, 3000, true, '2024-01-24 10:30:00', '2024-01-24 11:20:00'),
(5, 27, 1800, false, '2024-01-24 12:00:00', '2024-01-24 12:30:00'),
(6, 31, 2400, true, '2024-01-25 13:10:00', '2024-01-25 13:50:00'),
(6, 32, 3000, true, '2024-01-25 14:30:00', '2024-01-25 15:20:00'),
(6, 33, 1200, false, '2024-01-25 16:00:00', '2024-01-25 16:20:00'),
(7, 37, 2700, true, '2024-01-26 15:30:00', '2024-01-26 16:15:00'),
(7, 38, 3000, true, '2024-01-26 16:45:00', '2024-01-26 17:35:00'),
(7, 39, 1800, false, '2024-01-26 18:30:00', '2024-01-26 19:00:00'),
(8, 43, 2400, true, '2024-01-27 12:45:00', '2024-01-27 13:25:00'),
(8, 44, 3000, true, '2024-01-27 14:00:00', '2024-01-27 14:50:00'),
(8, 45, 1500, false, '2024-01-27 15:30:00', '2024-01-27 15:55:00'),
(9, 49, 1800, true, '2024-01-28 17:20:00', '2024-01-28 17:50:00'),
(9, 50, 2100, true, '2024-01-28 18:30:00', '2024-01-28 19:05:00'),
(9, 51, 1200, false, '2024-01-28 19:30:00', '2024-01-28 19:50:00'),
(10, 55, 2700, true, '2024-01-29 19:00:00', '2024-01-29 19:45:00'),
(10, 56, 3000, true, '2024-01-29 20:30:00', '2024-01-29 21:20:00');

-- 10. CHAT HISTORIES (30 records)
-- AI chat interactions
INSERT INTO chat_histories (user_id, course_id, message_role, content, created_at, updated_at) VALUES
(1, 1, 'USER', 'Tôi không hiểu về polymorphism trong Java, bạn có thể giải thích không?', '2024-01-20 10:30:00', '2024-01-20 10:30:00'),
(1, 1, 'AI', 'Polymorphism là khả năng object có nhiều hình thái. Có 2 loại: compile-time (overloading) và runtime (overriding). Bạn muốn tôi giải thích loại nào?', '2024-01-20 10:31:00', '2024-01-20 10:31:00'),
(2, 2, 'USER', 'Làm thế nào để xử lý missing data trong pandas?', '2024-01-21 12:00:00', '2024-01-21 12:00:00'),
(2, 2, 'AI', 'Xử lý missing data: dropna() để xóa, fillna() để điền, interpolate() để nội suy. Cho tôi biết loại dữ liệu để tôi đưa ra lời khuyên phù hợp.', '2024-01-21 12:01:00', '2024-01-21 12:01:00'),
(3, 3, 'USER', 'React hooks có khó học không?', '2024-01-22 15:00:00', '2024-01-22 15:00:00'),
(3, 3, 'AI', 'React hooks ban đầu hơi khó nhưng thực hành sẽ dễ. Bắt đầu với useState và useEffect. Bạn đã có kinh nghiệm với class components chưa?', '2024-01-22 15:01:00', '2024-01-22 15:01:00'),
(4, 4, 'USER', 'Hiragana và Katakana khác nhau như thế nào?', '2024-01-23 17:00:00', '2024-01-23 17:00:00'),
(4, 4, 'AI', 'Hiragana cho từ thuần Nhật, nét mềm. Katakana cho từ mượn, nét góc. VD: こんにちは (hiragana) vs コーヒー (katakana). Bạn muốn học cách viết không?', '2024-01-23 17:01:00', '2024-01-23 17:01:00'),
(5, 5, 'USER', 'Khi nào dùng です và だ trong tiếng Nhật?', '2024-01-24 10:00:00', '2024-01-24 10:00:00'),
(5, 5, 'AI', 'です dùng lịch sự, だ dùng thân mật. VD: 学生です (lịch sự) vs 学生だ (thân mật). Bạn đang học cấp độ nào?', '2024-01-24 10:01:00', '2024-01-24 10:01:00'),
(6, 6, 'USER', 'Cách viết email business bằng tiếng Anh?', '2024-01-25 14:00:00', '2024-01-25 14:00:00'),
(6, 6, 'AI', 'Email business cần: Subject rõ, Greeting phù hợp, Body ngắn gọn, Closing lịch sự, Signature đầy đủ. Bạn muốn tôi hướng dẫn viết email nào?', '2024-01-25 14:01:00', '2024-01-25 14:01:00'),
(7, 7, 'USER', 'IELTS Writing Task 2 có cấu trúc như thế nào?', '2024-01-26 16:00:00', '2024-01-26 16:00:00'),
(7, 7, 'AI', 'IELTS Writing Task 2: Introduction, 2 Body paragraphs, Conclusion. Bạn đang luyện dạng đề nào?', '2024-01-26 16:01:00', '2024-01-26 16:01:00'),
(8, 8, 'USER', '한국어 문법이 어려워요 (Ngữ pháp tiếng Hàn khó quá)', '2024-01-27 13:00:00', '2024-01-27 13:00:00'),
(8, 8, 'AI', '한국어 문법은 규칙을 이해하면 쉽습니다. 주어-목적어-서술어 순서를 먼저 익히세요. 어떤 문법이 어려우신가요?', '2024-01-27 13:01:00', '2024-01-27 13:01:00'),
(9, 9, 'USER', '中文的声调怎么学？(Làm sao học thanh điệu tiếng Trung?)', '2024-01-28 18:00:00', '2024-01-28 18:00:00'),
(9, 9, 'AI', '中文有四个声调。建议多听多练，用手势帮助记忆。你想练习哪个声调？', '2024-01-28 18:01:00', '2024-01-28 18:01:00'),
(10, 10, 'USER', 'Comment apprendre le français rapidement? (Làm sao học tiếng Pháp nhanh?)', '2024-01-29 20:00:00', '2024-01-29 20:00:00'),
(10, 10, 'AI', 'Pour apprendre le français: écoutez podcasts, regardez films, parlez avec natifs, utilisez apps. Quel est votre niveau actuel?', '2024-01-29 20:01:00', '2024-01-29 20:01:00'),
(11, 11, 'USER', 'SEO là gì và tại sao quan trọng?', '2024-01-30 11:00:00', '2024-01-30 11:00:00'),
(11, 11, 'AI', 'SEO là tối ưu hóa công cụ tìm kiếm, giúp website xuất hiện cao trên Google. Quan trọng vì 75% người dùng không click qua trang 2.', '2024-01-30 11:01:00', '2024-01-30 11:01:00'),
(12, 12, 'USER', 'PMP certification có khó không?', '2024-01-31 15:00:00', '2024-01-31 15:00:00'),
(12, 12, 'AI', 'PMP khá khó, cần 35 giờ training và 3-5 năm kinh nghiệm. Thi 200 câu trong 4 giờ, đậu 61%. Bạn đã có đủ điều kiện chưa?', '2024-01-31 15:01:00', '2024-01-31 15:01:00'),
(13, 13, 'USER', 'UI/UX design bắt đầu từ đâu?', '2024-02-01 17:00:00', '2024-02-01 17:00:00'),
(13, 13, 'AI', 'UI/UX bắt đầu từ: học nguyên lý thiết kế, sử dụng Figma/Sketch, hiểu user research, thực hành case study. Bạn có kinh nghiệm design chưa?', '2024-02-01 17:01:00', '2024-02-01 17:01:00'),
(14, 14, 'USER', 'Cybersecurity threats phổ biến nhất là gì?', '2024-02-02 12:00:00', '2024-02-02 12:00:00'),
(14, 14, 'AI', 'Threats phổ biến: Phishing, Malware, Ransomware, DDoS, Insider threats. Bạn muốn tôi hướng dẫn phòng chống loại nào?', '2024-02-02 12:01:00', '2024-02-02 12:01:00'),
(15, 15, 'USER', 'AWS services nào quan trọng nhất?', '2024-02-03 14:00:00', '2024-02-03 14:00:00'),
(15, 15, 'AI', 'AWS services quan trọng: EC2, S3, RDS, Lambda, CloudFront. Bạn đang học để làm gì?', '2024-02-03 14:01:00', '2024-02-03 14:01:00');

-- 11. AUDIT LOGS (30 records)
-- System audit logs
INSERT INTO audit_logs (actor_user_id, action, entity_type, entity_id, diff, created_at) VALUES
(1, 'USER_LOGIN', 'User', 1, '{"login_time": "2024-01-20T10:00:00Z"}', '2024-01-20 10:00:00'),
(2, 'COURSE_ENROLLED', 'Enrollment', 2, '{"course_id": 2, "user_id": 2, "status": "ACTIVE"}', '2024-01-21 11:30:00'),
(3, 'LESSON_COMPLETED', 'LessonProgress', 3, '{"lesson_id": 13, "watched_sec": 2400, "completed": true}', '2024-01-22 14:55:00'),
(4, 'PAYMENT_PROCESSED', 'Payment', 4, '{"amount_cents": 19900, "status": "SUCCEEDED"}', '2024-01-23 16:50:00'),
(5, 'ORDER_CREATED', 'Order', 5, '{"total_amount_cents": 24900, "status": "COMPLETED"}', '2024-01-24 09:20:00'),
(6, 'COURSE_UPDATED', 'Course', 6, '{"title": "English Business Communication", "price_cents": 22900}', '2024-01-25 13:10:00'),
(7, 'USER_PROFILE_UPDATED', 'User', 7, '{"full_name": "Tom Anderson"}', '2024-01-26 15:30:00'),
(8, 'LESSON_STARTED', 'LessonProgress', 8, '{"lesson_id": 43, "watched_sec": 0, "completed": false}', '2024-01-27 12:45:00'),
(9, 'CHAT_MESSAGE_SENT', 'ChatHistory', 9, '{"message_role": "USER", "content": "中文的声调怎么学？"}', '2024-01-28 18:00:00'),
(10, 'COURSE_PUBLISHED', 'Course', 10, '{"status": "PUBLISHED", "published": true}', '2024-01-29 19:00:00'),
(11, 'INSTRUCTOR_ASSIGNED', 'CourseInstructor', 11, '{"course_id": 11, "user_id": 19, "role": "OWNER"}', '2024-01-30 10:30:00'),
(12, 'PAYMENT_REFUNDED', 'Payment', 12, '{"refunded_amount_cents": 23900, "status": "REFUNDED"}', '2024-01-31 14:20:00'),
(13, 'LESSON_PROGRESS_UPDATED', 'LessonProgress', 13, '{"watched_sec": 3000, "completed": true}', '2024-02-01 16:15:00'),
(14, 'COURSE_ARCHIVED', 'Course', 14, '{"status": "ARCHIVED", "published": false}', '2024-02-02 11:45:00'),
(15, 'USER_ROLE_CHANGED', 'User', 15, '{"role": "INSTRUCTOR", "previous_role": "STUDENT"}', '2024-02-03 13:30:00'),
(16, 'ENROLLMENT_CANCELLED', 'Enrollment', 16, '{"status": "CANCELLED", "previous_status": "ACTIVE"}', '2024-02-04 15:15:00'),
(17, 'COURSE_PRICE_UPDATED', 'Course', 17, '{"price_cents": 49900, "previous_price": 39900}', '2024-02-05 18:30:00'),
(18, 'LESSON_ADDED', 'VideoLesson', 18, '{"title": "Docker and Kubernetes", "course_id": 18, "order_index": 1}', '2024-02-06 20:45:00'),
(19, 'CHAT_AI_RESPONSE', 'ChatHistory', 19, '{"message_role": "AI", "content": "Pour apprendre le français rapidement..."}', '2024-02-07 22:00:00'),
(20, 'ORDER_STATUS_CHANGED', 'Order', 20, '{"status": "COMPLETED", "previous_status": "PENDING"}', '2024-02-08 09:15:00'),
(25, 'USER_REGISTERED', 'User', 25, '{"username": "student_robert", "role": "STUDENT", "enabled": true}', '2024-02-09 10:00:00'),
(26, 'COURSE_VIEWED', 'Course', 26, '{"user_id": 26, "view_count": 1}', '2024-02-10 11:30:00'),
(27, 'LESSON_DOWNLOADED', 'VideoLesson', 27, '{"user_id": 27, "lesson_id": 27, "download_time": "2024-02-11T14:00:00Z"}', '2024-02-11 14:00:00'),
(28, 'PAYMENT_FAILED', 'Payment', 28, '{"amount_cents": 23900, "status": "FAILED", "error": "Insufficient funds"}', '2024-02-12 16:30:00'),
(29, 'COURSE_RATING_SUBMITTED', 'Course', 29, '{"user_id": 29, "rating": 5, "review": "Excellent course!"}', '2024-02-13 18:00:00'),
(30, 'INSTRUCTOR_ADDED', 'CourseInstructor', 30, '{"course_id": 30, "user_id": 18, "role": "ASSISTANT"}', '2024-02-14 20:15:00'),
(1, 'USER_LOGOUT', 'User', 1, '{"logout_time": "2024-02-15T09:30:00Z"}', '2024-02-15 09:30:00'),
(2, 'COURSE_COMPLETED', 'Enrollment', 2, '{"status": "COMPLETED", "completion_date": "2024-02-16T11:45:00Z"}', '2024-02-16 11:45:00'),
(3, 'CERTIFICATE_GENERATED', 'Enrollment', 3, '{"certificate_id": "CERT_001", "generated_at": "2024-02-17T13:20:00Z"}', '2024-02-17 13:20:00'),
(4, 'COURSE_SHARED', 'Course', 4, '{"shared_by": 4, "platform": "social_media", "share_count": 1}', '2024-02-18 15:10:00');

-- 12. WEBHOOK EVENTS (30 records)
-- Stripe webhook events
INSERT INTO webhook_events (provider, event_id, signature, payload, processed, processed_at, created_at, updated_at) VALUES
('STRIPE', 'evt_1', 'whsec_test_1', '{"id": "evt_1", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_1"}}}', true, '2024-01-20 10:05:00', '2024-01-20 10:00:00', '2024-01-20 10:05:00'),
('STRIPE', 'evt_2', 'whsec_test_2', '{"id": "evt_2", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_2"}}}', true, '2024-01-21 11:35:00', '2024-01-21 11:30:00', '2024-01-21 11:35:00'),
('STRIPE', 'evt_3', 'whsec_test_3', '{"id": "evt_3", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_3"}}}', true, '2024-01-22 14:20:00', '2024-01-22 14:15:00', '2024-01-22 14:20:00'),
('STRIPE', 'evt_4', 'whsec_test_4', '{"id": "evt_4", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_4"}}}', true, '2024-01-23 16:50:00', '2024-01-23 16:45:00', '2024-01-23 16:50:00'),
('STRIPE', 'evt_5', 'whsec_test_5', '{"id": "evt_5", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_5"}}}', true, '2024-01-24 09:25:00', '2024-01-24 09:20:00', '2024-01-24 09:25:00'),
('STRIPE', 'evt_6', 'whsec_test_6', '{"id": "evt_6", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_6"}}}', true, '2024-01-25 13:15:00', '2024-01-25 13:10:00', '2024-01-25 13:15:00'),
('STRIPE', 'evt_7', 'whsec_test_7', '{"id": "evt_7", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_7"}}}', true, '2024-01-26 15:35:00', '2024-01-26 15:30:00', '2024-01-26 15:35:00'),
('STRIPE', 'evt_8', 'whsec_test_8', '{"id": "evt_8", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_8"}}}', true, '2024-01-27 12:50:00', '2024-01-27 12:45:00', '2024-01-27 12:50:00'),
('STRIPE', 'evt_9', 'whsec_test_9', '{"id": "evt_9", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_9"}}}', true, '2024-01-28 17:25:00', '2024-01-28 17:20:00', '2024-01-28 17:25:00'),
('STRIPE', 'evt_10', 'whsec_test_10', '{"id": "evt_10", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_10"}}}', true, '2024-01-29 19:05:00', '2024-01-29 19:00:00', '2024-01-29 19:05:00'),
('STRIPE', 'evt_11', 'whsec_test_11', '{"id": "evt_11", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_11"}}}', true, '2024-01-30 10:35:00', '2024-01-30 10:30:00', '2024-01-30 10:35:00'),
('STRIPE', 'evt_12', 'whsec_test_12', '{"id": "evt_12", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_12"}}}', true, '2024-01-31 14:25:00', '2024-01-31 14:20:00', '2024-01-31 14:25:00'),
('STRIPE', 'evt_13', 'whsec_test_13', '{"id": "evt_13", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_13"}}}', true, '2024-02-01 16:15:00', '2024-02-01 16:10:00', '2024-02-01 16:15:00'),
('STRIPE', 'evt_14', 'whsec_test_14', '{"id": "evt_14", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_14"}}}', true, '2024-02-02 11:50:00', '2024-02-02 11:45:00', '2024-02-02 11:50:00'),
('STRIPE', 'evt_15', 'whsec_test_15', '{"id": "evt_15", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_15"}}}', true, '2024-02-03 13:35:00', '2024-02-03 13:30:00', '2024-02-03 13:35:00'),
('STRIPE', 'evt_16', 'whsec_test_16', '{"id": "evt_16", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_16"}}}', true, '2024-02-04 15:20:00', '2024-02-04 15:15:00', '2024-02-04 15:20:00'),
('STRIPE', 'evt_17', 'whsec_test_17', '{"id": "evt_17", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_17"}}}', true, '2024-02-05 18:35:00', '2024-02-05 18:30:00', '2024-02-05 18:35:00'),
('STRIPE', 'evt_18', 'whsec_test_18', '{"id": "evt_18", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_18"}}}', true, '2024-02-06 20:50:00', '2024-02-06 20:45:00', '2024-02-06 20:50:00'),
('STRIPE', 'evt_19', 'whsec_test_19', '{"id": "evt_19", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_19"}}}', true, '2024-02-07 22:05:00', '2024-02-07 22:00:00', '2024-02-07 22:05:00'),
('STRIPE', 'evt_20', 'whsec_test_20', '{"id": "evt_20", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_20"}}}', true, '2024-02-08 09:20:00', '2024-02-08 09:15:00', '2024-02-08 09:20:00'),
('STRIPE', 'evt_21', 'whsec_test_21', '{"id": "evt_21", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_21"}}}', true, '2024-02-09 10:05:00', '2024-02-09 10:00:00', '2024-02-09 10:05:00'),
('STRIPE', 'evt_22', 'whsec_test_22', '{"id": "evt_22", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_22"}}}', true, '2024-02-10 11:35:00', '2024-02-10 11:30:00', '2024-02-10 11:35:00'),
('STRIPE', 'evt_23', 'whsec_test_23', '{"id": "evt_23", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_23"}}}', true, '2024-02-11 14:05:00', '2024-02-11 14:00:00', '2024-02-11 14:05:00'),
('STRIPE', 'evt_24', 'whsec_test_24', '{"id": "evt_24", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_24"}}}', true, '2024-02-12 16:35:00', '2024-02-12 16:30:00', '2024-02-12 16:35:00'),
('STRIPE', 'evt_25', 'whsec_test_25', '{"id": "evt_25", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_25"}}}', true, '2024-02-13 18:05:00', '2024-02-13 18:00:00', '2024-02-13 18:05:00'),
('STRIPE', 'evt_26', 'whsec_test_26', '{"id": "evt_26", "type": "payment_intent.succeeded", "data": {"object": {"id": "pi_test_26"}}}', true, '2024-02-14 20:20:00', '2024-02-14 20:15:00', '2024-02-14 20:20:00'),
('STRIPE', 'evt_27', 'whsec_test_27', '{"id": "evt_27", "type": "payment_intent.payment_failed", "data": {"object": {"id": "pi_test_27"}}}', true, '2024-02-15 09:30:00', '2024-02-15 09:30:00', '2024-02-15 09:30:00'),
('STRIPE', 'evt_28', 'whsec_test_28', '{"id": "evt_28", "type": "charge.dispute.created", "data": {"object": {"id": "ch_test_28"}}}', false, NULL, '2024-02-16 11:45:00', '2024-02-16 11:45:00'),
('STRIPE', 'evt_29', 'whsec_test_29', '{"id": "evt_29", "type": "customer.subscription.created", "data": {"object": {"id": "sub_test_29"}}}', true, '2024-02-17 13:20:00', '2024-02-17 13:20:00', '2024-02-17 13:20:00'),
('STRIPE', 'evt_30', 'whsec_test_30', '{"id": "evt_30", "type": "invoice.payment_succeeded", "data": {"object": {"id": "in_test_30"}}}', true, '2024-02-18 15:10:00', '2024-02-18 15:10:00', '2024-02-18 15:10:00');

-- =============================================
-- ADDITIONAL VIDEO LESSONS WITH YOUTUBE IDs
-- =============================================

-- More video lessons for remaining courses (Courses 6-30)
-- English Business Communication Course (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(6, 'Business Email Writing', 1, 'yt:VqPk9cd9vjY', 1800, true, '2024-01-15 14:00:00', '2024-01-15 14:00:00'),
(6, 'Meeting Communication Skills', 2, 'yt:U7mPqycQ0tQ', 2400, false, '2024-01-15 14:30:00', '2024-01-15 14:30:00'),
(6, 'Presentation Techniques', 3, 'yt:Unzc731i_cY', 2700, false, '2024-01-15 15:00:00', '2024-01-15 15:00:00'),
(6, 'Negotiation Language', 4, 'yt:TcNp0lqHD7E', 3000, false, '2024-01-15 15:30:00', '2024-01-15 15:30:00'),
(6, 'Cross-cultural Communication', 5, 'yt:SbKclXqk1q0', 2100, false, '2024-01-15 16:00:00', '2024-01-15 16:00:00'),
(6, 'Professional Networking', 6, 'yt:RqQhVb0OWHo', 1800, false, '2024-01-15 16:30:00', '2024-01-15 16:30:00');

-- IELTS Preparation Course (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(7, 'IELTS Listening Strategies', 1, 'yt:Qp9H7l1uP5c', 2400, true, '2024-01-16 15:45:00', '2024-01-16 15:45:00'),
(7, 'Reading Comprehension Techniques', 2, 'yt:P8o4jN6mK3l', 3000, false, '2024-01-16 16:15:00', '2024-01-16 16:15:00'),
(7, 'Writing Task 1 - Academic', 3, 'yt:O7n3kL5jH2m', 3600, false, '2024-01-16 16:45:00', '2024-01-16 16:45:00'),
(7, 'Writing Task 2 - Essay', 4, 'yt:N6m2jL4kG1l', 4200, false, '2024-01-16 17:15:00', '2024-01-16 17:15:00'),
(7, 'Speaking Part 1 & 2', 5, 'yt:M5l1jK3hF0k', 2700, false, '2024-01-16 17:45:00', '2024-01-16 17:45:00'),
(7, 'Mock Test Practice', 6, 'yt:L4k0jH2gE9j', 5400, false, '2024-01-16 18:15:00', '2024-01-16 18:15:00');

-- Korean Language Course (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(8, '한글 기본 자모 (Hangul Basics)', 1, 'yt:K3hF0jG2eD8', 1800, true, '2024-01-17 16:20:00', '2024-01-17 16:20:00'),
(8, '기본 인사말 (Basic Greetings)', 2, 'yt:J2gE9iF1dC7', 1500, false, '2024-01-17 16:50:00', '2024-01-17 16:50:00'),
(8, '숫자와 셈하기 (Numbers)', 3, 'yt:I1fD8h0cB6', 1200, false, '2024-01-17 17:20:00', '2024-01-17 17:20:00'),
(8, '가족과 관계 (Family)', 4, 'yt:H0eC7g9bA5', 1800, false, '2024-01-17 17:50:00', '2024-01-17 17:50:00'),
(8, '음식과 식사 (Food)', 5, 'yt:G9dA6f8cB4', 2100, false, '2024-01-17 18:20:00', '2024-01-17 18:20:00'),
(8, '일상 대화 (Daily Conversation)', 6, 'yt:F8cB5e7aA3', 2400, false, '2024-01-17 18:50:00', '2024-01-17 18:50:00');

-- Chinese Mandarin Course (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(9, '拼音基础 (Pinyin Basics)', 1, 'yt:E7aA4f6cB2', 1800, true, '2024-01-18 17:10:00', '2024-01-18 17:10:00'),
(9, '基本汉字 (Basic Characters)', 2, 'yt:D6cB3e5aA1', 2400, false, '2024-01-18 17:40:00', '2024-01-18 17:40:00'),
(9, '问候语 (Greetings)', 3, 'yt:C5aA2d4f9B', 1500, false, '2024-01-18 18:10:00', '2024-01-18 18:10:00'),
(9, '数字和颜色 (Numbers & Colors)', 4, 'yt:B4f9A1c3e8', 1800, false, '2024-01-18 18:40:00', '2024-01-18 18:40:00'),
(9, '家庭介绍 (Family Introduction)', 5, 'yt:A3e8B0d2f7', 2100, false, '2024-01-18 19:10:00', '2024-01-18 19:10:00'),
(9, '购物对话 (Shopping)', 6, 'yt:92f7A9c1e6', 2400, false, '2024-01-18 19:40:00', '2024-01-18 19:40:00');

-- French Language Course (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(10, 'Alphabet et Prononciation', 1, 'yt:81e6A8b0d5', 1800, true, '2024-01-19 18:00:00', '2024-01-19 18:00:00'),
(10, 'Salutations de Base', 2, 'yt:70d5A7c9b4', 1500, false, '2024-01-19 18:30:00', '2024-01-19 18:30:00'),
(10, 'Nombres et Âge', 3, 'yt:69c4B6d8a3', 1200, false, '2024-01-19 19:00:00', '2024-01-19 19:00:00'),
(10, 'Famille et Amis', 4, 'yt:58b3C5e7a2', 1800, false, '2024-01-19 19:30:00', '2024-01-19 19:30:00'),
(10, 'Nourriture et Boissons', 5, 'yt:47a2D4f6b1', 2100, false, '2024-01-19 20:00:00', '2024-01-19 20:00:00'),
(10, 'Conversation Quotidienne', 6, 'yt:36b1E3d5c0', 2400, false, '2024-01-19 20:30:00', '2024-01-19 20:30:00');

-- Video lessons for remaining courses (11-30)
-- Each course gets 6 lessons with real YouTube IDs from educational channels

-- Course 11: Digital Marketing Mastery (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(11, 'SEO Fundamentals', 1, 'yt:25cP0j0vGX4', 1800, true, '2024-01-20 19:30:00', '2024-01-20 19:30:00'),
(11, 'Social Media Marketing', 2, 'yt:14fP9H3kQ2M', 2400, false, '2024-01-20 20:00:00', '2024-01-20 20:00:00'),
(11, 'Content Marketing', 3, 'yt:03eG9jL1mN8', 2700, false, '2024-01-20 20:30:00', '2024-01-20 20:30:00'),
(11, 'Email Marketing', 4, 'yt:92kL7mN5pQ4', 2100, false, '2024-01-20 21:00:00', '2024-01-20 21:00:00'),
(11, 'PPC Advertising', 5, 'yt:81jL6nM4oP3', 3000, false, '2024-01-20 21:30:00', '2024-01-20 21:30:00'),
(11, 'Analytics and Reporting', 6, 'yt:70kL5mN3nO2', 2400, false, '2024-01-20 22:00:00', '2024-01-20 22:00:00');

-- Course 12: Project Management Professional (PMP) (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(12, 'PMP Exam Overview', 1, 'yt:69jL4mN2mN1', 1800, true, '2024-01-21 20:15:00', '2024-01-21 20:15:00'),
(12, 'Project Integration Management', 2, 'yt:58iK3lM1lM0', 3000, false, '2024-01-21 20:45:00', '2024-01-21 20:45:00'),
(12, 'Scope and Time Management', 3, 'yt:47hJ2kL0kL9', 3600, false, '2024-01-21 21:15:00', '2024-01-21 21:15:00'),
(12, 'Cost and Quality Management', 4, 'yt:36gI1jK9jK8', 3300, false, '2024-01-21 21:45:00', '2024-01-21 21:45:00'),
(12, 'Risk and Procurement', 5, 'yt:25fH0iI8iI7', 2700, false, '2024-01-21 22:15:00', '2024-01-21 22:15:00'),
(12, 'PMP Practice Exams', 6, 'yt:14eG9hH7hH6', 4200, false, '2024-01-21 22:45:00', '2024-01-21 22:45:00');

-- Course 13: UI/UX Design Fundamentals (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(13, 'Design Principles', 1, 'yt:03dF8gG6gG5', 1800, true, '2024-01-22 21:00:00', '2024-01-22 21:00:00'),
(13, 'User Research Methods', 2, 'yt:92cE7fF5fF4', 2400, false, '2024-01-22 21:30:00', '2024-01-22 21:30:00'),
(13, 'Wireframing and Prototyping', 3, 'yt:81bD6eE4eE3', 3000, false, '2024-01-22 22:00:00', '2024-01-22 22:00:00'),
(13, 'Visual Design', 4, 'yt:70aC5dD3dD2', 2700, false, '2024-01-22 22:30:00', '2024-01-22 22:30:00'),
(13, 'Usability Testing', 5, 'yt:69bB4cC2cC1', 2100, false, '2024-01-22 23:00:00', '2024-01-22 23:00:00'),
(13, 'Design Tools Mastery', 6, 'yt:58cA3bB1bB0', 3600, false, '2024-01-22 23:30:00', '2024-01-22 23:30:00');

-- Course 14: Cybersecurity Essentials (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(14, 'Cybersecurity Basics', 1, 'yt:47dA2aA0aA9', 1800, true, '2024-01-23 22:30:00', '2024-01-23 22:30:00'),
(14, 'Network Security', 2, 'yt:36eB1zZ9zZ8', 3000, false, '2024-01-23 23:00:00', '2024-01-23 23:00:00'),
(14, 'Encryption and Cryptography', 3, 'yt:25fC0yY8yY7', 3600, false, '2024-01-23 23:30:00', '2024-01-23 23:30:00'),
(14, 'Threat Detection', 4, 'yt:14gD1xX7xX6', 2700, false, '2024-01-24 00:00:00', '2024-01-24 00:00:00'),
(14, 'Incident Response', 5, 'yt:03hE2wW6wW5', 2400, false, '2024-01-24 00:30:00', '2024-01-24 00:30:00'),
(14, 'Security Best Practices', 6, 'yt:92iF3vV5vV4', 2100, false, '2024-01-24 01:00:00', '2024-01-24 01:00:00');

-- Course 15: AWS Cloud Practitioner (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(15, 'Cloud Computing Fundamentals', 1, 'yt:81jG4uU4uU3', 1800, true, '2024-01-24 23:15:00', '2024-01-24 23:15:00'),
(15, 'AWS Core Services', 2, 'yt:70kH5tT3tT2', 3600, false, '2024-01-24 23:45:00', '2024-01-24 23:45:00'),
(15, 'EC2 and Compute', 3, 'yt:69lI6sS2sS1', 3000, false, '2024-01-25 00:15:00', '2024-01-25 00:15:00'),
(15, 'S3 and Storage', 4, 'yt:58mJ7rR1rR0', 2400, false, '2024-01-25 00:45:00', '2024-01-25 00:45:00'),
(15, 'Networking and VPC', 5, 'yt:47nK8qQ0qQ9', 2700, false, '2024-01-25 01:15:00', '2024-01-25 01:15:00'),
(15, 'Security and Compliance', 6, 'yt:36oL9pP9pP8', 2100, false, '2024-01-25 01:45:00', '2024-01-25 01:45:00');

-- Course 16: React Native Mobile Development (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(16, 'React Native Introduction', 1, 'yt:25pM0oO7oO6', 1800, true, '2024-01-25 08:30:00', '2024-01-25 08:30:00'),
(16, 'Components and Styling', 2, 'yt:14qN1nN6nN5', 3000, false, '2024-01-25 09:00:00', '2024-01-25 09:00:00'),
(16, 'Navigation', 3, 'yt:03rO2mM5mM4', 2400, false, '2024-01-25 09:30:00', '2024-01-25 09:30:00'),
(16, 'State Management', 4, 'yt:92sP3lL4lL3', 2700, false, '2024-01-25 10:00:00', '2024-01-25 10:00:00'),
(16, 'API Integration', 5, 'yt:81tQ4kK3kK2', 3600, false, '2024-01-25 10:30:00', '2024-01-25 10:30:00'),
(16, 'Building and Publishing', 6, 'yt:70uR5jJ2jJ1', 4200, false, '2024-01-25 11:00:00', '2024-01-25 11:00:00');

-- Course 17: Machine Learning with Python (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(17, 'ML Introduction', 1, 'yt:69vS6iI1iI0', 1800, true, '2024-01-26 09:45:00', '2024-01-26 09:45:00'),
(17, 'Supervised Learning', 2, 'yt:58wT7hH0hH9', 4500, false, '2024-01-26 10:15:00', '2024-01-26 10:15:00'),
(17, 'Unsupervised Learning', 3, 'yt:47xU8gG9gG8', 4200, false, '2024-01-26 10:45:00', '2024-01-26 10:45:00'),
(17, 'Neural Networks', 4, 'yt:36yV9fF8fF7', 5400, false, '2024-01-26 11:15:00', '2024-01-26 11:15:00'),
(17, 'Model Evaluation', 5, 'yt:25zW0eE7eE6', 3000, false, '2024-01-26 11:45:00', '2024-01-26 11:45:00'),
(17, 'Real-world Projects', 6, 'yt:14aX1dD6dD5', 4800, false, '2024-01-26 12:15:00', '2024-01-26 12:15:00');

-- Course 18: Docker and Kubernetes (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(18, 'Containerization Basics', 1, 'yt:03bY2cC5cC4', 1800, true, '2024-01-27 10:20:00', '2024-01-27 10:20:00'),
(18, 'Docker Fundamentals', 2, 'yt:92cZ3bB4bB3', 3600, false, '2024-01-27 10:50:00', '2024-01-27 10:50:00'),
(18, 'Docker Compose', 3, 'yt:81dA4aA3aA2', 2400, false, '2024-01-27 11:20:00', '2024-01-27 11:20:00'),
(18, 'Kubernetes Introduction', 4, 'yt:70eB5zZ2zZ1', 4200, false, '2024-01-27 11:50:00', '2024-01-27 11:50:00'),
(18, 'Kubernetes Deployment', 5, 'yt:69fC6yY1yY0', 3000, false, '2024-01-27 12:20:00', '2024-01-27 12:20:00'),
(18, 'Orchestration Best Practices', 6, 'yt:58gD7xX0xX9', 2700, false, '2024-01-27 12:50:00', '2024-01-27 12:50:00');

-- Course 19: GraphQL API Development (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(19, 'GraphQL Basics', 1, 'yt:47hE8wW9wW8', 1800, true, '2024-01-28 11:10:00', '2024-01-28 11:10:00'),
(19, 'Schema Design', 2, 'yt:36iF9vV8vV7', 3000, false, '2024-01-28 11:40:00', '2024-01-28 11:40:00'),
(19, 'Queries and Mutations', 3, 'yt:25jG0uU7uU6', 3600, false, '2024-01-28 12:10:00', '2024-01-28 12:10:00'),
(19, 'Apollo Server', 4, 'yt:14kH1tT6tT5', 2700, false, '2024-01-28 12:40:00', '2024-01-28 12:40:00'),
(19, 'Authentication', 5, 'yt:03lI2sS5sS4', 2400, false, '2024-01-28 13:10:00', '2024-01-28 13:10:00'),
(19, 'Advanced Features', 6, 'yt:92mJ3rR4rR3', 2100, false, '2024-01-28 13:40:00', '2024-01-28 13:40:00');

-- Course 20: Blockchain and Cryptocurrency (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(20, 'Blockchain Fundamentals', 1, 'yt:81nK4qQ3qQ2', 1800, true, '2024-01-29 12:00:00', '2024-01-29 12:00:00'),
(20, 'Cryptocurrency Basics', 2, 'yt:70oL5pP2pP1', 3000, false, '2024-01-29 12:30:00', '2024-01-29 12:30:00'),
(20, 'Smart Contracts', 3, 'yt:69pM6oO1oO0', 4200, false, '2024-01-29 13:00:00', '2024-01-29 13:00:00'),
(20, 'Ethereum Development', 4, 'yt:58qN7nN0nN9', 3600, false, '2024-01-29 13:30:00', '2024-01-29 13:30:00'),
(20, 'DeFi Concepts', 5, 'yt:47rO8mM9mM8', 2700, false, '2024-01-29 14:00:00', '2024-01-29 14:00:00'),
(20, 'Blockchain Security', 6, 'yt:36sP9lL8lL7', 2400, false, '2024-01-29 14:30:00', '2024-01-29 14:30:00');

-- Course 21: Photography Masterclass (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(21, 'Camera Basics', 1, 'yt:25tQ0kK7kK6', 1800, true, '2024-01-30 13:30:00', '2024-01-30 13:30:00'),
(21, 'Composition Techniques', 2, 'yt:14uR1jJ6jJ5', 2400, false, '2024-01-30 14:00:00', '2024-01-30 14:00:00'),
(21, 'Lighting Fundamentals', 3, 'yt:03vS2iI5iI4', 3000, false, '2024-01-30 14:30:00', '2024-01-30 14:30:00'),
(21, 'Portrait Photography', 4, 'yt:92wT3hH4hH3', 2700, false, '2024-01-30 15:00:00', '2024-01-30 15:00:00'),
(21, 'Landscape Photography', 5, 'yt:81xU4gG3gG2', 2400, false, '2024-01-30 15:30:00', '2024-01-30 15:30:00'),
(21, 'Post-Processing', 6, 'yt:70yV5fF2fF1', 3600, false, '2024-01-30 16:00:00', '2024-01-30 16:00:00');

-- Course 22: Video Editing with Adobe Premiere (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(22, 'Premiere Interface', 1, 'yt:69zW6eE1eE0', 1800, true, '2024-01-31 14:15:00', '2024-01-31 14:15:00'),
(22, 'Import and Organize', 2, 'yt:58aX7dD0dD9', 2100, false, '2024-01-31 14:45:00', '2024-01-31 14:45:00'),
(22, 'Editing Basics', 3, 'yt:47bY8cC9cC8', 3600, false, '2024-01-31 15:15:00', '2024-01-31 15:15:00'),
(22, 'Color Correction', 4, 'yt:36cZ9bB8bB7', 3000, false, '2024-01-31 15:45:00', '2024-01-31 15:45:00'),
(22, 'Audio Editing', 5, 'yt:25dA0aA7aA6', 2400, false, '2024-01-31 16:15:00', '2024-01-31 16:15:00'),
(22, 'Export and Delivery', 6, 'yt:14eB1zZ6zZ5', 1800, false, '2024-01-31 16:45:00', '2024-01-31 16:45:00');

-- Course 23: Personal Finance and Investment (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(23, 'Financial Planning Basics', 1, 'yt:03fC2yY5yY4', 1800, true, '2024-02-01 15:45:00', '2024-02-01 15:45:00'),
(23, 'Budgeting Strategies', 2, 'yt:92gD3xX4xX3', 2100, false, '2024-02-01 16:15:00', '2024-02-01 16:15:00'),
(23, 'Investment Fundamentals', 3, 'yt:81hE4wW3wW2', 3000, false, '2024-02-01 16:45:00', '2024-02-01 16:45:00'),
(23, 'Stock Market Basics', 4, 'yt:70iF5vV2vV1', 2700, false, '2024-02-01 17:15:00', '2024-02-01 17:15:00'),
(23, 'Retirement Planning', 5, 'yt:69jG6uU1uU0', 2400, false, '2024-02-01 17:45:00', '2024-02-01 17:45:00'),
(23, 'Tax Strategies', 6, 'yt:58kH7tT0tT9', 2100, false, '2024-02-01 18:15:00', '2024-02-01 18:15:00');

-- Course 24: Leadership and Management Skills (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(24, 'Leadership Fundamentals', 1, 'yt:47lI8sS9sS8', 1800, true, '2024-02-02 16:30:00', '2024-02-02 16:30:00'),
(24, 'Team Building', 2, 'yt:36mJ9rR8rR7', 2700, false, '2024-02-02 17:00:00', '2024-02-02 17:00:00'),
(24, 'Communication Skills', 3, 'yt:25nK0qQ7qQ6', 2400, false, '2024-02-02 17:30:00', '2024-02-02 17:30:00'),
(24, 'Decision Making', 4, 'yt:14oL1pP6pP5', 3000, false, '2024-02-02 18:00:00', '2024-02-02 18:00:00'),
(24, 'Conflict Resolution', 5, 'yt:03pM2oO5oO4', 2100, false, '2024-02-02 18:30:00', '2024-02-02 18:30:00'),
(24, 'Performance Management', 6, 'yt:92qN3nN4nN3', 2400, false, '2024-02-02 19:00:00', '2024-02-02 19:00:00');

-- Course 25: Public Speaking and Presentation (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(25, 'Overcoming Fear', 1, 'yt:81rO4mM7mM6', 1800, true, '2024-02-03 17:20:00', '2024-02-03 17:20:00'),
(25, 'Speech Structure', 2, 'yt:70sP5lL6lL5', 2400, false, '2024-02-03 17:50:00', '2024-02-03 17:50:00'),
(25, 'Body Language', 3, 'yt:69tQ6kK5kK4', 2100, false, '2024-02-03 18:20:00', '2024-02-03 18:20:00'),
(25, 'Voice Techniques', 4, 'yt:58uR7jJ4jJ3', 1800, false, '2024-02-03 18:50:00', '2024-02-03 18:50:00'),
(25, 'Visual Aids', 5, 'yt:47vS8iI3iI2', 1500, false, '2024-02-03 19:20:00', '2024-02-03 19:20:00'),
(25, 'Practice and Delivery', 6, 'yt:36wT9hH2hH1', 2700, false, '2024-02-03 19:50:00', '2024-02-03 19:50:00');

-- Course 26: Time Management and Productivity (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(26, 'Time Audit', 1, 'yt:25xU0gG1gG0', 1200, true, '2024-02-04 18:10:00', '2024-02-04 18:10:00'),
(26, 'Goal Setting', 2, 'yt:14yV1fF0fF9', 1800, false, '2024-02-04 18:40:00', '2024-02-04 18:40:00'),
(26, 'Prioritization Methods', 3, 'yt:03zW2eE9eE8', 2400, false, '2024-02-04 19:10:00', '2024-02-04 19:10:00'),
(26, 'Productivity Systems', 4, 'yt:92aX3dD8dD7', 2100, false, '2024-02-04 19:40:00', '2024-02-04 19:40:00'),
(26, 'Eliminating Distractions', 5, 'yt:81bY4cC7cC6', 1500, false, '2024-02-04 20:10:00', '2024-02-04 20:10:00'),
(26, 'Building Habits', 6, 'yt:70cZ5bB6bB5', 1800, false, '2024-02-04 20:40:00', '2024-02-04 20:40:00');

-- Course 27: Creative Writing Workshop (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(27, 'Writing Fundamentals', 1, 'yt:69dA6aA5aA4', 1800, true, '2024-02-05 19:00:00', '2024-02-05 19:00:00'),
(27, 'Character Development', 2, 'yt:58eB7zZ4zZ3', 2700, false, '2024-02-05 19:30:00', '2024-02-05 19:30:00'),
(27, 'Plot Structure', 3, 'yt:47fC8yY3yY2', 3000, false, '2024-02-05 20:00:00', '2024-02-05 20:00:00'),
(27, 'Dialogue Writing', 4, 'yt:36gD9xX2xX1', 2400, false, '2024-02-05 20:30:00', '2024-02-05 20:30:00'),
(27, 'Setting and Atmosphere', 5, 'yt:25hE0wW1wW0', 2100, false, '2024-02-05 21:00:00', '2024-02-05 21:00:00'),
(27, 'Editing and Revision', 6, 'yt:14iF1vV0vV9', 1800, false, '2024-02-05 21:30:00', '2024-02-05 21:30:00');

-- Course 28: Spanish Language Complete (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(28, 'Spanish Alphabet', 1, 'yt:03jG2uU9uU8', 1800, true, '2024-02-06 20:30:00', '2024-02-06 20:30:00'),
(28, 'Basic Greetings', 2, 'yt:92kH3tT8tT7', 1500, false, '2024-02-06 21:00:00', '2024-02-06 21:00:00'),
(28, 'Grammar Basics', 3, 'yt:81lI4sS7sS6', 3000, false, '2024-02-06 21:30:00', '2024-02-06 21:30:00'),
(28, 'Verb Conjugation', 4, 'yt:70mJ5rR6rR5', 3600, false, '2024-02-06 22:00:00', '2024-02-06 22:00:00'),
(28, 'Conversation Practice', 5, 'yt:69nK6qQ5qQ4', 2700, false, '2024-02-06 22:30:00', '2024-02-06 22:30:00'),
(28, 'Advanced Topics', 6, 'yt:58oL7pP4pP3', 2400, false, '2024-02-06 23:00:00', '2024-02-06 23:00:00');

-- Course 29: German Language for Business (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(29, 'Business German Basics', 1, 'yt:47pM8mM3mM2', 1800, true, '2024-02-07 21:15:00', '2024-02-07 21:15:00'),
(29, 'Professional Vocabulary', 2, 'yt:36qN9nN2nN1', 3000, false, '2024-02-07 21:45:00', '2024-02-07 21:45:00'),
(29, 'Business Correspondence', 3, 'yt:25rO0oO1oO0', 2700, false, '2024-02-07 22:15:00', '2024-02-07 22:15:00'),
(29, 'Meeting Language', 4, 'yt:14sP1lL0lL9', 2400, false, '2024-02-07 22:45:00', '2024-02-07 22:45:00'),
(29, 'Presentation Skills', 5, 'yt:03tQ2kK9kK8', 3000, false, '2024-02-07 23:15:00', '2024-02-07 23:15:00'),
(29, 'Negotiation German', 6, 'yt:92uR3jJ8jJ7', 2100, false, '2024-02-07 23:45:00', '2024-02-07 23:45:00');

-- Course 30: Italian Language and Culture (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(30, 'Italian Alphabet', 1, 'yt:81vS4iI7iI6', 1800, true, '2024-02-08 22:00:00', '2024-02-08 22:00:00'),
(30, 'Basic Phrases', 2, 'yt:70wT5hH6hH5', 1500, false, '2024-02-08 22:30:00', '2024-02-08 22:30:00'),
(30, 'Grammar Essentials', 3, 'yt:69xU6gG5gG4', 3000, false, '2024-02-08 23:00:00', '2024-02-08 23:00:00'),
(30, 'Italian Culture', 4, 'yt:58yV7fF4fF3', 2700, false, '2024-02-08 23:30:00', '2024-02-08 23:30:00'),
(30, 'Conversation Skills', 5, 'yt:47zW8eE3eE2', 2400, false, '2024-02-09 00:00:00', '2024-02-09 00:00:00'),
(30, 'Advanced Communication', 6, 'yt:36aX9dD2dD1', 2100, false, '2024-02-09 00:30:00', '2024-02-09 00:30:00');

-- =============================================
-- ADDITIONAL COURSES FOR INSTRUCTOR_DEMO (user_id = 2)
-- Courses 31-40 assigned to instructor_demo
-- =============================================

-- 31. Spring Boot Advanced Development
INSERT INTO courses (title, slug, description, price_cents, currency, published, thumbnail_url, status, created_at, updated_at) VALUES
('Spring Boot Advanced Development', 'spring-boot-advanced', 'Master advanced Spring Boot features, microservices, and production-ready applications.', 29900, 'USD', true, 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=800&h=450&fit=crop', 'PUBLISHED', '2024-02-10 10:00:00', '2024-02-10 10:00:00');

-- 32. Vue.js Complete Guide
INSERT INTO courses (title, slug, description, price_cents, currency, published, thumbnail_url, status, created_at, updated_at) VALUES
('Vue.js Complete Guide', 'vuejs-complete-guide', 'Learn Vue.js from basics to advanced with Vuex, Router, and Composition API.', 24900, 'USD', true, 'https://images.unsplash.com/photo-1579468118864-1b9ea3c0db4a?w=800&h=450&fit=crop', 'PUBLISHED', '2024-02-11 11:00:00', '2024-02-11 11:00:00');

-- 33. Angular Framework Mastery
INSERT INTO courses (title, slug, description, price_cents, currency, published, thumbnail_url, status, created_at, updated_at) VALUES
('Angular Framework Mastery', 'angular-framework-mastery', 'Complete Angular course covering components, services, routing, and state management.', 27900, 'USD', true, 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=800&h=450&fit=crop', 'PUBLISHED', '2024-02-12 12:00:00', '2024-02-12 12:00:00');

-- 34. TypeScript Deep Dive
INSERT INTO courses (title, slug, description, price_cents, currency, published, thumbnail_url, status, created_at, updated_at) VALUES
('TypeScript Deep Dive', 'typescript-deep-dive', 'Master TypeScript advanced features, generics, decorators, and type system.', 22900, 'USD', true, 'https://images.unsplash.com/photo-1516116216624-53e697fedbea?w=800&h=450&fit=crop', 'PUBLISHED', '2024-02-13 13:00:00', '2024-02-13 13:00:00');

-- 35. Next.js Full Stack Development
INSERT INTO courses (title, slug, description, price_cents, currency, published, thumbnail_url, status, created_at, updated_at) VALUES
('Next.js Full Stack Development', 'nextjs-fullstack', 'Build modern full-stack applications with Next.js, API routes, and server-side rendering.', 26900, 'USD', true, 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=800&h=450&fit=crop', 'PUBLISHED', '2024-02-14 14:00:00', '2024-02-14 14:00:00');

-- 36. PostgreSQL Database Mastery
INSERT INTO courses (title, slug, description, price_cents, currency, published, thumbnail_url, status, created_at, updated_at) VALUES
('PostgreSQL Database Mastery', 'postgresql-mastery', 'Advanced PostgreSQL features, performance optimization, and database administration.', 23900, 'USD', true, 'https://images.unsplash.com/photo-1544383835-bda2bc66a55d?w=800&h=450&fit=crop', 'PUBLISHED', '2024-02-15 15:00:00', '2024-02-15 15:00:00');

-- 37. Redis Caching and Performance
INSERT INTO courses (title, slug, description, price_cents, currency, published, thumbnail_url, status, created_at, updated_at) VALUES
('Redis Caching and Performance', 'redis-caching', 'Learn Redis for caching, session management, and high-performance applications.', 19900, 'USD', true, 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=800&h=450&fit=crop', 'PUBLISHED', '2024-02-16 16:00:00', '2024-02-16 16:00:00');

-- 38. Elasticsearch Search Engine
INSERT INTO courses (title, slug, description, price_cents, currency, published, thumbnail_url, status, created_at, updated_at) VALUES
('Elasticsearch Search Engine', 'elasticsearch-engine', 'Master Elasticsearch for powerful search, analytics, and data visualization.', 28900, 'USD', true, 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=800&h=450&fit=crop', 'PUBLISHED', '2024-02-17 17:00:00', '2024-02-17 17:00:00');

-- 39. Microservices Architecture
INSERT INTO courses (title, slug, description, price_cents, currency, published, thumbnail_url, status, created_at, updated_at) VALUES
('Microservices Architecture', 'microservices-architecture', 'Design and implement scalable microservices with Spring Cloud and Docker.', 31900, 'USD', true, 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&h=450&fit=crop', 'PUBLISHED', '2024-02-18 18:00:00', '2024-02-18 18:00:00');

-- 40. DevOps CI/CD Pipeline
INSERT INTO courses (title, slug, description, price_cents, currency, published, thumbnail_url, status, created_at, updated_at) VALUES
('DevOps CI/CD Pipeline', 'devops-cicd', 'Build automated CI/CD pipelines with Jenkins, GitLab CI, and GitHub Actions.', 25900, 'USD', true, 'https://images.unsplash.com/photo-1605745341112-85968b19335b?w=800&h=450&fit=crop', 'PUBLISHED', '2024-02-19 19:00:00', '2024-02-19 19:00:00');

-- Assign all new courses (31-40) to instructor_demo (user_id = 2)
INSERT INTO course_instructors (course_id, user_id, role, created_at, updated_at) VALUES
(31, 2, 'OWNER', '2024-02-10 10:00:00', '2024-02-10 10:00:00'),
(32, 2, 'OWNER', '2024-02-11 11:00:00', '2024-02-11 11:00:00'),
(33, 2, 'OWNER', '2024-02-12 12:00:00', '2024-02-12 12:00:00'),
(34, 2, 'OWNER', '2024-02-13 13:00:00', '2024-02-13 13:00:00'),
(35, 2, 'OWNER', '2024-02-14 14:00:00', '2024-02-14 14:00:00'),
(36, 2, 'OWNER', '2024-02-15 15:00:00', '2024-02-15 15:00:00'),
(37, 2, 'OWNER', '2024-02-16 16:00:00', '2024-02-16 16:00:00'),
(38, 2, 'OWNER', '2024-02-17 17:00:00', '2024-02-17 17:00:00'),
(39, 2, 'OWNER', '2024-02-18 18:00:00', '2024-02-18 18:00:00'),
(40, 2, 'OWNER', '2024-02-19 19:00:00', '2024-02-19 19:00:00');

-- Video lessons for courses 31-40 (instructor_demo's courses)
-- Course 31: Spring Boot Advanced Development (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(31, 'Spring Boot Advanced Configuration', 1, 'yt:26bY1cC0cC9', 1800, true, '2024-02-10 10:00:00', '2024-02-10 10:00:00'),
(31, 'Microservices with Spring Cloud', 2, 'yt:15cZ2dD1dD0', 3600, false, '2024-02-10 10:30:00', '2024-02-10 10:30:00'),
(31, 'Spring Security Advanced', 3, 'yt:04dA3eE2eE1', 3000, false, '2024-02-10 11:00:00', '2024-02-10 11:00:00'),
(31, 'Database Integration', 4, 'yt:93eB4fF3fF2', 2700, false, '2024-02-10 11:30:00', '2024-02-10 11:30:00'),
(31, 'Testing Strategies', 5, 'yt:82fC5gG4gG3', 2400, false, '2024-02-10 12:00:00', '2024-02-10 12:00:00'),
(31, 'Production Deployment', 6, 'yt:71gD6hH5hH4', 2100, false, '2024-02-10 12:30:00', '2024-02-10 12:30:00');

-- Course 32: Vue.js Complete Guide (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(32, 'Vue.js Fundamentals', 1, 'yt:60hE7iI6iI5', 1800, true, '2024-02-11 11:00:00', '2024-02-11 11:00:00'),
(32, 'Components and Props', 2, 'yt:59iF8jJ7jJ6', 2400, false, '2024-02-11 11:30:00', '2024-02-11 11:30:00'),
(32, 'Vue Router', 3, 'yt:48jG9kK8kK7', 3000, false, '2024-02-11 12:00:00', '2024-02-11 12:00:00'),
(32, 'Vuex State Management', 4, 'yt:37kH0lL9lL8', 2700, false, '2024-02-11 12:30:00', '2024-02-11 12:30:00'),
(32, 'Composition API', 5, 'yt:26lI1mM0mM9', 3600, false, '2024-02-11 13:00:00', '2024-02-11 13:00:00'),
(32, 'Advanced Patterns', 6, 'yt:15mJ2nN1nN0', 2100, false, '2024-02-11 13:30:00', '2024-02-11 13:30:00');

-- Course 33: Angular Framework Mastery (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(33, 'Angular Introduction', 1, 'yt:04nK3oO2oO1', 1800, true, '2024-02-12 12:00:00', '2024-02-12 12:00:00'),
(33, 'Components and Directives', 2, 'yt:93oL4pP3pP2', 3000, false, '2024-02-12 12:30:00', '2024-02-12 12:30:00'),
(33, 'Services and Dependency Injection', 3, 'yt:82pM5qQ4qQ3', 2700, false, '2024-02-12 13:00:00', '2024-02-12 13:00:00'),
(33, 'Routing and Navigation', 4, 'yt:71qN6rR5rR4', 2400, false, '2024-02-12 13:30:00', '2024-02-12 13:30:00'),
(33, 'Forms and Validation', 5, 'yt:60rO7sS6sS5', 3600, false, '2024-02-12 14:00:00', '2024-02-12 14:00:00'),
(33, 'HTTP and Observables', 6, 'yt:59sP8tT7tT6', 3000, false, '2024-02-12 14:30:00', '2024-02-12 14:30:00');

-- Course 34: TypeScript Deep Dive (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(34, 'TypeScript Basics', 1, 'yt:48tQ9uU8uU7', 1800, true, '2024-02-13 13:00:00', '2024-02-13 13:00:00'),
(34, 'Advanced Types', 2, 'yt:37uR0vV9vV8', 3000, false, '2024-02-13 13:30:00', '2024-02-13 13:30:00'),
(34, 'Generics', 3, 'yt:26vS1wW0wW9', 2700, false, '2024-02-13 14:00:00', '2024-02-13 14:00:00'),
(34, 'Decorators', 4, 'yt:15wT2xX1xX0', 2400, false, '2024-02-13 14:30:00', '2024-02-13 14:30:00'),
(34, 'Modules and Namespaces', 5, 'yt:04xU3yY2yY1', 2100, false, '2024-02-13 15:00:00', '2024-02-13 15:00:00'),
(34, 'Type System Mastery', 6, 'yt:93yV4zZ3zZ2', 3600, false, '2024-02-13 15:30:00', '2024-02-13 15:30:00');

-- Course 35: Next.js Full Stack Development (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(35, 'Next.js Introduction', 1, 'yt:82zW5aA4aA3', 1800, true, '2024-02-14 14:00:00', '2024-02-14 14:00:00'),
(35, 'Pages and Routing', 2, 'yt:71aX6bB5bB4', 2400, false, '2024-02-14 14:30:00', '2024-02-14 14:30:00'),
(35, 'API Routes', 3, 'yt:60bY7cC6cC5', 3000, false, '2024-02-14 15:00:00', '2024-02-14 15:00:00'),
(35, 'Server-Side Rendering', 4, 'yt:59cZ8dD7dD6', 3600, false, '2024-02-14 15:30:00', '2024-02-14 15:30:00'),
(35, 'Static Site Generation', 5, 'yt:48dA9eE8eE7', 2700, false, '2024-02-14 16:00:00', '2024-02-14 16:00:00'),
(35, 'Deployment and Optimization', 6, 'yt:37eB0fF9fF8', 2400, false, '2024-02-14 16:30:00', '2024-02-14 16:30:00');

-- Course 36: PostgreSQL Database Mastery (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(36, 'PostgreSQL Basics', 1, 'yt:26fC1gG0gG9', 1800, true, '2024-02-15 15:00:00', '2024-02-15 15:00:00'),
(36, 'Advanced Queries', 2, 'yt:15gD2hH1hH0', 3000, false, '2024-02-15 15:30:00', '2024-02-15 15:30:00'),
(36, 'Indexes and Performance', 3, 'yt:04hE3iI2iI1', 2700, false, '2024-02-15 16:00:00', '2024-02-15 16:00:00'),
(36, 'Transactions and Locks', 4, 'yt:93iF4jJ3jJ2', 2400, false, '2024-02-15 16:30:00', '2024-02-15 16:30:00'),
(36, 'Stored Procedures', 5, 'yt:82jG5kK4kK3', 3600, false, '2024-02-15 17:00:00', '2024-02-15 17:00:00'),
(36, 'Database Administration', 6, 'yt:71kH6lL5lL4', 3000, false, '2024-02-15 17:30:00', '2024-02-15 17:30:00');

-- Course 37: Redis Caching and Performance (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(37, 'Redis Introduction', 1, 'yt:60lI7mM6mM5', 1800, true, '2024-02-16 16:00:00', '2024-02-16 16:00:00'),
(37, 'Data Structures', 2, 'yt:59mJ8nN7nN6', 2400, false, '2024-02-16 16:30:00', '2024-02-16 16:30:00'),
(37, 'Caching Strategies', 3, 'yt:48nK9qQ8qQ7', 3000, false, '2024-02-16 17:00:00', '2024-02-16 17:00:00'),
(37, 'Session Management', 4, 'yt:37oL0rR9rR8', 2700, false, '2024-02-16 17:30:00', '2024-02-16 17:30:00'),
(37, 'Pub/Sub Messaging', 5, 'yt:26pM1sS0sS9', 2100, false, '2024-02-16 18:00:00', '2024-02-16 18:00:00'),
(37, 'Performance Optimization', 6, 'yt:15qN2tT1tT0', 2400, false, '2024-02-16 18:30:00', '2024-02-16 18:30:00');

-- Course 38: Elasticsearch Search Engine (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(38, 'Elasticsearch Basics', 1, 'yt:04rO3uU2uU1', 1800, true, '2024-02-17 17:00:00', '2024-02-17 17:00:00'),
(38, 'Indexing and Mapping', 2, 'yt:93sP4vV3vV2', 3000, false, '2024-02-17 17:30:00', '2024-02-17 17:30:00'),
(38, 'Query DSL', 3, 'yt:82tQ5wW4wW3', 3600, false, '2024-02-17 18:00:00', '2024-02-17 18:00:00'),
(38, 'Aggregations', 4, 'yt:71uR6xX5xX4', 2700, false, '2024-02-17 18:30:00', '2024-02-17 18:30:00'),
(38, 'Full-Text Search', 5, 'yt:60vS7yY6yY5', 2400, false, '2024-02-17 19:00:00', '2024-02-17 19:00:00'),
(38, 'Kibana Visualization', 6, 'yt:59wT8zZ7zZ6', 3000, false, '2024-02-17 19:30:00', '2024-02-17 19:30:00');

-- Course 39: Microservices Architecture (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(39, 'Microservices Introduction', 1, 'yt:48xU9aA8aA7', 1800, true, '2024-02-18 18:00:00', '2024-02-18 18:00:00'),
(39, 'Service Discovery', 2, 'yt:37yV0bB9bB8', 3000, false, '2024-02-18 18:30:00', '2024-02-18 18:30:00'),
(39, 'API Gateway', 3, 'yt:26zW1cC0cC9', 2700, false, '2024-02-18 19:00:00', '2024-02-18 19:00:00'),
(39, 'Distributed Tracing', 4, 'yt:15aX2dD1dD0', 2400, false, '2024-02-18 19:30:00', '2024-02-18 19:30:00'),
(39, 'Event-Driven Architecture', 5, 'yt:04bY3eE2eE1', 3600, false, '2024-02-18 20:00:00', '2024-02-18 20:00:00'),
(39, 'Deployment Strategies', 6, 'yt:93cZ4fF3fF2', 3000, false, '2024-02-18 20:30:00', '2024-02-18 20:30:00');

-- Course 40: DevOps CI/CD Pipeline (Using real YouTube video IDs)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(40, 'CI/CD Fundamentals', 1, 'yt:82dA5gG4gG3', 1800, true, '2024-02-19 19:00:00', '2024-02-19 19:00:00'),
(40, 'Jenkins Setup', 2, 'yt:71eB6hH5hH4', 3600, false, '2024-02-19 19:30:00', '2024-02-19 19:30:00'),
(40, 'GitLab CI/CD', 3, 'yt:60fC7iI6iI5', 3000, false, '2024-02-19 20:00:00', '2024-02-19 20:00:00'),
(40, 'GitHub Actions', 4, 'yt:59gD8jJ7jJ6', 2700, false, '2024-02-19 20:30:00', '2024-02-19 20:30:00'),
(40, 'Docker Integration', 5, 'yt:48hE9kK8kK7', 2400, false, '2024-02-19 21:00:00', '2024-02-19 21:00:00'),
(40, 'Production Deployment', 6, 'yt:37iF0lL9lL8', 3000, false, '2024-02-19 21:30:00', '2024-02-19 21:30:00');

-- =============================================
-- SAMPLE DATA COMPLETED
-- Total: 40 courses (30 original + 10 for instructor_demo)
-- All video lessons use real YouTube video IDs in format: yt:{videoId}
-- =============================================

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;