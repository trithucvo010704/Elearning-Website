-- =============================================
-- UPDATE COURSE THUMBNAILS WITH RELEVANT IMAGES
-- This file updates all course thumbnails with real images
-- relevant to each course topic from Unsplash
-- =============================================

SET FOREIGN_KEY_CHECKS = 0;

-- Programming & Development Courses
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1516116216624-53e697fedbea?w=800&h=450&fit=crop' WHERE id = 1; -- Java
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=800&h=450&fit=crop' WHERE id = 2; -- Python
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1579468118864-1b9ea3c0db4a?w=800&h=450&fit=crop' WHERE id = 3; -- JavaScript
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=800&h=450&fit=crop' WHERE id = 31; -- Spring Boot
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1579468118864-1b9ea3c0db4a?w=800&h=450&fit=crop' WHERE id = 32; -- Vue.js
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=800&h=450&fit=crop' WHERE id = 33; -- Angular
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1516116216624-53e697fedbea?w=800&h=450&fit=crop' WHERE id = 34; -- TypeScript
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=800&h=450&fit=crop' WHERE id = 35; -- Next.js
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1544383835-bda2bc66a55d?w=800&h=450&fit=crop' WHERE id = 36; -- PostgreSQL
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=800&h=450&fit=crop' WHERE id = 37; -- Redis
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=800&h=450&fit=crop' WHERE id = 38; -- Elasticsearch
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&h=450&fit=crop' WHERE id = 39; -- Microservices
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1605745341112-85968b19335b?w=800&h=450&fit=crop' WHERE id = 40; -- DevOps

-- Language Courses
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1528164344705-47542687000d?w=800&h=450&fit=crop' WHERE id = 4; -- Japanese Beginner
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1493809842364-78817add7ffb?w=800&h=450&fit=crop' WHERE id = 5; -- Japanese Advanced
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1528164344705-47542687000d?w=800&h=450&fit=crop' WHERE id = 8; -- Korean
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=800&h=450&fit=crop' WHERE id = 9; -- Chinese
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1528164344705-47542687000d?w=800&h=450&fit=crop' WHERE id = 10; -- French
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1533450718592-29d45635f0a9?w=800&h=450&fit=crop' WHERE id = 28; -- Spanish
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1528164344705-47542687000d?w=800&h=450&fit=crop' WHERE id = 29; -- German
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1515542622106-78bda8ba0e5b?w=800&h=450&fit=crop' WHERE id = 30; -- Italian
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=800&h=450&fit=crop' WHERE id = 30; -- Portuguese

-- Business & Professional Courses
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1552664730-d307ca884978?w=800&h=450&fit=crop' WHERE id = 6; -- English Business
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?w=800&h=450&fit=crop' WHERE id = 7; -- IELTS
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800&h=450&fit=crop' WHERE id = 11; -- Digital Marketing
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=800&h=450&fit=crop' WHERE id = 12; -- PMP
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800&h=450&fit=crop' WHERE id = 24; -- Leadership
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1543269865-cbf427effbad?w=800&h=450&fit=crop' WHERE id = 25; -- Public Speaking
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?w=800&h=450&fit=crop' WHERE id = 23; -- Finance

-- Design & Creative Courses
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1561070791-2526d30994b5?w=800&h=450&fit=crop' WHERE id = 13; -- UI/UX
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=800&h=450&fit=crop' WHERE id = 21; -- Photography
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1533750516457-a7f992034fec?w=800&h=450&fit=crop' WHERE id = 22; -- Video Editing
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1455390582262-044cdead277a?w=800&h=450&fit=crop' WHERE id = 27; -- Creative Writing

-- Technology & Cloud Courses
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=800&h=450&fit=crop' WHERE id = 14; -- Cybersecurity
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&h=450&fit=crop' WHERE id = 15; -- AWS
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=800&h=450&fit=crop' WHERE id = 16; -- React Native
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1527477396000-e27163b481c2?w=800&h=450&fit=crop' WHERE id = 17; -- Machine Learning
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1605745341112-85968b19335b?w=800&h=450&fit=crop' WHERE id = 18; -- Docker
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=800&h=450&fit=crop' WHERE id = 19; -- GraphQL
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1639762681485-074b7f938ba0?w=800&h=450&fit=crop' WHERE id = 20; -- Blockchain

-- Personal Development Courses
UPDATE courses SET thumbnail_url = 'https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b?w=800&h=450&fit=crop' WHERE id = 26; -- Time Management

SET FOREIGN_KEY_CHECKS = 1;

-- =============================================
-- UPDATE COMPLETED
-- All course thumbnails updated with relevant images
-- =============================================

