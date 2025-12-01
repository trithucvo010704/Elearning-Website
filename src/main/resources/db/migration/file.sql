-- =============================================
-- SAMPLE DATA FOR E-LEARNING API
-- 30 records for each entity with realistic data
-- =============================================

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
INSERT INTO courses (title, slug, description, price_cents, currency, published, thumbnail_url, status, created_at, updated_at) VALUES
('Complete Java Programming Masterclass', 'complete-java-programming-masterclass', 'Learn Java programming from beginner to advanced level with hands-on projects and real-world applications.', 29900, 'USD', true, 'https://example.com/thumbnails/java-course.jpg', 'PUBLISHED', '2024-01-10 08:00:00', '2024-01-10 08:00:00'),
('Python for Data Science and Machine Learning', 'python-data-science-machine-learning', 'Master Python for data analysis, visualization, and machine learning with practical projects.', 39900, 'USD', true, 'https://example.com/thumbnails/python-ds.jpg', 'PUBLISHED', '2024-01-11 09:30:00', '2024-01-11 09:30:00'),
('JavaScript Full Stack Development', 'javascript-full-stack-development', 'Build complete web applications using JavaScript, Node.js, React, and MongoDB.', 34900, 'USD', true, 'https://example.com/thumbnails/js-fullstack.jpg', 'PUBLISHED', '2024-01-12 10:15:00', '2024-01-12 10:15:00'),
('Japanese Language for Beginners', 'japanese-language-beginners', 'Learn Japanese from scratch with hiragana, katakana, and basic conversation skills.', 19900, 'USD', true, 'https://example.com/thumbnails/japanese-basic.jpg', 'PUBLISHED', '2024-01-13 11:00:00', '2024-01-13 11:00:00'),
('Advanced Japanese Conversation', 'advanced-japanese-conversation', 'Improve your Japanese speaking skills with advanced grammar and cultural context.', 24900, 'USD', true, 'https://example.com/thumbnails/japanese-advanced.jpg', 'PUBLISHED', '2024-01-14 12:30:00', '2024-01-14 12:30:00'),
('English Business Communication', 'english-business-communication', 'Master professional English for business meetings, presentations, and written communication.', 22900, 'USD', true, 'https://example.com/thumbnails/english-business.jpg', 'PUBLISHED', '2024-01-15 14:00:00', '2024-01-15 14:00:00'),
('IELTS Preparation Course', 'ielts-preparation-course', 'Comprehensive IELTS preparation covering all four skills: listening, reading, writing, and speaking.', 27900, 'USD', true, 'https://example.com/thumbnails/ielts-prep.jpg', 'PUBLISHED', '2024-01-16 15:45:00', '2024-01-16 15:45:00'),
('Korean Language Complete Course', 'korean-language-complete-course', 'Learn Korean alphabet, grammar, and conversation from beginner to intermediate level.', 21900, 'USD', true, 'https://example.com/thumbnails/korean-complete.jpg', 'PUBLISHED', '2024-01-17 16:20:00', '2024-01-17 16:20:00'),
('Chinese Mandarin for Beginners', 'chinese-mandarin-beginners', 'Start learning Chinese with pinyin, basic characters, and essential vocabulary.', 18900, 'USD', true, 'https://example.com/thumbnails/chinese-basic.jpg', 'PUBLISHED', '2024-01-18 17:10:00', '2024-01-18 17:10:00'),
('French Language Immersion', 'french-language-immersion', 'Learn French through immersive conversation practice and cultural context.', 25900, 'USD', true, 'https://example.com/thumbnails/french-immersion.jpg', 'PUBLISHED', '2024-01-19 18:00:00', '2024-01-19 18:00:00'),
('Digital Marketing Mastery', 'digital-marketing-mastery', 'Complete guide to digital marketing including SEO, social media, and paid advertising.', 32900, 'USD', true, 'https://example.com/thumbnails/digital-marketing.jpg', 'PUBLISHED', '2024-01-20 19:30:00', '2024-01-20 19:30:00'),
('Project Management Professional (PMP)', 'project-management-professional-pmp', 'Prepare for PMP certification with comprehensive project management training.', 44900, 'USD', true, 'https://example.com/thumbnails/pmp-certification.jpg', 'PUBLISHED', '2024-01-21 20:15:00', '2024-01-21 20:15:00'),
('UI/UX Design Fundamentals', 'ui-ux-design-fundamentals', 'Learn user interface and user experience design principles with practical projects.', 29900, 'USD', true, 'https://example.com/thumbnails/ui-ux-design.jpg', 'PUBLISHED', '2024-01-22 21:00:00', '2024-01-22 21:00:00'),
('Cybersecurity Essentials', 'cybersecurity-essentials', 'Introduction to cybersecurity concepts, threats, and protection strategies.', 37900, 'USD', true, 'https://example.com/thumbnails/cybersecurity.jpg', 'PUBLISHED', '2024-01-23 22:30:00', '2024-01-23 22:30:00'),
('AWS Cloud Practitioner', 'aws-cloud-practitioner', 'Learn Amazon Web Services fundamentals and cloud computing concepts.', 39900, 'USD', true, 'https://example.com/thumbnails/aws-cloud.jpg', 'PUBLISHED', '2024-01-24 23:15:00', '2024-01-24 23:15:00'),
('React Native Mobile Development', 'react-native-mobile-development', 'Build cross-platform mobile apps using React Native framework.', 34900, 'USD', true, 'https://example.com/thumbnails/react-native.jpg', 'PUBLISHED', '2024-01-25 08:30:00', '2024-01-25 08:30:00'),
('Machine Learning with Python', 'machine-learning-python', 'Implement machine learning algorithms and build predictive models.', 49900, 'USD', true, 'https://example.com/thumbnails/ml-python.jpg', 'PUBLISHED', '2024-01-26 09:45:00', '2024-01-26 09:45:00'),
('Docker and Kubernetes', 'docker-kubernetes', 'Containerization and orchestration with Docker and Kubernetes.', 32900, 'USD', true, 'https://example.com/thumbnails/docker-k8s.jpg', 'PUBLISHED', '2024-01-27 10:20:00', '2024-01-27 10:20:00'),
('GraphQL API Development', 'graphql-api-development', 'Build modern APIs using GraphQL with Node.js and Apollo Server.', 27900, 'USD', true, 'https://example.com/thumbnails/graphql-api.jpg', 'PUBLISHED', '2024-01-28 11:10:00', '2024-01-28 11:10:00'),
('Blockchain and Cryptocurrency', 'blockchain-cryptocurrency', 'Understanding blockchain technology and cryptocurrency fundamentals.', 35900, 'USD', true, 'https://example.com/thumbnails/blockchain.jpg', 'PUBLISHED', '2024-01-29 12:00:00', '2024-01-29 12:00:00'),
('Photography Masterclass', 'photography-masterclass', 'Professional photography techniques, composition, and post-processing.', 19900, 'USD', true, 'https://example.com/thumbnails/photography.jpg', 'PUBLISHED', '2024-01-30 13:30:00', '2024-01-30 13:30:00'),
('Video Editing with Adobe Premiere', 'video-editing-adobe-premiere', 'Master video editing using Adobe Premiere Pro with professional techniques.', 22900, 'USD', true, 'https://example.com/thumbnails/video-editing.jpg', 'PUBLISHED', '2024-01-31 14:15:00', '2024-01-31 14:15:00'),
('Personal Finance and Investment', 'personal-finance-investment', 'Learn personal finance management and investment strategies.', 15900, 'USD', true, 'https://example.com/thumbnails/personal-finance.jpg', 'PUBLISHED', '2024-02-01 15:45:00', '2024-02-01 15:45:00'),
('Leadership and Management Skills', 'leadership-management-skills', 'Develop leadership qualities and effective management techniques.', 24900, 'USD', true, 'https://example.com/thumbnails/leadership.jpg', 'PUBLISHED', '2024-02-02 16:30:00', '2024-02-02 16:30:00'),
('Public Speaking and Presentation', 'public-speaking-presentation', 'Overcome fear of public speaking and deliver compelling presentations.', 17900, 'USD', true, 'https://example.com/thumbnails/public-speaking.jpg', 'PUBLISHED', '2024-02-03 17:20:00', '2024-02-03 17:20:00'),
('Time Management and Productivity', 'time-management-productivity', 'Master time management techniques and boost your productivity.', 12900, 'USD', true, 'https://example.com/thumbnails/time-management.jpg', 'PUBLISHED', '2024-02-04 18:10:00', '2024-02-04 18:10:00'),
('Creative Writing Workshop', 'creative-writing-workshop', 'Develop creative writing skills through exercises and feedback.', 19900, 'USD', true, 'https://example.com/thumbnails/creative-writing.jpg', 'PUBLISHED', '2024-02-05 19:00:00', '2024-02-05 19:00:00'),
('Spanish Language Complete', 'spanish-language-complete', 'Learn Spanish from beginner to advanced with cultural insights.', 23900, 'USD', true, 'https://example.com/thumbnails/spanish-complete.jpg', 'PUBLISHED', '2024-02-06 20:30:00', '2024-02-06 20:30:00'),
('German Language for Business', 'german-language-business', 'Professional German for business communication and workplace scenarios.', 26900, 'USD', true, 'https://example.com/thumbnails/german-business.jpg', 'PUBLISHED', '2024-02-07 21:15:00', '2024-02-07 21:15:00'),
('Italian Language and Culture', 'italian-language-culture', 'Learn Italian language while exploring Italian culture and traditions.', 21900, 'USD', true, 'https://example.com/thumbnails/italian-culture.jpg', 'PUBLISHED', '2024-02-08 22:00:00', '2024-02-08 22:00:00'),
('Portuguese for Travelers', 'portuguese-travelers', 'Essential Portuguese phrases and vocabulary for travelers.', 14900, 'USD', true, 'https://example.com/thumbnails/portuguese-travel.jpg', 'PUBLISHED', '2024-02-09 23:45:00', '2024-02-09 23:45:00');

