
-- ======================
-- 1. INSERT INTO Tracks
-- ======================


INSERT INTO Tracks (Track_ID, Track_Name, InstructorID)
VALUES
(1, 'Data Science', 23),
(2, 'Web Development', 87),
(3, 'Cyber Security', 14),
(4, 'AI & Machine Learning', 55),
(5, 'Mobile App Development', 68),
(6, 'Cloud Computing', 9),
(7, 'DevOps', 41),
(8, 'Embedded Systems', 76),
(9, 'Big Data', 12),
(10, 'Software Testing', 33),
(11, 'Game Development', 97),
(12, 'UI/UX Design', 5),
(13, 'IT Infrastructure', 61),
(14, 'Data Analysis', 38),
(15, 'Blockchain', 80);

-- =======================
-- 2. INSERT INTO Courses
-- =======================
INSERT INTO Courses (Course_ID, Course_Name, C_Status, C_Duration)
VALUES
(1, 'Python for Data Analysis', 'Active', '40 Hours'),
(2, 'SQL & Databases', 'Completed', '30 Hours'),
(3, 'Statistics Fundamentals', 'Active', '35 Hours'),
(4, 'Data Visualization', 'Upcoming', '25 Hours'),
(5, 'HTML & CSS', 'Active', '25 Hours'),
(6, 'JavaScript Basics', 'Completed', '35 Hours'),
(7, 'React.js', 'Upcoming', '40 Hours'),
(8, 'Node.js', 'Active', '30 Hours'),
(9, 'Network Security', 'Active', '40 Hours'),
(10, 'Ethical Hacking', 'Active', '35 Hours'),
(11, 'Cryptography Basics', 'Upcoming', '30 Hours'),
(12, 'Cyber Laws', 'Completed', '20 Hours'),
(13, 'ML Fundamentals', 'Active', '40 Hours'),
(14, 'Deep Learning', 'Upcoming', '35 Hours'),
(15, 'TensorFlow Intro', 'Active', '30 Hours'),
(16, 'AI Ethics', 'Completed', '20 Hours'),
(17, 'Android Basics', 'Active', '40 Hours'),
(18, 'iOS Development', 'Completed', '35 Hours'),
(19, 'Flutter Framework', 'Upcoming', '30 Hours'),
(20, 'Mobile UI Design', 'Active', '25 Hours'),
(21, 'Cloud Fundamentals', 'Active', '35 Hours'),
(22, 'AWS Basics', 'Completed', '30 Hours'),
(23, 'Azure Essentials', 'Active', '30 Hours'),
(24, 'DevOps on Cloud', 'Upcoming', '25 Hours'),
(25, 'CI/CD Concepts', 'Active', '30 Hours'),
(26, 'Docker Basics', 'Active', '35 Hours'),
(27, 'Kubernetes Intro', 'Upcoming', '40 Hours'),
(28, 'Monitoring Tools', 'Completed', '20 Hours'),
(29, 'C for Embedded', 'Active', '40 Hours'),
(30, 'Microcontrollers', 'Completed', '35 Hours'),
(31, 'RTOS Concepts', 'Upcoming', '30 Hours'),
(32, 'IOT Integration', 'Active', '25 Hours'),
(33, 'Big Data Basics', 'Active', '30 Hours'),
(34, 'Hadoop Framework', 'Completed', '35 Hours'),
(35, 'Spark with Scala', 'Upcoming', '40 Hours'),
(36, 'Data Lakes', 'Active', '25 Hours'),
(37, 'Manual Testing', 'Active', '30 Hours'),
(38, 'Automation Testing', 'Completed', '35 Hours'),
(39, 'Selenium WebDriver', 'Active', '30 Hours'),
(40, 'Test Management', 'Upcoming', '20 Hours'),
(41, 'Game Design Basics', 'Active', '35 Hours'),
(42, 'Unity Engine', 'Completed', '40 Hours'),
(43, 'C# for Games', 'Upcoming', '30 Hours'),
(44, '2D & 3D Graphics', 'Active', '25 Hours'),
(45, 'Design Principles', 'Active', '30 Hours'),
(46, 'Wireframing Tools', 'Completed', '25 Hours'),
(47, 'Prototyping', 'Active', '30 Hours'),
(48, 'UX Research', 'Upcoming', '20 Hours'),
(49, 'Operating Systems', 'Active', '35 Hours'),
(50, 'Networking Basics', 'Completed', '30 Hours'),
(51, 'Virtualization', 'Upcoming', '30 Hours'),
(52, 'Storage Systems', 'Active', '25 Hours'),
(53, 'Excel for Analysis', 'Active', '25 Hours'),
(54, 'Power BI', 'Completed', '30 Hours'),
(55, 'Data Cleaning', 'Upcoming', '30 Hours'),
(56, 'Storytelling with Data', 'Active', '20 Hours'),
(57, 'Blockchain Basics', 'Active', '30 Hours'),
(58, 'Ethereum & Solidity', 'Completed', '35 Hours'),
(59, 'Smart Contracts', 'Upcoming', '30 Hours'),
(60, 'Blockchain Use Cases', 'Active', '25 Hours');


