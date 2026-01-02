-- =============================================
-- E-LEARNING PLATFORM - MASTER INITIALIZATION DATA
-- Combined & Standardized Version (40 Courses)
-- Currency: VND (Vietnamese Dong)
-- Context: Chatbot & Real-world Usage
-- 
-- UPDATED: 
-- 1. Disables SQL_SAFE_UPDATES to avoid Error 1175.
-- 2. Preserves 'users' table (does NOT delete users).
-- 3. Clears and repopulates courses, lessons, and related transactional data.
-- =============================================

SET NAMES utf8mb4;
SET SQL_SAFE_UPDATES = 0; -- Disable safe update mode to allow DELETE without WHERE key
SET FOREIGN_KEY_CHECKS = 0;

-- 1. CLEAN UP COURSE-RELATED DATA ONLY (Keep Users)
-- =========================
DELETE FROM webhook_events;
DELETE FROM audit_logs;
DELETE FROM chat_histories;
DELETE FROM lesson_progress;
DELETE FROM payments;
DELETE FROM order_items;
DELETE FROM orders;
DELETE FROM enrollments;
DELETE FROM video_lessons;
DELETE FROM course_instructors;
DELETE FROM courses;

-- Reset Auto Increment for course-related tables
ALTER TABLE courses AUTO_INCREMENT = 1;
ALTER TABLE video_lessons AUTO_INCREMENT = 1;
ALTER TABLE course_instructors AUTO_INCREMENT = 1;
ALTER TABLE enrollments AUTO_INCREMENT = 1;
ALTER TABLE orders AUTO_INCREMENT = 1;
ALTER TABLE order_items AUTO_INCREMENT = 1;
ALTER TABLE payments AUTO_INCREMENT = 1;
ALTER TABLE lesson_progress AUTO_INCREMENT = 1;
ALTER TABLE chat_histories AUTO_INCREMENT = 1;
ALTER TABLE audit_logs AUTO_INCREMENT = 1;
ALTER TABLE webhook_events AUTO_INCREMENT = 1;


-- 2. INSERT COURSES (40 Courses - VND Pricing - Increased x100)
-- =========================