-- 3. VIDEO LESSONS (30 records per course - showing first 5 courses with 6 lessons each)
-- Java Programming Course Lessons
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(1, 'Introduction to Java Programming', 1, 'courses/java/lesson-01-intro.mp4', 1800, true, '2024-01-10 08:00:00', '2024-01-10 08:00:00'),
(1, 'Java Variables and Data Types', 2, 'courses/java/lesson-02-variables.mp4', 2400, false, '2024-01-10 08:30:00', '2024-01-10 08:30:00'),
(1, 'Control Structures in Java', 3, 'courses/java/lesson-03-control.mp4', 2700, false, '2024-01-10 09:00:00', '2024-01-10 09:00:00'),
(1, 'Object-Oriented Programming Basics', 4, 'courses/java/lesson-04-oop.mp4', 3600, false, '2024-01-10 09:30:00', '2024-01-10 09:30:00'),
(1, 'Java Collections Framework', 5, 'courses/java/lesson-05-collections.mp4', 4200, false, '2024-01-10 10:00:00', '2024-01-10 10:00:00'),
(1, 'Exception Handling in Java', 6, 'courses/java/lesson-06-exceptions.mp4', 2100, false, '2024-01-10 10:30:00', '2024-01-10 10:30:00');

-- Python Data Science Course Lessons
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(2, 'Python Basics for Data Science', 1, 'courses/python/lesson-01-basics.mp4', 2100, true, '2024-01-11 09:30:00', '2024-01-11 09:30:00'),
(2, 'NumPy Arrays and Operations', 2, 'courses/python/lesson-02-numpy.mp4', 3000, false, '2024-01-11 10:00:00', '2024-01-11 10:00:00'),
(2, 'Pandas Data Manipulation', 3, 'courses/python/lesson-03-pandas.mp4', 3600, false, '2024-01-11 10:30:00', '2024-01-11 10:30:00'),
(2, 'Data Visualization with Matplotlib', 4, 'courses/python/lesson-04-matplotlib.mp4', 2700, false, '2024-01-11 11:00:00', '2024-01-11 11:00:00'),
(2, 'Machine Learning with Scikit-learn', 5, 'courses/python/lesson-05-sklearn.mp4', 4500, false, '2024-01-11 11:30:00', '2024-01-11 11:30:00'),
(2, 'Deep Learning with TensorFlow', 6, 'courses/python/lesson-06-tensorflow.mp4', 5400, false, '2024-01-11 12:00:00', '2024-01-11 12:00:00');