-- ======================
-- 3. INSERT INTO Topics
-- ======================

INSERT INTO Topics (Topic_ID, Topic_Name, Course_ID)
VALUES
-- Course 1
(1, 'Numpy Basics', 1),
(2, 'Pandas Intro', 1),
(3, 'Data Wrangling', 1),
(4, 'Matplotlib', 1),

-- Course 2
(5, 'SQL Joins', 2),
(6, 'Subqueries', 2),
(7, 'Views', 2),
(8, 'Transactions', 2),

-- Course 3
(9, 'Descriptive Stats', 3),
(10, 'Probability', 3),
(11, 'Distributions', 3),
(12, 'Hypothesis Testing', 3),

-- Course 4
(13, 'Bar Charts', 4),
(14, 'Line Charts', 4),
(15, 'Dashboards', 4),
(16, 'Power BI Basics', 4),

-- Track 2: Web Development (Courses 5-8)
(17, 'HTML Basics', 5),
(18, 'CSS Styling', 5),
(19, 'Forms & Tables', 5),
(20, 'Responsive Design', 5),

(21, 'JS Variables', 6),
(22, 'Loops & Conditions', 6),
(23, 'DOM Manipulation', 6),
(24, 'Events', 6),

(25, 'React Components', 7),
(26, 'JSX Syntax', 7),
(27, 'Hooks', 7),
(28, 'Routing', 7),

(29, 'Node.js Basics', 8),
(30, 'Express Framework', 8),
(31, 'APIs & Routing', 8),
(32, 'Middleware', 8),

-- Track 3: Cyber Security (Courses 9–12)
(33, 'Network Layers', 9),
(34, 'Firewalls', 9),
(35, 'IDS & IPS', 9),
(36, 'VPNs', 9),

(37, 'Footprinting', 10),
(38, 'Scanning', 10),
(39, 'Exploitation', 10),
(40, 'Post Exploitation', 10),

(41, 'Encryption Types', 11),
(42, 'Hash Functions', 11),
(43, 'PKI Concepts', 11),
(44, 'SSL/TLS', 11),

(45, 'Cybercrime Types', 12),
(46, 'Digital Evidence', 12),
(47, 'Legal Frameworks', 12),
(48, 'Data Protection', 12),

-- Track 4: AI & ML (Courses 13–16)
(49, 'Supervised Learning', 13),
(50, 'Unsupervised Learning', 13),
(51, 'Model Evaluation', 13),
(52, 'Overfitting', 13),

(53, 'Neural Networks', 14),
(54, 'CNNs', 14),
(55, 'RNNs', 14),
(56, 'Transfer Learning', 14),

(57, 'Tensors', 15),
(58, 'Keras Models', 15),
(59, 'Model Training', 15),
(60, 'Saving Models', 15),

(61, 'Bias in AI', 16),
(62, 'Fairness', 16),
(63, 'Regulations', 16),
(64, 'Explainability', 16),

-- Track 5: Mobile App (Courses 17–20)
(65, 'Android Studio', 17),
(66, 'Activities & Layouts', 17),
(67, 'Intents', 17),
(68, 'Permissions', 17),

(69, 'Xcode Basics', 18),
(70, 'Swift Syntax', 18),
(71, 'Storyboards', 18),
(72, 'View Controllers', 18),