INSERT INTO courses (id, title, slug, description, price_cents, currency, published, thumbnail_url, status, created_at, updated_at) VALUES
-- 1-5: FREE COURSES (Price 0)
(1, 'Lập Trình Java Căn Bản (Miễn Phí)', 'java-basic-free', 'Khóa học Java nền tảng dành cho người mới bắt đầu. Học về biến, vòng lặp, OOP cơ bản.', 0, 'VND', true, 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(2, 'Python Cho Khoa Học Dữ Liệu (Intro)', 'python-data-science-intro', 'Làm quen với Python và các thư viện Numpy, Pandas cơ bản để phân tích dữ liệu.', 0, 'VND', true, 'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(3, 'Nhập Môn HTML & CSS', 'html-css-intro', 'Xây dựng giao diện web cơ bản với HTML5 và CSS3. Bước đầu trở thành Frontend Developer.', 0, 'VND', true, 'https://images.unsplash.com/photo-1621839673705-6617adf9e890?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(4, 'Kỹ Năng Quản Lý Thời Gian', 'time-management-free', 'Phương pháp Pomodoro, Time Blocking để tối ưu hiệu suất làm việc hàng ngày.', 0, 'VND', true, 'https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(5, 'Tiếng Anh Giao Tiếp Cơ Bản', 'english-communication-basic', 'Các mẫu câu giao tiếp thông dụng trong công việc và đời sống hàng ngày.', 0, 'VND', true, 'https://images.unsplash.com/photo-1543269865-cbf427effbad?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),

-- 6-15: PROGRAMMING & TECH (Original * 100)
(6, 'Java Masterclass: Từ Zero đến Hero', 'java-masterclass', 'Khóa học Java chuyên sâu: Collections, Streams, Multithreading và Spring Boot cơ bản.', 129900000, 'VND', true, 'https://images.unsplash.com/photo-1516116216624-53e697fedbea?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(7, 'Fullstack Web với React & Node.js', 'fullstack-react-node', 'Xây dựng ứng dụng MERN Stack hoàn chỉnh. RESTful API, Redux, MongoDB.', 159900000, 'VND', true, 'https://images.unsplash.com/photo-1633356122544-f134324a6cee?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(8, 'DevOps Chuyên Nghiệp: Docker & K8s', 'devops-docker-k8s', 'Làm chủ Containerization và Orchestration. CI/CD Pipeline thực chiến.', 189000000, 'VND', true, 'https://images.unsplash.com/photo-1605745341112-85968b19335b?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(9, 'Machine Learning A-Z', 'machine-learning-az', 'Học máy từ cơ bản đến nâng cao. Scikit-learn, TensorFlow, Deep Learning.', 210000000, 'VND', true, 'https://images.unsplash.com/photo-1555949963-ff9fe0c870eb?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(10, 'AWS Cloud Practitioner Ultimate', 'aws-cloud-practitioner', 'Luyện thi chứng chỉ AWS Cloud Practitioner. Kiến thức nền tảng về Cloud Computing.', 99000000, 'VND', true, 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(11, 'Lập Trình Mobile với React Native', 'react-native-mobile', 'Phát triển ứng dụng đa nền tảng iOS & Android với một codebase duy nhất.', 145000000, 'VND', true, 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(12, 'An Ninh Mạng (Cybersecurity) Cơ Bản', 'cybersecurity-basics', 'Nhận biết các mối đe dọa an ninh mạng, bảo mật thông tin và phòng chống tấn công.', 110000000, 'VND', true, 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(13, 'GraphQL API Development', 'graphql-api-dev', 'Xây dựng API hiện đại, linh hoạt với GraphQL và Apollo Server.', 89000000, 'VND', true, 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(14, 'Blockchain & Cryptocurrency', 'blockchain-crypto', 'Hiểu về công nghệ chuỗi khối, Smart Contracts và thị trường tiền điện tử.', 135000000, 'VND', true, 'https://images.unsplash.com/photo-1639762681485-074b7f938ba0?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(15, 'Cấu Trúc Dữ Liệu & Giải Thuật', 'dsa-java', 'Nền tảng tư duy lập trình. Luyện LeetCode phỏng vấn các công ty lớn.', 79000000, 'VND', true, 'https://images.unsplash.com/photo-1509966756634-9c23dd6e6815?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),

-- 16-25: LANGUAGE & SOFT SKILLS (Original * 100)
(16, 'Tiếng Nhật N5 - N4 Cấp Tốc', 'japanese-n5-n4', 'Học tiếng Nhật sơ cấp, bảng chữ cái, ngữ pháp cơ bản và Kaiwa.', 59000000, 'VND', true, 'https://images.unsplash.com/photo-1528164344705-47542687000d?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(17, 'Luyện Thi IELTS 7.0+', 'ielts-7-plus', 'Chiến lược làm bài 4 kỹ năng Nghe, Nói, Đọc, Viết đạt band điểm cao.', 150000000, 'VND', true, 'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(18, 'Tiếng Hàn Giao Tiếp', 'korean-communication', 'Giao tiếp tiếng Hàn tự nhiên trong công việc và du lịch.', 65000000, 'VND', true, 'https://images.unsplash.com/photo-1517154421773-0529f29ea451?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(19, 'Tiếng Trung Cho Người Mới', 'chinese-beginner', 'Học phát âm Pinyin, chữ Hán cơ bản và đàm thoại thông dụng.', 55000000, 'VND', true, 'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(20, 'Kỹ Năng Lãnh Đạo (Leadership)', 'leadership-skills', 'Phát triển tư duy lãnh đạo, quản lý đội nhóm và ra quyết định.', 85000000, 'VND', true, 'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(21, 'Nghệ Thuật Thuyết Trình', 'public-speaking-art', 'Tự tin nói trước đám đông, xây dựng bài thuyết trình cuốn hút.', 49000000, 'VND', true, 'https://images.unsplash.com/photo-1475721027767-p2177ee4760d?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(22, 'Quản Lý Tài Chính Cá Nhân', 'personal-finance', 'Tự do tài chính, đầu tư chứng khoán và quản lý chi tiêu hiệu quả.', 99000000, 'VND', true, 'https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(23, 'Digital Marketing Thực Chiến', 'digital-marketing-pro', 'SEO, Google Ads, Facebook Ads và Content Marketing.', 125000000, 'VND', true, 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(24, 'Viết Sáng Tạo (Creative Writing)', 'creative-writing', 'Kỹ thuật viết truyện, kịch bản và copywriting thu hút.', 45000000, 'VND', true, 'https://images.unsplash.com/photo-1455390582262-044cdead277a?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(25, 'Project Management (PMP)', 'pmp-certification', 'Quản lý dự án chuyên nghiệp theo chuẩn PMI.', 199000000, 'VND', true, 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),

-- 26-30: DESIGN & CREATIVE (Original * 100)
(26, 'Thiết Kế UI/UX Cơ Bản', 'ui-ux-design', 'Tư duy thiết kế trải nghiệm người dùng, sử dụng Figma.', 95000000, 'VND', true, 'https://images.unsplash.com/photo-1561070791-2526d30994b5?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(27, 'Nhiếp Ảnh (Photography) Masterclass', 'photography-master', 'Kỹ thuật chụp ảnh, bố cục, ánh sáng và hậu kỳ với Lightroom.', 75000000, 'VND', true, 'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(28, 'Dựng Phim Với Adobe Premiere', 'video-editing-premiere', 'Biên tập video chuyên nghiệp, hiệu ứng và chỉnh màu.', 85000000, 'VND', true, 'https://images.unsplash.com/photo-1533750516457-a7f992034fec?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(29, 'Thiết Kế Đồ Họa Photoshop & AI', 'graphic-design-adobe', 'Làm chủ công cụ thiết kế đồ họa hàng đầu thế giới.', 92000000, 'VND', true, 'https://images.unsplash.com/photo-1626785774573-4b799314346d?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(30, 'Vẽ Minh Họa Digital Art', 'digital-art-illustration', 'Học vẽ kỹ thuật số trên Wacom và iPad.', 69000000, 'VND', true, 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),

-- 31-40: ADVANCED TECH (Original * 100)
(31, 'Spring Boot Advanced & Microservices', 'spring-boot-advanced', 'Kiến trúc Microservices, Spring Cloud, Kafka và Redis.', 250000000, 'VND', true, 'https://images.unsplash.com/photo-1607799275518-d58665d096b1?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(32, 'Vue.js 3 - The Complete Guide', 'vuejs-complete', 'Composition API, Vuex, Vue Router và Unit Testing.', 135000000, 'VND', true, 'https://images.unsplash.com/photo-1605792657660-596af9009e82?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(33, 'Angular Framework Mastery', 'angular-mastery', 'Xây dựng ứng dụng Enterprise với Angular, RxJS và NgRx.', 145000000, 'VND', true, 'https://images.unsplash.com/photo-1555099962-4199c345e5dd?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(34, 'TypeScript Deep Dive', 'typescript-deep-dive', 'Hiểu sâu về Type System, Generics và Decorators.', 89000000, 'VND', true, 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(35, 'Next.js Fullstack Development', 'nextjs-fullstack', 'Server-side Rendering (SSR), Static Site Generation (SSG) với Next.js.', 165000000, 'VND', true, 'https://images.unsplash.com/photo-1618477247222-acbdb0e159b3?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(36, 'PostgreSQL Database Administration', 'postgres-admin', 'Quản trị cơ sở dữ liệu PostgreSQL, tối ưu hiệu năng và sao lưu.', 120000000, 'VND', true, 'https://images.unsplash.com/photo-1544383835-bda2bc66a55d?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(37, 'Redis Caching & Performance', 'redis-performance', 'Tối ưu tốc độ ứng dụng với Redis Caching, Pub/Sub.', 95000000, 'VND', true, 'https://images.unsplash.com/photo-1518770660439-4636190af475?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(38, 'Elasticsearch Search Engine', 'elasticsearch-engine', 'Xây dựng công cụ tìm kiếm mạnh mẽ và phân tích log với ELK Stack.', 175000000, 'VND', true, 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(39, 'Go (Golang) Programming', 'golang-programming', 'Lập trình backend hiệu năng cao với Go. Concurrency và Microservices.', 155000000, 'VND', true, 'https://images.unsplash.com/photo-1623282033815-40b05d96c903?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW()),
(40, 'System Design Interview', 'system-design', 'Thiết kế hệ thống phân tán quy mô lớn. Chuẩn bị phỏng vấn Big Tech.', 220000000, 'VND', true, 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&h=450&fit=crop', 'PUBLISHED', NOW(), NOW());


-- 3. INSERT COURSE INSTRUCTORS
-- =========================
-- Assuming User ID 2 (Instructor) exists
INSERT INTO course_instructors (course_id, user_id, role, created_at, updated_at)
SELECT id, 2, 'OWNER', NOW(), NOW() FROM courses;


-- 4. INSERT VIDEO LESSONS (Specific Lessons for ALL Courses)
-- =========================

-- Course 1: Java (Free)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(1, 'Intro to Java', 1, 'yt:eIrMbAQSU34', 1800, true, NOW(), NOW()),
(1, 'Variables & Types', 2, 'yt:grEKMHGYyns', 2400, true, NOW(), NOW()),
(1, 'Control Structures', 3, 'yt:Z_Apf5T8eB8', 2700, true, NOW(), NOW()),
(1, 'OOP Basics', 4, 'yt:WR9gZg3X2Yg', 3600, true, NOW(), NOW()),
(1, 'Collections', 5, 'yt:rzA7UJ-hQn4', 4200, true, NOW(), NOW()),
(1, 'Exception Handling', 6, 'yt:34ky600pBGY', 2100, true, NOW(), NOW());

-- Course 2: Python (Free)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(2, 'Python Setup', 1, 'yt:rfscVS0vtbw', 2100, true, NOW(), NOW()),
(2, 'NumPy Basics', 2, 'yt:QUT1VHiLmmI', 3000, true, NOW(), NOW()),
(2, 'Pandas Intro', 3, 'yt:vmEHCJofslg', 3600, true, NOW(), NOW()),
(2, 'Matplotlib Plotting', 4, 'yt:UO98lJQ3QGI', 2700, true, NOW(), NOW()),
(2, 'Scikit-learn', 5, 'yt:pHyqZQJpOcE', 4500, true, NOW(), NOW()),
(2, 'TensorFlow Intro', 6, 'yt:tPYj3fFJGjk', 5400, true, NOW(), NOW());

-- Course 3: HTML/CSS (Free)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(3, 'HTML5 Basics', 1, 'yt:kUMe1FH4CHE', 2400, true, NOW(), NOW()),
(3, 'CSS3 Styling', 2, 'yt:1Rs2ND1ryYc', 3000, true, NOW(), NOW()),
(3, 'Flexbox Layout', 3, 'yt:phWxA89Dy9k', 2700, true, NOW(), NOW()),
(3, 'CSS Grid', 4, 'yt:jV8B24rSN5o', 3600, true, NOW(), NOW()),
(3, 'Responsive Design', 5, 'yt:vqWuQWd3Fqc', 4200, true, NOW(), NOW()),
(3, 'Building a Project', 6, 'yt:R7pV9MMUf_0', 5400, true, NOW(), NOW());

-- Course 4: Time Management (Free)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(4, 'Pomodoro Technique', 1, 'yt:VNtRh-H8R-M', 1200, true, NOW(), NOW()),
(4, 'Time Blocking', 2, 'yt:IGVn7J9kQvE', 1500, true, NOW(), NOW()),
(4, 'Prioritization', 3, 'yt:2i42g4k3k_k', 1800, true, NOW(), NOW()),
(4, 'Eliminating Distractions', 4, 'yt:X1x5k5k5k5k', 2000, true, NOW(), NOW()),
(4, 'Goal Setting', 5, 'yt:Y2y2y2y2y2y', 2200, true, NOW(), NOW()),
(4, 'Productivity Tools', 6, 'yt:Z3z3z3z3z3z', 2400, true, NOW(), NOW());

-- Course 5: English (Free)
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(5, 'Greetings', 1, 'yt:FwRd6p7C6cE', 1800, true, NOW(), NOW()),
(5, 'Small Talk', 2, 'yt:Q3q3q3q3q3q', 2100, true, NOW(), NOW()),
(5, 'Job Interview', 3, 'yt:W4w4w4w4w4w', 2400, true, NOW(), NOW()),
(5, 'Email Writing', 4, 'yt:E5e5e5e5e5e', 2700, true, NOW(), NOW()),
(5, 'Phone Skills', 5, 'yt:R6r6r6r6r6r', 3000, true, NOW(), NOW()),
(5, 'Presentation', 6, 'yt:T7t7t7t7t7t', 3300, true, NOW(), NOW());

-- Course 6: Java Masterclass
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(6, 'Java Collections Framework', 1, 'yt:eIrMbAQSU34', 1800, true, NOW(), NOW()),
(6, 'Java Streams API', 2, 'yt:grEKMHGYyns', 2400, false, NOW(), NOW()),
(6, 'Multithreading & Concurrency', 3, 'yt:Z_Apf5T8eB8', 2700, false, NOW(), NOW()),
(6, 'File I/O & NIO', 4, 'yt:WR9gZg3X2Yg', 3600, false, NOW(), NOW()),
(6, 'Database Connectivity (JDBC)', 5, 'yt:rzA7UJ-hQn4', 4200, false, NOW(), NOW()),
(6, 'Spring Boot Introduction', 6, 'yt:34ky600pBGY', 2100, false, NOW(), NOW());

-- Course 7: Fullstack Web React & Node
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(7, 'React Hooks & Context', 1, 'yt:SqcY0GlETPk', 2100, true, NOW(), NOW()),
(7, 'Node.js & Express Setup', 2, 'yt:fBNz5xF-Kx4', 3000, false, NOW(), NOW()),
(7, 'MongoDB & Mongoose', 3, 'yt:WDrU305J1yw', 3600, false, NOW(), NOW()),
(7, 'RESTful API Design', 4, 'yt:pKd0Rpw7O48', 2700, false, NOW(), NOW()),
(7, 'Redux State Management', 5, 'yt:93p3LxR9xfM', 4500, false, NOW(), NOW()),
(7, 'Deployment to Heroku', 6, 'yt:MBSQVjG7LIs', 5400, false, NOW(), NOW());

-- Course 8: DevOps
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(8, 'Docker Fundamentals', 1, 'yt:3c-iBn73dDE', 2400, true, NOW(), NOW()),
(8, 'Docker Compose', 2, 'yt:0B2raBqr_oe', 3000, false, NOW(), NOW()),
(8, 'Kubernetes Architecture', 3, 'yt:d6WC5n9G_sM', 2700, false, NOW(), NOW()),
(8, 'CI/CD with Jenkins', 4, 'yt:nCKxl7FWbC0', 3600, false, NOW(), NOW()),
(8, 'Infrastructure as Code (Terraform)', 5, 'yt:H4e2rg0rhoQ', 4200, false, NOW(), NOW()),
(8, 'Monitoring with Prometheus', 6, 'yt:QoD8x_n1eQ', 5400, false, NOW(), NOW());

-- Course 9: Machine Learning
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(9, 'Data Preprocessing', 1, 'yt:GwIo3gDZCVQ', 1800, true, NOW(), NOW()),
(9, 'Linear Regression', 2, 'yt:nk2CQBPm_nU', 2400, false, NOW(), NOW()),
(9, 'Logistic Regression', 3, 'yt:yIYKR4sgzI8', 2700, false, NOW(), NOW()),
(9, 'Decision Trees', 4, 'yt:7VeUPuFGJHk', 3600, false, NOW(), NOW()),
(9, 'Neural Networks Basics', 5, 'yt:aircAruvnKk', 4200, false, NOW(), NOW()),
(9, 'Model Evaluation', 6, 'yt:0pP4EwWJgIU', 2100, false, NOW(), NOW());

-- Course 10: AWS
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(10, 'IAM & Security', 1, 'yt:3hLmDS179YE', 2100, true, NOW(), NOW()),
(10, 'EC2 & Compute', 2, 'yt:lZd0d887A8w', 3000, false, NOW(), NOW()),
(10, 'S3 & Storage', 3, 'yt:e6w9LwZJFIA', 3600, false, NOW(), NOW()),
(10, 'RDS & Databases', 4, 'yt:rQ9qK7w8w8w', 2700, false, NOW(), NOW()),
(10, 'VPC & Networking', 5, 'yt:5W1h2h3h4h5', 4500, false, NOW(), NOW()),
(10, 'Lambda & Serverless', 6, 'yt:6W1h2h3h4h5', 5400, false, NOW(), NOW());

-- Course 11: React Native
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(11, 'Expo vs CLI', 1, 'yt:0-S5a0eXPoc', 1800, true, NOW(), NOW()),
(11, 'Flexbox & Layouts', 2, 'yt:mae3e4i5j6k', 2400, false, NOW(), NOW()),
(11, 'React Navigation', 3, 'yt:kae3e4i5j6k', 2700, false, NOW(), NOW()),
(11, 'State Management', 4, 'yt:lae3e4i5j6k', 3600, false, NOW(), NOW()),
(11, 'Native Device Features', 5, 'yt:mae3e4i5j6k', 4200, false, NOW(), NOW()),
(11, 'Publishing to Stores', 6, 'yt:nae3e4i5j6k', 2100, false, NOW(), NOW());

-- Course 12: Cybersecurity
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(12, 'Networking Basics', 1, 'yt:3Kq1MIfTWk0', 2400, true, NOW(), NOW()),
(12, 'Ethical Hacking Methodology', 2, 'yt:fTgt8e9d0a1', 3000, false, NOW(), NOW()),
(12, 'Web App Vulnerabilities', 3, 'yt:gUhu8e9d0a1', 2700, false, NOW(), NOW()),
(12, 'Network Sniffing', 4, 'yt:hVi8e9d0a1', 3600, false, NOW(), NOW()),
(12, 'Social Engineering', 5, 'yt:iWj8e9d0a1', 4200, false, NOW(), NOW()),
(12, 'Malware Analysis', 6, 'yt:jXk8e9d0a1', 5400, false, NOW(), NOW());

-- Course 13: GraphQL
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(13, 'REST vs GraphQL', 1, 'yt:ed8SzALpx1Q', 1800, true, NOW(), NOW()),
(13, 'Schema & Types', 2, 'yt:kYl8e9d0a1', 2100, false, NOW(), NOW()),
(13, 'Queries & Mutations', 3, 'yt:lZm8e9d0a1', 2400, false, NOW(), NOW()),
(13, 'Apollo Server', 4, 'yt:mZn8e9d0a1', 2700, false, NOW(), NOW()),
(13, 'Apollo Client', 5, 'yt:nZo8e9d0a1', 3000, false, NOW(), NOW()),
(13, 'Real-time Subscriptions', 6, 'yt:oZp8e9d0a1', 3300, false, NOW(), NOW());

-- Course 14: Blockchain
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(14, 'Blockchain Theory', 1, 'yt:SSo_EIwHSd4', 2100, true, NOW(), NOW()),
(14, 'Cryptography Basics', 2, 'yt:pZq8e9d0a1', 3000, false, NOW(), NOW()),
(14, 'Bitcoin & UTXO', 3, 'yt:qZr8e9d0a1', 3600, false, NOW(), NOW()),
(14, 'Ethereum & Smart Contracts', 4, 'yt:rZs8e9d0a1', 2700, false, NOW(), NOW()),
(14, 'Solidity Programming', 5, 'yt:sZt8e9d0a1', 4500, false, NOW(), NOW()),
(14, 'DApps Development', 6, 'yt:tZu8e9d0a1', 5400, false, NOW(), NOW());

-- Course 15: DSA
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(15, 'Big O Notation', 1, 'yt:v4cd1O4zkGw', 1800, true, NOW(), NOW()),
(15, 'Arrays & Strings', 2, 'yt:uZv8e9d0a1', 2400, false, NOW(), NOW()),
(15, 'Linked Lists', 3, 'yt:vZw8e9d0a1', 2700, false, NOW(), NOW()),
(15, 'Stacks & Queues', 4, 'yt:wZx8e9d0a1', 3600, false, NOW(), NOW()),
(15, 'Trees & Graphs', 5, 'yt:xZy8e9d0a1', 4200, false, NOW(), NOW()),
(15, 'Sorting Algorithms', 6, 'yt:yZz8e9d0a1', 2100, false, NOW(), NOW());

-- Course 16: Japanese
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(16, 'Hiragana & Katakana', 1, 'yt:s6DKRGTVLGA', 2400, true, NOW(), NOW()),
(16, 'Greetings & Introductions', 2, 'yt:z1a2b3c4d5', 3000, false, NOW(), NOW()),
(16, 'Numbers & Time', 3, 'yt:a1b2c3d4e5', 2700, false, NOW(), NOW()),
(16, 'Basic Particles', 4, 'yt:b1c2d3e4f5', 3600, false, NOW(), NOW()),
(16, 'Verb Conjugations', 5, 'yt:c1d2e3f4g5', 4200, false, NOW(), NOW()),
(16, 'Daily Conversation', 6, 'yt:d1e2f3g4h5', 5400, false, NOW(), NOW());

-- Course 17: IELTS
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(17, 'IELTS Overview', 1, 'yt:w1x2y3z4a5', 1800, true, NOW(), NOW()),
(17, 'Listening Strategies', 2, 'yt:x1y2z3a4b5', 2100, false, NOW(), NOW()),
(17, 'Reading Techniques', 3, 'yt:y1z2a3b4c5', 2400, false, NOW(), NOW()),
(17, 'Writing Task 1', 4, 'yt:z1a2b3c4d6', 2700, false, NOW(), NOW()),
(17, 'Writing Task 2', 5, 'yt:a1b2c3d4e7', 3000, false, NOW(), NOW()),
(17, 'Speaking Part 1-3', 6, 'yt:b1c2d3e4f8', 3300, false, NOW(), NOW());

-- Course 18: Korean
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(18, 'Hangul Alphabet', 1, 'yt:c1d2e3f4g9', 2100, true, NOW(), NOW()),
(18, 'Basic Greetings', 2, 'yt:d1e2f3g4h0', 3000, false, NOW(), NOW()),
(18, 'Sentence Structure', 3, 'yt:e1f2g3h4i1', 3600, false, NOW(), NOW()),
(18, 'Verb Tenses', 4, 'yt:f1g2h3i4j2', 2700, false, NOW(), NOW()),
(18, 'Honorifics', 5, 'yt:g1h2i3j4k3', 4500, false, NOW(), NOW()),
(18, 'Shopping & Dining', 6, 'yt:h1i2j3k4l4', 5400, false, NOW(), NOW());

-- Course 19: Chinese
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(19, 'Pinyin & Tones', 1, 'yt:i1j2k3l4m5', 2400, true, NOW(), NOW()),
(19, 'Basic Strokes', 2, 'yt:j1k2l3m4n6', 3000, false, NOW(), NOW()),
(19, 'Numbers & Counting', 3, 'yt:k1l2m3n4o7', 2700, false, NOW(), NOW()),
(19, 'Family & Introduction', 4, 'yt:l1m2n3o4p8', 3600, false, NOW(), NOW()),
(19, 'Time & Dates', 5, 'yt:m1n2o3p4q9', 4200, false, NOW(), NOW()),
(19, 'Food & Ordering', 6, 'yt:n1o2p3q4r0', 5400, false, NOW(), NOW());

-- Course 20: Leadership
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(20, 'Leadership Styles', 1, 'yt:o1p2q3r4s1', 1800, true, NOW(), NOW()),
(20, 'Team Motivation', 2, 'yt:p1q2r3s4t2', 2400, false, NOW(), NOW()),
(20, 'Conflict Resolution', 3, 'yt:q1r2s3t4u3', 2700, false, NOW(), NOW()),
(20, 'Strategic Planning', 4, 'yt:r1s2t3u4v4', 3600, false, NOW(), NOW()),
(20, 'Emotional Intelligence', 5, 'yt:s1t2u3v4w5', 4200, false, NOW(), NOW()),
(20, 'Delegation Skills', 6, 'yt:t1u2v3w4x6', 2100, false, NOW(), NOW());

-- Course 21: Public Speaking
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(21, 'Overcoming Fear', 1, 'yt:u1v2w3x4y7', 2100, true, NOW(), NOW()),
(21, 'Structuring Your Speech', 2, 'yt:v1w2x3y4z8', 3000, false, NOW(), NOW()),
(21, 'Body Language', 3, 'yt:w1x2y3z4a9', 3600, false, NOW(), NOW()),
(21, 'Voice Control', 4, 'yt:x1y2z3a4b0', 2700, false, NOW(), NOW()),
(21, 'Storytelling', 5, 'yt:y1z2a3b4c1', 4500, false, NOW(), NOW()),
(21, 'Handling Q&A', 6, 'yt:z1a2b3c4d2', 5400, false, NOW(), NOW());

-- Course 22: Personal Finance
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(22, 'Budgeting Basics', 1, 'yt:a2b3c4d5e3', 1800, true, NOW(), NOW()),
(22, 'Saving Strategies', 2, 'yt:b2c3d4e5f4', 2100, false, NOW(), NOW()),
(22, 'Debt Management', 3, 'yt:c2d3e4f5g5', 2400, false, NOW(), NOW()),
(22, 'Investing 101', 4, 'yt:d2e3f4g5h6', 2700, false, NOW(), NOW()),
(22, 'Retirement Planning', 5, 'yt:e2f3g4h5i7', 3000, false, NOW(), NOW()),
(22, 'Tax Basics', 6, 'yt:f2g3h4i5j8', 3300, false, NOW(), NOW());

-- Course 23: Digital Marketing
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(23, 'Marketing Fundamentals', 1, 'yt:g2h3i4j5k9', 2400, true, NOW(), NOW()),
(23, 'SEO Basics', 2, 'yt:h2i3j4k5l0', 3000, false, NOW(), NOW()),
(23, 'Content Marketing', 3, 'yt:i2j3k4l5m1', 2700, false, NOW(), NOW()),
(23, 'Social Media Strategy', 4, 'yt:j2k3l4m5n2', 3600, false, NOW(), NOW()),
(23, 'Email Marketing', 5, 'yt:k2l3m4n5o3', 4200, false, NOW(), NOW()),
(23, 'Analytics & Reporting', 6, 'yt:l2m3n4o5p4', 5400, false, NOW(), NOW());

-- Course 24: Creative Writing
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(24, 'Finding Inspiration', 1, 'yt:m2n3o4p5q5', 1800, true, NOW(), NOW()),
(24, 'Character Development', 2, 'yt:n2o3p4q5r6', 2400, false, NOW(), NOW()),
(24, 'Plot Structure', 3, 'yt:o2p3q4r5s7', 2700, false, NOW(), NOW()),
(24, 'Dialogue Writing', 4, 'yt:p2q3r4s5t8', 3600, false, NOW(), NOW()),
(24, 'Setting & Atmosphere', 5, 'yt:q2r3s4t5u9', 4200, false, NOW(), NOW()),
(24, 'Editing & Revision', 6, 'yt:r2s3t4u5v0', 2100, false, NOW(), NOW());

-- Course 25: PMP
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(25, 'Project Lifecycle', 1, 'yt:s2t3u4v5w1', 2100, true, NOW(), NOW()),
(25, 'Scope Management', 2, 'yt:t2u3v4w5x2', 3000, false, NOW(), NOW()),
(25, 'Schedule Management', 3, 'yt:u2v3w4x5y3', 3600, false, NOW(), NOW()),
(25, 'Cost Management', 4, 'yt:v2w3x4y5z4', 2700, false, NOW(), NOW()),
(25, 'Risk Management', 5, 'yt:w2x3y4z5a5', 4500, false, NOW(), NOW()),
(25, 'Agile Methodologies', 6, 'yt:x2y3z4a5b6', 5400, false, NOW(), NOW());

-- Course 26: UI/UX
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(26, 'Design Thinking', 1, 'yt:y2z3a4b5c7', 2400, true, NOW(), NOW()),
(26, 'Wireframing', 2, 'yt:z2a3b4c5d8', 3000, false, NOW(), NOW()),
(26, 'Prototyping in Figma', 3, 'yt:a3b4c5d6e9', 2700, false, NOW(), NOW()),
(26, 'Color Theory', 4, 'yt:b3c4d5e6f0', 3600, false, NOW(), NOW()),
(26, 'Typography', 5, 'yt:c3d4e5f6g1', 4200, false, NOW(), NOW()),
(26, 'Usability Testing', 6, 'yt:d3e4f5g6h2', 5400, false, NOW(), NOW());

-- Course 27: Photography
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(27, 'Camera Settings (ISO, Aperture)', 1, 'yt:e3f4g5h6i3', 1800, true, NOW(), NOW()),
(27, 'Composition Rules', 2, 'yt:f3g4h5i6j4', 2100, false, NOW(), NOW()),
(27, 'Lighting Techniques', 3, 'yt:g3h4i5j6k5', 2400, false, NOW(), NOW()),
(27, 'Portrait Photography', 4, 'yt:h3i4j5k6l6', 2700, false, NOW(), NOW()),
(27, 'Landscape Photography', 5, 'yt:i3j4k5l6m7', 3000, false, NOW(), NOW()),
(27, 'Photo Editing (Lightroom)', 6, 'yt:j3k4l5m6n8', 3300, false, NOW(), NOW());

-- Course 28: Premiere
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(28, 'Interface Overview', 1, 'yt:k3l4m5n6o9', 2400, true, NOW(), NOW()),
(28, 'Importing & Organizing', 2, 'yt:l3m4n5o6p0', 3000, false, NOW(), NOW()),
(28, 'Basic Cutting & Trimming', 3, 'yt:m3n4o5p6q1', 2700, false, NOW(), NOW()),
(28, 'Transitions & Effects', 4, 'yt:n3o4p5q6r2', 3600, false, NOW(), NOW()),
(28, 'Audio Mixing', 5, 'yt:o3p4q5r6s3', 4200, false, NOW(), NOW()),
(28, 'Color Correction', 6, 'yt:p3q4r5s6t4', 5400, false, NOW(), NOW());

-- Course 29: Photoshop & AI
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(29, 'Layers & Masks', 1, 'yt:q3r4s5t6u5', 1800, true, NOW(), NOW()),
(29, 'Selection Tools', 2, 'yt:r3s4t5u6v6', 2400, false, NOW(), NOW()),
(29, 'Retouching', 3, 'yt:s3t4u5v6w7', 2700, false, NOW(), NOW()),
(29, 'Pen Tool Mastery', 4, 'yt:t3u4v5w6x8', 3600, false, NOW(), NOW()),
(29, 'Vector Graphics', 5, 'yt:u3v4w5x6y9', 4200, false, NOW(), NOW()),
(29, 'Logo Design', 6, 'yt:v3w4x5y6z0', 2100, false, NOW(), NOW());

-- Course 30: Digital Art
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(30, 'Brush Settings', 1, 'yt:w3x4y5z6a1', 2100, true, NOW(), NOW()),
(30, 'Sketching Techniques', 2, 'yt:x3y4z5a6b2', 3000, false, NOW(), NOW()),
(30, 'Line Art', 3, 'yt:y3z4a5b6c3', 3600, false, NOW(), NOW()),
(30, 'Coloring & Shading', 4, 'yt:z3a4b5c6d4', 2700, false, NOW(), NOW()),
(30, 'Lighting & Rendering', 5, 'yt:a4b5c6d7e5', 4500, false, NOW(), NOW()),
(30, 'Perspective', 6, 'yt:b4c5d6e7f6', 5400, false, NOW(), NOW());

-- Course 31: Spring Boot Adv
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(31, 'Spring Security OAuth2', 1, 'yt:c4d5e6f7g7', 2400, true, NOW(), NOW()),
(31, 'Microservices Patterns', 2, 'yt:d4e5f6g7h8', 3000, false, NOW(), NOW()),
(31, 'Service Discovery (Eureka)', 3, 'yt:e4f5g6h7i9', 2700, false, NOW(), NOW()),
(31, 'API Gateway', 4, 'yt:f4g5h6i7j0', 3600, false, NOW(), NOW()),
(31, 'Event-Driven Architecture', 5, 'yt:g4h5i6j7k1', 4200, false, NOW(), NOW()),
(31, 'Distributed Tracing', 6, 'yt:h4i5j6k7l2', 5400, false, NOW(), NOW());

-- Course 32: Vue.js 3
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(32, 'Options vs Composition API', 1, 'yt:i4j5k6l7m3', 1800, true, NOW(), NOW()),
(32, 'Vue CLI & Vite', 2, 'yt:j4k5l6m7n4', 2100, false, NOW(), NOW()),
(32, 'Components & Props', 3, 'yt:k4l5m6n7o5', 2400, false, NOW(), NOW()),
(32, 'Vue Router', 4, 'yt:l4m5n6o7p6', 2700, false, NOW(), NOW()),
(32, 'State Management (Pinia)', 5, 'yt:m4n5o6p7q7', 3000, false, NOW(), NOW()),
(32, 'Unit Testing', 6, 'yt:n4o5p6q7r8', 3300, false, NOW(), NOW());

-- Course 33: Angular
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(33, 'Modules & Components', 1, 'yt:o4p5q6r7s9', 2400, true, NOW(), NOW()),
(33, 'Data Binding', 2, 'yt:p4q5r6s7t0', 3000, false, NOW(), NOW()),
(33, 'Directives & Pipes', 3, 'yt:q4r5s6t7u1', 2700, false, NOW(), NOW()),
(33, 'Services & DI', 4, 'yt:r4s5t6u7v2', 3600, false, NOW(), NOW()),
(33, 'Routing & Navigation', 5, 'yt:s4t5u6v7w3', 4200, false, NOW(), NOW()),
(33, 'HTTP Client & Observables', 6, 'yt:t4u5v6w7x4', 5400, false, NOW(), NOW());

-- Course 34: TypeScript
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(34, 'Basic Types', 1, 'yt:u4v5w6x7y5', 1800, true, NOW(), NOW()),
(34, 'Interfaces & Types', 2, 'yt:v4w5x6y7z6', 2400, false, NOW(), NOW()),
(34, 'Classes & Inheritance', 3, 'yt:w4x5y6z7a7', 2700, false, NOW(), NOW()),
(34, 'Generics', 4, 'yt:x4y5z6a7b8', 3600, false, NOW(), NOW()),
(34, 'Modules & Namespaces', 5, 'yt:y4z5a6b7c9', 4200, false, NOW(), NOW()),
(34, 'Decorators', 6, 'yt:z4a5b6c7d0', 2100, false, NOW(), NOW());

-- Course 35: Next.js
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(35, 'Pages & Routing', 1, 'yt:a5b6c7d8e1', 2100, true, NOW(), NOW()),
(35, 'GetStaticProps (SSG)', 2, 'yt:b5c6d7e8f2', 3000, false, NOW(), NOW()),
(35, 'GetServerSideProps (SSR)', 3, 'yt:c5d6e7f8g3', 3600, false, NOW(), NOW()),
(35, 'API Routes', 4, 'yt:d5e6f7g8h4', 2700, false, NOW(), NOW()),
(35, 'Image Optimization', 5, 'yt:e5f6g7h8i5', 4500, false, NOW(), NOW()),
(35, 'Deployment to Vercel', 6, 'yt:f5g6h7i8j6', 5400, false, NOW(), NOW());

-- Course 36: PostgreSQL
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(36, 'Installation & Config', 1, 'yt:g5h6i7j8k7', 2400, true, NOW(), NOW()),
(36, 'SQL Advanced Queries', 2, 'yt:h5i6j7k8l8', 3000, false, NOW(), NOW()),
(36, 'Indexing & Performance', 3, 'yt:i5j6k7l8m9', 2700, false, NOW(), NOW()),
(36, 'Stored Procedures', 4, 'yt:j5k6l7m8n0', 3600, false, NOW(), NOW()),
(36, 'Transactions & Locks', 5, 'yt:k5l6m7n8o1', 4200, false, NOW(), NOW()),
(36, 'Backup & Recovery', 6, 'yt:l5m6n7o8p2', 5400, false, NOW(), NOW());

-- Course 37: Redis
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(37, 'Data Structures', 1, 'yt:m5n6o7p8q3', 1800, true, NOW(), NOW()),
(37, 'Caching Strategies', 2, 'yt:n5o6p7q8r4', 2100, false, NOW(), NOW()),
(37, 'Pub/Sub Messaging', 3, 'yt:o5p6q7r8s5', 2400, false, NOW(), NOW()),
(37, 'Redis Persistence', 4, 'yt:p5q6r7s8t6', 2700, false, NOW(), NOW()),
(37, 'Redis Cluster', 5, 'yt:q5r6s7t8u7', 3000, false, NOW(), NOW()),
(37, 'Using Redis with Node.js', 6, 'yt:r5s6t7u8v8', 3300, false, NOW(), NOW());

-- Course 38: Elasticsearch
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(38, 'Architecture Overview', 1, 'yt:s5t6u7v8w9', 2400, true, NOW(), NOW()),
(38, 'Indexing Documents', 2, 'yt:t5u6v7w8x0', 3000, false, NOW(), NOW()),
(38, 'Search Queries (DSL)', 3, 'yt:u5v6w7x8y1', 2700, false, NOW(), NOW()),
(38, 'Aggregations', 4, 'yt:v5w6x7y8z2', 3600, false, NOW(), NOW()),
(38, 'Analyzers', 5, 'yt:w5x6y7z8a3', 4200, false, NOW(), NOW()),
(38, 'ELK Stack Integration', 6, 'yt:x5y6z7a8b4', 5400, false, NOW(), NOW());

-- Course 39: Golang
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(39, 'Go Syntax Basics', 1, 'yt:y5z6a7b8c5', 1800, true, NOW(), NOW()),
(39, 'Pointers & Structs', 2, 'yt:z5a6b7c8d6', 2400, false, NOW(), NOW()),
(39, 'Interfaces', 3, 'yt:a6b7c8d9e7', 2700, false, NOW(), NOW()),
(39, 'Goroutines & Channels', 4, 'yt:b6c7d8e9f8', 3600, false, NOW(), NOW()),
(39, 'Error Handling', 5, 'yt:c6d7e8f9g9', 4200, false, NOW(), NOW()),
(39, 'Building a Web Server', 6, 'yt:d6e7f8g9h0', 2100, false, NOW(), NOW());

-- Course 40: System Design
INSERT INTO video_lessons (course_id, title, order_index, s3_key, duration_sec, free_preview, created_at, updated_at) VALUES
(40, 'Scalability Basics', 1, 'yt:e6f7g8h9i1', 2100, true, NOW(), NOW()),
(40, 'Load Balancing', 2, 'yt:f6g7h8i9j2', 3000, false, NOW(), NOW()),
(40, 'Caching', 3, 'yt:g6h7i8j9k3', 3600, false, NOW(), NOW()),
(40, 'Database Sharding', 4, 'yt:h6i7j8k9l4', 2700, false, NOW(), NOW()),
(40, 'Message Queues', 5, 'yt:i6j7k8l9m5', 4500, false, NOW(), NOW()),
(40, 'Design Instagram', 6, 'yt:j6k7l8m9n6', 5400, false, NOW(), NOW());


-- 6. INSERT ENROLLMENTS
-- =========================
-- Check if User 3 exists before inserting enrollments (Optional safety)
-- But standard SQL doesn't support IF easily in scripts without stored procs.
-- We assume User 3 exists because we are not deleting users.

INSERT INTO enrollments (user_id, course_id, status, created_at, updated_at) VALUES
(3, 1, 'ACTIVE', NOW(), NOW()), -- Free Java
(3, 6, 'ACTIVE', NOW(), NOW()); -- Paid Java (Expensive now!)

-- 7. INSERT ORDERS
-- =========================
INSERT INTO orders (user_id, course_id, status, total_amount_cents, currency, created_at, updated_at) VALUES
(3, 6, 'PAID', 129900000, 'VND', NOW(), NOW());

INSERT INTO order_items (order_id, course_id, unit_price_cents, quantity, title_snapshot, created_at, updated_at) VALUES
(1, 6, 129900000, 1, 'Java Masterclass: Từ Zero đến Hero', NOW(), NOW());


SET FOREIGN_KEY_CHECKS = 1;
SET SQL_SAFE_UPDATES = 1; -- Re-enable safe updates