-- JavaScript Full Stack Course Lessons
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(3, 'JavaScript Fundamentals', 1, 'courses/javascript/lesson-01-fundamentals.mp4', 2400, true, '2024-01-12 10:15:00', '2024-01-12 10:15:00'),
(3, 'DOM Manipulation and Events', 2, 'courses/javascript/lesson-02-dom.mp4', 3000, false, '2024-01-12 10:45:00', '2024-01-12 10:45:00'),
(3, 'Node.js Backend Development', 3, 'courses/javascript/lesson-03-nodejs.mp4', 4200, false, '2024-01-12 11:15:00', '2024-01-12 11:15:00'),
(3, 'React Frontend Development', 4, 'courses/javascript/lesson-04-react.mp4', 4800, false, '2024-01-12 11:45:00', '2024-01-12 11:45:00'),
(3, 'MongoDB Database Integration', 5, 'courses/javascript/lesson-05-mongodb.mp4', 3600, false, '2024-01-12 12:15:00', '2024-01-12 12:15:00'),
(3, 'Full Stack Project Deployment', 6, 'courses/javascript/lesson-06-deployment.mp4', 2700, false, '2024-01-12 12:45:00', '2024-01-12 12:45:00');

-- Japanese Language Course Lessons
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(4, 'Hiragana Alphabet Introduction', 1, 'courses/japanese/lesson-01-hiragana.mp4', 1800, true, '2024-01-13 11:00:00', '2024-01-13 11:00:00'),
(4, 'Katakana Alphabet Learning', 2, 'courses/japanese/lesson-02-katakana.mp4', 2100, false, '2024-01-13 11:30:00', '2024-01-13 11:30:00'),
(4, 'Basic Japanese Greetings', 3, 'courses/japanese/lesson-03-greetings.mp4', 1500, false, '2024-01-13 12:00:00', '2024-01-13 12:00:00'),
(4, 'Numbers and Counting in Japanese', 4, 'courses/japanese/lesson-04-numbers.mp4', 1200, false, '2024-01-13 12:30:00', '2024-01-13 12:30:00'),
(4, 'Family and Relationships Vocabulary', 5, 'courses/japanese/lesson-05-family.mp4', 1800, false, '2024-01-13 13:00:00', '2024-01-13 13:00:00'),
(4, 'Daily Conversation Practice', 6, 'courses/japanese/lesson-06-conversation.mp4', 2400, false, '2024-01-13 13:30:00', '2024-01-13 13:30:00');