(73, 'Flutter Setup', 19),
(74, 'Widgets', 19),
(75, 'State Management', 19),
(76, 'Navigation', 19),

(77, 'Mobile UX', 20),
(78, 'Color Schemes', 20),
(79, 'User Testing', 20),
(80, 'Prototyping', 20),

-- Track 6: Cloud Computing (Courses 21–24)
(81, 'Cloud Types', 21),
(82, 'Benefits', 21),
(83, 'Security', 21),
(84, 'SLA Concepts', 21),

(85, 'IAM', 22),
(86, 'EC2 Instances', 22),
(87, 'S3 Buckets', 22),
(88, 'Lambda Functions', 22),

(89, 'Azure VMs', 23),
(90, 'Blob Storage', 23),
(91, 'Functions App', 23),
(92, 'Resource Groups', 23),

(93, 'CI/CD on Cloud', 24),
(94, 'Monitoring', 24),
(95, 'Cloud DevOps Tools', 24),
(96, 'Pipelines', 24),

-- Track 7: DevOps (Courses 25–28)
(97, 'DevOps Lifecycle', 25),
(98, 'Version Control', 25),
(99, 'Continuous Integration', 25),
(100, 'Continuous Delivery', 25),

(101, 'Containers', 26),
(102, 'Docker CLI', 26),
(103, 'Docker Compose', 26),
(104, 'Images & Volumes', 26),

(105, 'Kubernetes Basics', 27),
(106, 'Pods & Services', 27),
(107, 'Deployments', 27),
(108, 'Helm Charts', 27),

(109, 'Grafana', 28),
(110, 'Prometheus', 28),
(111, 'Logging', 28),
(112, 'Alerts', 28),

-- Track 8: Embedded (Courses 29–32)
(113, 'Embedded C', 29),
(114, 'Bitwise Ops', 29),
(115, 'Timers & Counters', 29),
(116, 'GPIO', 29),

(117, 'AVR Architecture', 30),
(118, 'PIC Microcontrollers', 30),
(119, 'Power Management', 30),
(120, 'Peripheral Control', 30),

(121, 'Tasks & Threads', 31),
(122, 'RTOS Scheduling', 31),
(123, 'Semaphores', 31),
(124, 'Interrupts', 31),

(125, 'IoT Devices', 32),
(126, 'MQTT', 32),
(127, 'Sensors', 32),
(128, 'Cloud Connectivity', 32),

-- Track 9: Big Data (Courses 33–36)
(129, 'Big Data Ecosystem', 33),
(130, 'Data Ingestion', 33),
(131, 'Storage Systems', 33),
(132, 'Processing Layers', 33),

(133, 'HDFS', 34),
(134, 'MapReduce', 34),
(135, 'YARN', 34),
(136, 'Hive', 34),

(137, 'Spark Core', 35),
(138, 'RDDs', 35),
(139, 'SparkSQL', 35),
(140, 'Spark MLlib', 35),

(141, 'Data Lakes', 36),
(142, 'Delta Lake', 36),
(143, 'ETL Pipelines', 36),
(144, 'Governance', 36),

-- Track 10: Testing (Courses 37–40)
(145, 'Test Cases', 37),
(146, 'Bug Lifecycle', 37),
(147, 'Test Levels', 37),
(148, 'Test Types', 37),

(149, 'Automation Tools', 38),
(150, 'Scripting', 38),
(151, 'Frameworks', 38),
(152, 'Reporting', 38),

(153, 'Selenium Setup', 39),
(154, 'Locators', 39),
(155, 'WebDriver API', 39),
(156, 'TestNG', 39),

(157, 'Test Planning', 40),
(158, 'Test Strategy', 40),
(159, 'Test Execution', 40),
(160, 'Defect Tracking', 40),

-- Track 11: Game Dev (Courses 41–44)
(161, 'Game Genres', 41),
(162, 'Storyboarding', 41),
(163, 'Level Design', 41),
(164, 'User Flow', 41),

(165, 'Unity Setup', 42),
(166, 'Scenes & Assets', 42),
(167, 'Animations', 42),
(168, 'Physics Engine', 42),

(169, 'C# Basics', 43),
(170, 'Input Handling', 43),
(171, 'Scripting Events', 43),
(172, 'Coroutines', 43),

(173, '2D Graphics', 44),
(174, '3D Rendering', 44),
(175, 'Shaders', 44),
(176, 'Textures', 44),

-- Track 12: UI/UX (Courses 45–48)
(177, 'Design Basics', 45),
(178, 'Colors & Fonts', 45),
(179, 'Layouts', 45),
(180, 'Accessibility', 45),

(181, 'Wireframe Tools', 46),
(182, 'Low-Fidelity', 46),
(183, 'High-Fidelity', 46),
(184, 'Interaction Flow', 46),

(185, 'Figma Prototypes', 47),
(186, 'User Testing', 47),
(187, 'Feedback Cycles', 47),
(188, 'Refinements', 47),

(189, 'User Surveys', 48),
(190, 'Personas', 48),
(191, 'Journey Maps', 48),
(192, 'UX Metrics', 48),

-- Track 13: IT Infra (Courses 49–52)
(193, 'OS Functions', 49),
(194, 'Memory Management', 49),
(195, 'Processes', 49),
(196, 'File Systems', 49),

(197, 'TCP/IP Model', 50),
(198, 'IP Addressing', 50),
(199, 'Subnetting', 50),
(200, 'Routing', 50),

(201, 'Hypervisors', 51),
(202, 'VM Management', 51),
(203, 'Snapshots', 51),
(204, 'Cloud Integration', 51),

(205, 'SAN vs NAS', 52),
(206, 'RAID Levels', 52),
(207, 'Backup Methods', 52),
(208, 'Disaster Recovery', 52),

-- Track 14: Data Analysis (Courses 53–56)
(209, 'Excel Functions', 53),
(210, 'Pivot Tables', 53),
(211, 'Data Filtering', 53),
(212, 'Charts', 53),

(213, 'Power Query', 54),
(214, 'DAX Formulas', 54),
(215, 'Relationships', 54),
(216, 'Publishing', 54),

(217, 'Cleaning Steps', 55),
(218, 'Outliers', 55),
(219, 'Null Handling', 55),
(220, 'Standardization', 55),

(221, 'Effective Charts', 56),
(222, 'Storytelling', 56),
(223, 'Audience Focus', 56),
(224, 'Presentation', 56),

-- Track 15: Blockchain (Courses 57–60)
(225, 'Blockchain Structure', 57),
(226, 'Consensus Mechanisms', 57),
(227, 'Hashing', 57),
(228, 'Blocks & Chains', 57),

(229, 'Ethereum Intro', 58),
(230, 'Solidity Basics', 58),
(231, 'Smart Contracts', 58),
(232, 'Remix IDE', 58),

(233, 'Contract Deployment', 59),
(234, 'Web3.js', 59),
(235, 'Interacting with Contracts', 59),
(236, 'Security Concerns', 59),

(237, 'Supply Chain Example', 60),
(238, 'Healthcare Example', 60),
(239, 'Voting System', 60),
(240, 'NFTs & Tokens', 60);

;


-- ================================
-- 4. INSERT INTO Track-Courses
-- ================================
INSERT INTO [Track_couseurs] (Track_ID, Course_ID)
VALUES
(1, 1), (1, 2), (1, 3), (1, 4),
(2, 5), (2, 6), (2, 7), (2, 8),
(3, 9), (3, 10), (3, 11), (3, 12),
(4, 13), (4, 14), (4, 15), (4, 16),
(5, 17), (5, 18), (5, 19), (5, 20),
(6, 21), (6, 22), (6, 23), (6, 24),
(7, 25), (7, 26), (7, 27), (7, 28),
(8, 29), (8, 30), (8, 31), (8, 32),
(9, 33), (9, 34), (9, 35), (9, 36),
(10, 37), (10, 38), (10, 39), (10, 40),
(11, 41), (11, 42), (11, 43), (11, 44),
(12, 45), (12, 46), (12, 47), (12, 48),
(13, 49), (13, 50), (13, 51), (13, 52),
(14, 53), (14, 54), (14, 55), (14, 56),
(15, 57), (15, 58), (15, 59), (15, 60);