-- Advanced Japanese Course Lessons
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(5, 'Advanced Grammar Structures', 1, 'courses/japanese-advanced/lesson-01-grammar.mp4', 2700, true, '2024-01-14 12:30:00', '2024-01-14 12:30:00'),
(5, 'Business Japanese Vocabulary', 2, 'courses/japanese-advanced/lesson-02-business.mp4', 3000, false, '2024-01-14 13:00:00', '2024-01-14 13:00:00'),
(5, 'Formal and Informal Speech', 3, 'courses/japanese-advanced/lesson-03-formal.mp4', 2400, false, '2024-01-14 13:30:00', '2024-01-14 13:30:00'),
(5, 'Japanese Cultural Context', 4, 'courses/japanese-advanced/lesson-04-culture.mp4', 3300, false, '2024-01-14 14:00:00', '2024-01-14 14:00:00'),
(5, 'Advanced Conversation Practice', 5, 'courses/japanese-advanced/lesson-05-conversation.mp4', 3600, false, '2024-01-14 14:30:00', '2024-01-14 14:30:00'),
(5, 'JLPT N2 Preparation', 6, 'courses/japanese-advanced/lesson-06-jlpt.mp4', 4200, false, '2024-01-14 15:00:00', '2024-01-14 15:00:00');

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
INSERT INTO orders (user_id, status, total_amount_cents, currency, created_at, updated_at) VALUES
(1, 'PAID', 29900, 'USD', '2024-01-20 10:00:00', '2024-01-20 10:05:00'),
(2, 'PAID', 39900, 'USD', '2024-01-21 11:30:00', '2024-01-21 11:35:00'),
(3, 'PAID', 34900, 'USD', '2024-01-22 14:15:00', '2024-01-22 14:20:00'),
(4, 'PAID', 19900, 'USD', '2024-01-23 16:45:00', '2024-01-23 16:50:00'),
(5, 'PAID', 24900, 'USD', '2024-01-24 09:20:00', '2024-01-24 09:25:00'),
(6, 'PAID', 22900, 'USD', '2024-01-25 13:10:00', '2024-01-25 13:15:00'),
(7, 'PAID', 27900, 'USD', '2024-01-26 15:30:00', '2024-01-26 15:35:00'),
(8, 'PAID', 21900, 'USD', '2024-01-27 12:45:00', '2024-01-27 12:50:00'),
(9, 'PAID', 18900, 'USD', '2024-01-28 17:20:00', '2024-01-28 17:25:00'),
(10, 'PAID', 25900, 'USD', '2024-01-29 19:00:00', '2024-01-29 19:05:00'),
(1, 'PAID', 32900, 'USD', '2024-01-30 10:30:00', '2024-01-30 10:35:00'),
(2, 'PAID', 44900, 'USD', '2024-01-31 14:20:00', '2024-01-31 14:25:00'),
(3, 'PAID', 29900, 'USD', '2024-02-01 16:10:00', '2024-02-01 16:15:00'),
(4, 'PAID', 37900, 'USD', '2024-02-02 11:45:00', '2024-02-02 11:50:00'),
(5, 'PAID', 39900, 'USD', '2024-02-03 13:30:00', '2024-02-03 13:35:00'),
(6, 'PAID', 34900, 'USD', '2024-02-04 15:15:00', '2024-02-04 15:20:00'),
(7, 'PAID', 49900, 'USD', '2024-02-05 18:30:00', '2024-02-05 18:35:00'),
(8, 'PAID', 32900, 'USD', '2024-02-06 20:45:00', '2024-02-06 20:50:00'),
(9, 'PAID', 27900, 'USD', '2024-02-07 22:00:00', '2024-02-07 22:05:00'),
(10, 'PAID', 35900, 'USD', '2024-02-08 09:15:00', '2024-02-08 09:20:00'),
(25, 'PAID', 19900, 'USD', '2024-02-09 10:00:00', '2024-02-09 10:05:00'),
(26, 'PAID', 22900, 'USD', '2024-02-10 11:30:00', '2024-02-10 11:35:00'),
(27, 'PAID', 15900, 'USD', '2024-02-11 14:00:00', '2024-02-11 14:05:00'),
(28, 'PAID', 24900, 'USD', '2024-02-12 16:30:00', '2024-02-12 16:35:00'),
(29, 'PAID', 17900, 'USD', '2024-02-13 18:00:00', '2024-02-13 18:05:00'),
(30, 'PAID', 12900, 'USD', '2024-02-14 20:15:00', '2024-02-14 20:20:00'),
(1, 'PENDING', 19900, 'USD', '2024-02-15 09:30:00', '2024-02-15 09:30:00'),
(2, 'CANCELED', 23900, 'USD', '2024-02-16 11:45:00', '2024-02-16 11:45:00'),
(3, 'PAID', 26900, 'USD', '2024-02-17 13:20:00', '2024-02-17 13:25:00'),
(4, 'PAID', 21900, 'USD', '2024-02-18 15:10:00', '2024-02-18 15:15:00');

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
INSERT INTO payments (user_id, course_id, enrollment_id, order_id, stripe_session_id, stripe_payment_intent, stripe_event_id, amount_cents, currency, provider, method, refunded_amount_cents, status, created_at, updated_at) VALUES
(1, 1, 1, 1, 'cs_test_1', 'pi_test_1', 'evt_test_1', 29900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-01-20 10:00:00', '2024-01-20 10:05:00'),
(2, 2, 2, 2, 'cs_test_2', 'pi_test_2', 'evt_test_2', 39900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-01-21 11:30:00', '2024-01-21 11:35:00'),
(3, 3, 3, 3, 'cs_test_3', 'pi_test_3', 'evt_test_3', 34900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-01-22 14:15:00', '2024-01-22 14:20:00'),
(4, 4, 4, 4, 'cs_test_4', 'pi_test_4', 'evt_test_4', 19900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-01-23 16:45:00', '2024-01-23 16:50:00'),
(5, 5, 5, 5, 'cs_test_5', 'pi_test_5', 'evt_test_5', 24900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-01-24 09:20:00', '2024-01-24 09:25:00'),
(6, 6, 6, 6, 'cs_test_6', 'pi_test_6', 'evt_test_6', 22900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-01-25 13:10:00', '2024-01-25 13:15:00'),
(7, 7, 7, 7, 'cs_test_7', 'pi_test_7', 'evt_test_7', 27900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-01-26 15:30:00', '2024-01-26 15:35:00'),
(8, 8, 8, 8, 'cs_test_8', 'pi_test_8', 'evt_test_8', 21900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-01-27 12:45:00', '2024-01-27 12:50:00'),
(9, 9, 9, 9, 'cs_test_9', 'pi_test_9', 'evt_test_9', 18900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-01-28 17:20:00', '2024-01-28 17:25:00'),
(10, 10, 10, 10, 'cs_test_10', 'pi_test_10', 'evt_test_10', 25900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-01-29 19:00:00', '2024-01-29 19:05:00'),
(1, 2, 11, 11, 'cs_test_11', 'pi_test_11', 'evt_test_11', 32900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-01-30 10:30:00', '2024-01-30 10:35:00'),
(2, 3, 12, 12, 'cs_test_12', 'pi_test_12', 'evt_test_12', 44900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-01-31 14:20:00', '2024-01-31 14:25:00'),
(3, 4, 13, 13, 'cs_test_13', 'pi_test_13', 'evt_test_13', 29900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-02-01 16:10:00', '2024-02-01 16:15:00'),
(4, 5, 14, 14, 'cs_test_14', 'pi_test_14', 'evt_test_14', 37900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-02-02 11:45:00', '2024-02-02 11:50:00'),
(5, 6, 15, 15, 'cs_test_15', 'pi_test_15', 'evt_test_15', 39900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-02-03 13:30:00', '2024-02-03 13:35:00'),
(6, 7, 16, 16, 'cs_test_16', 'pi_test_16', 'evt_test_16', 34900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-02-04 15:15:00', '2024-02-04 15:20:00'),
(7, 8, 17, 17, 'cs_test_17', 'pi_test_17', 'evt_test_17', 49900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-02-05 18:30:00', '2024-02-05 18:35:00'),
(8, 9, 18, 18, 'cs_test_18', 'pi_test_18', 'evt_test_18', 32900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-02-06 20:45:00', '2024-02-06 20:50:00'),
(9, 10, 19, 19, 'cs_test_19', 'pi_test_19', 'evt_test_19', 27900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-02-07 22:00:00', '2024-02-07 22:05:00'),
(10, 11, 20, 20, 'cs_test_20', 'pi_test_20', 'evt_test_20', 35900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-02-08 09:15:00', '2024-02-08 09:20:00'),
(25, 1, 21, 21, 'cs_test_21', 'pi_test_21', 'evt_test_21', 19900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-02-09 10:00:00', '2024-02-09 10:05:00'),
(26, 2, 22, 22, 'cs_test_22', 'pi_test_22', 'evt_test_22', 22900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-02-10 11:30:00', '2024-02-10 11:35:00'),
(27, 3, 23, 23, 'cs_test_23', 'pi_test_23', 'evt_test_23', 15900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-02-11 14:00:00', '2024-02-11 14:05:00'),
(28, 4, 24, 24, 'cs_test_24', 'pi_test_24', 'evt_test_24', 24900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-02-12 16:30:00', '2024-02-12 16:35:00'),
(29, 5, 25, 25, 'cs_test_25', 'pi_test_25', 'evt_test_25', 17900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-02-13 18:00:00', '2024-02-13 18:05:00'),
(30, 6, 26, 26, 'cs_test_26', 'pi_test_26', 'evt_test_26', 12900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-02-14 20:15:00', '2024-02-14 20:20:00'),
(1, 7, 27, 27, 'cs_test_27', 'pi_test_27', 'evt_test_27', 19900, 'USD', 'STRIPE', 'card', 0, 'REQUIRES_PAYMENT', '2024-02-15 09:30:00', '2024-02-15 09:30:00'),
(2, 8, 28, 28, 'cs_test_28', 'pi_test_28', 'evt_test_28', 23900, 'USD', 'STRIPE', 'card', 23900, 'REFUNDED', '2024-02-16 11:45:00', '2024-02-16 11:45:00'),
(3, 9, 29, 29, 'cs_test_29', 'pi_test_29', 'evt_test_29', 26900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-02-17 13:20:00', '2024-02-17 13:25:00'),
(4, 10, 30, 30, 'cs_test_30', 'pi_test_30', 'evt_test_30', 21900, 'USD', 'STRIPE', 'card', 0, 'PAID', '2024-02-18 15:10:00', '2024-02-18 15:15:00');

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
(1, 1, 'AI', 'Polymorphism trong Java là khả năng một object có thể có nhiều hình thái khác nhau. Có 2 loại: compile-time polymorphism (method overloading) và runtime polymorphism (method overriding). Bạn muốn tôi giải thích chi tiết về loại nào?', '2024-01-20 10:31:00', '2024-01-20 10:31:00'),
(2, 2, 'USER', 'Làm thế nào để xử lý missing data trong pandas?', '2024-01-21 12:00:00', '2024-01-21 12:00:00'),
(2, 2, 'AI', 'Có nhiều cách xử lý missing data trong pandas: 1) dropna() để xóa, 2) fillna() để điền giá trị, 3) interpolate() để nội suy. Bạn có thể cho tôi biết loại dữ liệu cụ thể để tôi đưa ra lời khuyên phù hợp.', '2024-01-21 12:01:00', '2024-01-21 12:01:00'),
(3, 3, 'USER', 'React hooks có khó học không?', '2024-01-22 15:00:00', '2024-01-22 15:00:00'),
(3, 3, 'AI', 'React hooks ban đầu có thể hơi khó hiểu, nhưng với thực hành sẽ trở nên dễ dàng. Bắt đầu với useState và useEffect, sau đó học các hooks khác. Bạn đã có kinh nghiệm với React class components chưa?', '2024-01-22 15:01:00', '2024-01-22 15:01:00'),
(4, 4, 'USER', 'Hiragana và Katakana khác nhau như thế nào?', '2024-01-23 17:00:00', '2024-01-23 17:00:00'),
(4, 4, 'AI', 'Hiragana dùng cho từ thuần Nhật và ngữ pháp, có nét mềm mại. Katakana dùng cho từ mượn nước ngoài, có nét góc cạnh. Ví dụ: こんにちは (hiragana) vs コーヒー (katakana - coffee). Bạn muốn học cách viết không?', '2024-01-23 17:01:00', '2024-01-23 17:01:00'),
(5, 5, 'USER', 'Khi nào dùng です và だ trong tiếng Nhật?', '2024-01-24 10:00:00', '2024-01-24 10:00:00'),
(5, 5, 'AI', 'です dùng trong văn nói lịch sự và văn viết trang trọng. だ dùng trong văn nói thân mật và văn viết không trang trọng. Ví dụ: 学生です (lịch sự) vs 学生だ (thân mật). Bạn đang học cấp độ nào?', '2024-01-24 10:01:00', '2024-01-24 10:01:00'),
(6, 6, 'USER', 'Cách viết email business bằng tiếng Anh?', '2024-01-25 14:00:00', '2024-01-25 14:00:00'),
(6, 6, 'AI', 'Email business cần có: 1) Subject line rõ ràng, 2) Greeting phù hợp (Dear Mr./Ms.), 3) Body ngắn gọn, 4) Closing lịch sự (Best regards), 5) Signature đầy đủ. Bạn muốn tôi hướng dẫn viết email cụ thể nào?', '2024-01-25 14:01:00', '2024-01-25 14:01:00'),
(7, 7, 'USER', 'IELTS Writing Task 2 có cấu trúc như thế nào?', '2024-01-26 16:00:00', '2024-01-26 16:00:00'),
(7, 7, 'AI', 'IELTS Writing Task 2 có cấu trúc: 1) Introduction (paraphrase + thesis), 2) Body paragraph 1 (topic sentence + examples), 3) Body paragraph 2 (topic sentence + examples), 4) Conclusion (restate thesis). Bạn đang luyện dạng đề nào?', '2024-01-26 16:01:00', '2024-01-26 16:01:00'),
(8, 8, 'USER', '한국어 문법이 어려워요 (Ngữ pháp tiếng Hàn khó quá)', '2024-01-27 13:00:00', '2024-01-27 13:00:00'),
(8, 8, 'AI', '한국어 문법은 처음에는 어려울 수 있지만, 규칙을 이해하면 쉽습니다. 주어-목적어-서술어 순서와 조사 사용법을 먼저 익히세요. 어떤 문법이 가장 어려우신가요? (Ngữ pháp tiếng Hàn ban đầu có thể khó nhưng hiểu quy tắc sẽ dễ. Học thứ tự chủ ngữ-tân ngữ-vị ngữ và cách dùng trợ từ trước. Ngữ pháp nào khó nhất với bạn?)', '2024-01-27 13:01:00', '2024-01-27 13:01:00'),
(9, 9, 'USER', '中文的声调怎么学？(Làm sao học thanh điệu tiếng Trung?)', '2024-01-28 18:00:00', '2024-01-28 18:00:00'),
(9, 9, 'AI', '中文有四个声调：第一声（平声）、第二声（上声）、第三声（去声）、第四声（入声）。建议多听多练，可以用手势帮助记忆。你想练习哪个声调？(Tiếng Trung có 4 thanh điệu. Nên nghe nhiều luyện nhiều, dùng cử chỉ giúp nhớ. Bạn muốn luyện thanh điệu nào?)', '2024-01-28 18:01:00', '2024-01-28 18:01:00'),
(10, 10, 'USER', 'Comment apprendre le français rapidement? (Làm sao học tiếng Pháp nhanh?)', '2024-01-29 20:00:00', '2024-01-29 20:00:00'),
(10, 10, 'AI', 'Pour apprendre le français rapidement: 1) Écoutez des podcasts français, 2) Regardez des films avec sous-titres, 3) Parlez avec des natifs, 4) Utilisez des applications comme Duolingo. Quel est votre niveau actuel? (Để học tiếng Pháp nhanh: 1) Nghe podcast tiếng Pháp, 2) Xem phim có phụ đề, 3) Nói chuyện với người bản xứ, 4) Dùng app như Duolingo. Trình độ hiện tại của bạn là gì?)', '2024-01-29 20:01:00', '2024-01-29 20:01:00'),
(11, 11, 'USER', 'SEO là gì và tại sao quan trọng?', '2024-01-30 11:00:00', '2024-01-30 11:00:00'),
(11, 11, 'AI', 'SEO (Search Engine Optimization) là tối ưu hóa công cụ tìm kiếm, giúp website xuất hiện cao hơn trên Google. Quan trọng vì 75% người dùng không click qua trang 2. Bạn muốn tôi hướng dẫn SEO on-page hay off-page?', '2024-01-30 11:01:00', '2024-01-30 11:01:00'),
(12, 12, 'USER', 'PMP certification có khó không?', '2024-01-31 15:00:00', '2024-01-31 15:00:00'),
(12, 12, 'AI', 'PMP certification khá khó, cần 35 giờ training và 3-5 năm kinh nghiệm quản lý dự án. Thi 200 câu trong 4 giờ, đậu 61%. Bạn đã có đủ điều kiện tham gia chưa? Tôi có thể hướng dẫn lộ trình học.', '2024-01-31 15:01:00', '2024-01-31 15:01:00'),
(13, 13, 'USER', 'UI/UX design bắt đầu từ đâu?', '2024-02-01 17:00:00', '2024-02-01 17:00:00'),
(13, 13, 'AI', 'UI/UX design bắt đầu từ: 1) Học nguyên lý thiết kế (color, typography, layout), 2) Sử dụng công cụ (Figma, Sketch), 3) Hiểu user research, 4) Thực hành với case study. Bạn có kinh nghiệm design nào chưa?', '2024-02-01 17:01:00', '2024-02-01 17:01:00'),
(14, 14, 'USER', 'Cybersecurity threats phổ biến nhất là gì?', '2024-02-02 12:00:00', '2024-02-02 12:00:00'),
(14, 14, 'AI', 'Các threats phổ biến: 1) Phishing (email giả), 2) Malware (virus, trojan), 3) Ransomware (mã hóa dữ liệu), 4) DDoS attacks, 5) Insider threats. Bạn muốn tôi hướng dẫn cách phòng chống loại nào?', '2024-02-02 12:01:00', '2024-02-02 12:01:00'),
(15, 15, 'USER', 'AWS services nào quan trọng nhất?', '2024-02-03 14:00:00', '2024-02-03 14:00:00'),
(15, 15, 'AI', 'AWS services quan trọng: 1) EC2 (máy ảo), 2) S3 (lưu trữ), 3) RDS (database), 4) Lambda (serverless), 5) CloudFront (CDN). Bạn đang học để làm gì? Tôi có thể đưa ra roadmap phù hợp.', '2024-02-03 14:01:00', '2024-02-03 14:01:00');

-- 11. AUDIT LOGS (30 records)
-- System audit logs
INSERT INTO audit_logs (actor_user_id, action, entity_type, entity_id, diff, created_at, updated_at) VALUES
(1, 'USER_LOGIN', 'User', 1, '{"login_time": "2024-01-20T10:00:00Z"}', '2024-01-20 10:00:00', '2024-01-20 10:00:00'),
(2, 'COURSE_ENROLLED', 'Enrollment', 2, '{"course_id": 2, "user_id": 2, "status": "ACTIVE"}', '2024-01-21 11:30:00', '2024-01-21 11:30:00'),
(3, 'LESSON_COMPLETED', 'LessonProgress', 3, '{"lesson_id": 13, "watched_sec": 2400, "completed": true}', '2024-01-22 14:55:00', '2024-01-22 14:55:00'),
(4, 'PAYMENT_PROCESSED', 'Payment', 4, '{"amount_cents": 19900, "status": "SUCCEEDED"}', '2024-01-23 16:50:00', '2024-01-23 16:50:00'),
(5, 'ORDER_CREATED', 'Order', 5, '{"total_amount_cents": 24900, "status": "COMPLETED"}', '2024-01-24 09:20:00', '2024-01-24 09:20:00'),
(6, 'COURSE_UPDATED', 'Course', 6, '{"title": "English Business Communication", "price_cents": 22900}', '2024-01-25 13:10:00', '2024-01-25 13:10:00'),
(7, 'USER_PROFILE_UPDATED', 'User', 7, '{"full_name": "Tom Anderson"}', '2024-01-26 15:30:00', '2024-01-26 15:30:00'),
(8, 'LESSON_STARTED', 'LessonProgress', 8, '{"lesson_id": 43, "watched_sec": 0, "completed": false}', '2024-01-27 12:45:00', '2024-01-27 12:45:00'),
(9, 'CHAT_MESSAGE_SENT', 'ChatHistory', 9, '{"message_role": "USER", "content": "中文的声调怎么学？"}', '2024-01-28 18:00:00', '2024-01-28 18:00:00'),
(10, 'COURSE_PUBLISHED', 'Course', 10, '{"status": "PUBLISHED", "published": true}', '2024-01-29 19:00:00', '2024-01-29 19:00:00'),
(11, 'INSTRUCTOR_ASSIGNED', 'CourseInstructor', 11, '{"course_id": 11, "user_id": 19, "role": "OWNER"}', '2024-01-30 10:30:00', '2024-01-30 10:30:00'),
(12, 'PAYMENT_REFUNDED', 'Payment', 12, '{"refunded_amount_cents": 23900, "status": "REFUNDED"}', '2024-01-31 14:20:00', '2024-01-31 14:20:00'),
(13, 'LESSON_PROGRESS_UPDATED', 'LessonProgress', 13, '{"watched_sec": 3000, "completed": true}', '2024-02-01 16:15:00', '2024-02-01 16:15:00'),
(14, 'COURSE_ARCHIVED', 'Course', 14, '{"status": "ARCHIVED", "published": false}', '2024-02-02 11:45:00', '2024-02-02 11:45:00'),
(15, 'USER_ROLE_CHANGED', 'User', 15, '{"role": "INSTRUCTOR", "previous_role": "STUDENT"}', '2024-02-03 13:30:00', '2024-02-03 13:30:00'),
(16, 'ENROLLMENT_CANCELLED', 'Enrollment', 16, '{"status": "CANCELLED", "previous_status": "ACTIVE"}', '2024-02-04 15:15:00', '2024-02-04 15:15:00'),
(17, 'COURSE_PRICE_UPDATED', 'Course', 17, '{"price_cents": 49900, "previous_price": 39900}', '2024-02-05 18:30:00', '2024-02-05 18:30:00'),
(18, 'LESSON_ADDED', 'VideoLesson', 18, '{"title": "Docker and Kubernetes", "course_id": 18, "order_index": 1}', '2024-02-06 20:45:00', '2024-02-06 20:45:00'),
(19, 'CHAT_AI_RESPONSE', 'ChatHistory', 19, '{"message_role": "AI", "content": "Pour apprendre le français rapidement..."}', '2024-02-07 22:00:00', '2024-02-07 22:00:00'),
(20, 'ORDER_STATUS_CHANGED', 'Order', 20, '{"status": "COMPLETED", "previous_status": "PENDING"}', '2024-02-08 09:15:00', '2024-02-08 09:15:00'),
(25, 'USER_REGISTERED', 'User', 25, '{"username": "student_robert", "role": "STUDENT", "enabled": true}', '2024-02-09 10:00:00', '2024-02-09 10:00:00'),
(26, 'COURSE_VIEWED', 'Course', 26, '{"user_id": 26, "view_count": 1}', '2024-02-10 11:30:00', '2024-02-10 11:30:00'),
(27, 'LESSON_DOWNLOADED', 'VideoLesson', 27, '{"user_id": 27, "lesson_id": 27, "download_time": "2024-02-11T14:00:00Z"}', '2024-02-11 14:00:00', '2024-02-11 14:00:00'),
(28, 'PAYMENT_FAILED', 'Payment', 28, '{"amount_cents": 23900, "status": "FAILED", "error": "Insufficient funds"}', '2024-02-12 16:30:00', '2024-02-12 16:30:00'),
(29, 'COURSE_RATING_SUBMITTED', 'Course', 29, '{"user_id": 29, "rating": 5, "review": "Excellent course!"}', '2024-02-13 18:00:00', '2024-02-13 18:00:00'),
(30, 'INSTRUCTOR_ADDED', 'CourseInstructor', 30, '{"course_id": 30, "user_id": 18, "role": "ASSISTANT"}', '2024-02-14 20:15:00', '2024-02-14 20:15:00'),
(1, 'USER_LOGOUT', 'User', 1, '{"logout_time": "2024-02-15T09:30:00Z"}', '2024-02-15 09:30:00', '2024-02-15 09:30:00'),
(2, 'COURSE_COMPLETED', 'Enrollment', 2, '{"status": "COMPLETED", "completion_date": "2024-02-16T11:45:00Z"}', '2024-02-16 11:45:00', '2024-02-16 11:45:00'),
(3, 'CERTIFICATE_GENERATED', 'Enrollment', 3, '{"certificate_id": "CERT_001", "generated_at": "2024-02-17T13:20:00Z"}', '2024-02-17 13:20:00', '2024-02-17 13:20:00'),
(4, 'COURSE_SHARED', 'Course', 4, '{"shared_by": 4, "platform": "social_media", "share_count": 1}', '2024-02-18 15:10:00', '2024-02-18 15:10:00');

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
-- English Business Communication Course
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(6, 'Business Email Writing', 1, 'courses/english-business/lesson-01-email.mp4', 1800, true, '2024-01-15 14:00:00', '2024-01-15 14:00:00'),
(6, 'Meeting Communication Skills', 2, 'courses/english-business/lesson-02-meetings.mp4', 2400, false, '2024-01-15 14:30:00', '2024-01-15 14:30:00'),
(6, 'Presentation Techniques', 3, 'courses/english-business/lesson-03-presentations.mp4', 2700, false, '2024-01-15 15:00:00', '2024-01-15 15:00:00'),
(6, 'Negotiation Language', 4, 'courses/english-business/lesson-04-negotiation.mp4', 3000, false, '2024-01-15 15:30:00', '2024-01-15 15:30:00'),
(6, 'Cross-cultural Communication', 5, 'courses/english-business/lesson-05-cultural.mp4', 2100, false, '2024-01-15 16:00:00', '2024-01-15 16:00:00'),
(6, 'Professional Networking', 6, 'courses/english-business/lesson-06-networking.mp4', 1800, false, '2024-01-15 16:30:00', '2024-01-15 16:30:00');

-- IELTS Preparation Course
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(7, 'IELTS Listening Strategies', 1, 'courses/ielts/lesson-01-listening.mp4', 2400, true, '2024-01-16 15:45:00', '2024-01-16 15:45:00'),
(7, 'Reading Comprehension Techniques', 2, 'courses/ielts/lesson-02-reading.mp4', 3000, false, '2024-01-16 16:15:00', '2024-01-16 16:15:00'),
(7, 'Writing Task 1 - Academic', 3, 'courses/ielts/lesson-03-writing-task1.mp4', 3600, false, '2024-01-16 16:45:00', '2024-01-16 16:45:00'),
(7, 'Writing Task 2 - Essay', 4, 'courses/ielts/lesson-04-writing-task2.mp4', 4200, false, '2024-01-16 17:15:00', '2024-01-16 17:15:00'),
(7, 'Speaking Part 1 & 2', 5, 'courses/ielts/lesson-05-speaking.mp4', 2700, false, '2024-01-16 17:45:00', '2024-01-16 17:45:00'),
(7, 'Mock Test Practice', 6, 'courses/ielts/lesson-06-mock-test.mp4', 5400, false, '2024-01-16 18:15:00', '2024-01-16 18:15:00');

-- Korean Language Course
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(8, '한글 기본 자모 (Hangul Basics)', 1, 'courses/korean/lesson-01-hangul.mp4', 1800, true, '2024-01-17 16:20:00', '2024-01-17 16:20:00'),
(8, '기본 인사말 (Basic Greetings)', 2, 'courses/korean/lesson-02-greetings.mp4', 1500, false, '2024-01-17 16:50:00', '2024-01-17 16:50:00'),
(8, '숫자와 셈하기 (Numbers)', 3, 'courses/korean/lesson-03-numbers.mp4', 1200, false, '2024-01-17 17:20:00', '2024-01-17 17:20:00'),
(8, '가족과 관계 (Family)', 4, 'courses/korean/lesson-04-family.mp4', 1800, false, '2024-01-17 17:50:00', '2024-01-17 17:50:00'),
(8, '음식과 식사 (Food)', 5, 'courses/korean/lesson-05-food.mp4', 2100, false, '2024-01-17 18:20:00', '2024-01-17 18:20:00'),
(8, '일상 대화 (Daily Conversation)', 6, 'courses/korean/lesson-06-daily.mp4', 2400, false, '2024-01-17 18:50:00', '2024-01-17 18:50:00');

-- Chinese Mandarin Course
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(9, '拼音基础 (Pinyin Basics)', 1, 'courses/chinese/lesson-01-pinyin.mp4', 1800, true, '2024-01-18 17:10:00', '2024-01-18 17:10:00'),
(9, '基本汉字 (Basic Characters)', 2, 'courses/chinese/lesson-02-characters.mp4', 2400, false, '2024-01-18 17:40:00', '2024-01-18 17:40:00'),
(9, '问候语 (Greetings)', 3, 'courses/chinese/lesson-03-greetings.mp4', 1500, false, '2024-01-18 18:10:00', '2024-01-18 18:10:00'),
(9, '数字和颜色 (Numbers & Colors)', 4, 'courses/chinese/lesson-04-numbers-colors.mp4', 1800, false, '2024-01-18 18:40:00', '2024-01-18 18:40:00'),
(9, '家庭介绍 (Family Introduction)', 5, 'courses/chinese/lesson-05-family.mp4', 2100, false, '2024-01-18 19:10:00', '2024-01-18 19:10:00'),
(9, '购物对话 (Shopping)', 6, 'courses/chinese/lesson-06-shopping.mp4', 2400, false, '2024-01-18 19:40:00', '2024-01-18 19:40:00');

-- French Language Course
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(10, 'Alphabet et Prononciation', 1, 'courses/french/lesson-01-alphabet.mp4', 1800, true, '2024-01-19 18:00:00', '2024-01-19 18:00:00'),
(10, 'Salutations de Base', 2, 'courses/french/lesson-02-greetings.mp4', 1500, false, '2024-01-19 18:30:00', '2024-01-19 18:30:00'),
(10, 'Nombres et Âge', 3, 'courses/french/lesson-03-numbers.mp4', 1200, false, '2024-01-19 19:00:00', '2024-01-19 19:00:00'),
(10, 'Famille et Amis', 4, 'courses/french/lesson-04-family.mp4', 1800, false, '2024-01-19 19:30:00', '2024-01-19 19:30:00'),
(10, 'Nourriture et Boissons', 5, 'courses/french/lesson-05-food.mp4', 2100, false, '2024-01-19 20:00:00', '2024-01-19 20:00:00'),
(10, 'Conversation Quotidienne', 6, 'courses/french/lesson-06-daily.mp4', 2400, false, '2024-01-19 20:30:00', '2024-01-19 20:30:00');

-- =============================================
-- SAMPLE DATA COMPLETED
-- Total: 30 records for each entity
-- =============================================