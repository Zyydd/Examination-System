use [graduation project]
-- Delete all existing records from the exams table
DELETE FROM Exam;




-- Insert corrected exam data with past dates and full marks as multiples of 5
INSERT INTO Exam (Exam_ID, Exam_Name, Exam_Duration, Exam_Date, Exam_Mark) VALUES
(1, 'hamo', '90 Minutes', '2024-01-10', 100.00),
(2, 'Midterm - Advanced Python', '60 Minutes', '2024-02-15', 80.00),
(3, 'Quiz 1 - Database Management', '30 Minutes', '2024-03-01', 50.00),
(4, 'Certification Prep - Web Development Fundamentals', '120 Minutes', '2024-04-20', 95.00),
(5, 'Practical Exam - Machine Learning Basics', '180 Minutes', '2024-05-25', 100.00),
(6, 'Deep Learning Module 1 Test', '75 Minutes', '2024-01-20', 75.00),
(7, 'Data Visualization Skills Assessment', '45 Minutes', '2024-02-05', 60.00),
(8, 'Big Data Fundamentals Exam', '90 Minutes', '2024-03-10', 85.00),
(9, 'Network Security Final', '100 Minutes', '2024-04-15', 90.00),
(10, 'Ethical Hacking Practice Exam', '150 Minutes', '2024-05-01', 90.00),
(11, 'Cloud Infrastructure Basics', '60 Minutes', '2024-06-01', 70.00),
(12, 'DevOps Principles Quiz', '40 Minutes', '2023-07-05', 55.00),
(13, 'SEO Certification Exam', '120 Minutes', '2023-08-10', 100.00),
(14, 'Social Media Marketing Capstone', '90 Minutes', '2023-09-15', 90.00),
(15, 'Content Creation Exam', '70 Minutes', '2023-10-01', 80.00),
(16, 'Email Marketing Fundamentals', '60 Minutes', '2023-11-05', 70.00),
(17, 'Operating Systems Midterm', '80 Minutes', '2023-12-10', 85.00),
(18, 'Algorithms Challenge', '120 Minutes', '2024-01-15', 90.00),
(19, 'Software Engineering Case Study', '180 Minutes', '2024-02-20', 95.00),
(20, 'Mobile App Development Final Project', '180 Minutes', '2024-03-01', 100.00),
(21, 'Python Unit Testing Quiz', '30 Minutes', '2024-01-25', 45.00),
(22, 'SQL Advanced Queries Exam', '70 Minutes', '2024-03-05', 90.00),
(23, 'Frontend Development Quiz', '45 Minutes', '2024-04-01', 70.00),
(24, 'Data Preprocessing Techniques Exam', '60 Minutes', '2024-05-10', 80.00),
(25, 'Reinforcement Learning Introduction', '90 Minutes', '2024-06-05', 80.00),
(26, 'Visualization Tools Exam', '50 Minutes', '2023-07-01', 65.00),
(27, 'Hadoop Ecosystem Quiz', '60 Minutes', '2023-08-05', 75.00),
(28, 'Penetration Testing Methodology', '120 Minutes', '2023-09-10', 90.00),
(29, 'Cloud Security Best Practices', '80 Minutes', '2023-10-15', 85.00),
(30, 'Kubernetes Fundamentals', '70 Minutes', '2023-11-01', 80.00),
(31, 'Technical SEO Audit Exam', '90 Minutes', '2023-12-05', 90.00),
(32, 'Social Media Advertising Strategies', '60 Minutes', '2024-01-01', 85.00),
(33, 'Copywriting for Digital Media', '50 Minutes', '2024-02-05', 80.00),
(34, 'Email Automation Exam', '70 Minutes', '2024-03-10', 90.00),
(35, 'Operating Systems Processes', '60 Minutes', '2024-04-15', 75.00),
(36, 'Data Structures Midterm', '90 Minutes', '2024-05-01', 90.00),
(37, 'Software Testing Methodologies', '80 Minutes', '2024-06-05', 80.00),
(38, 'Mobile UI/UX Design Exam', '100 Minutes', '2023-07-10', 95.00),
(39, 'Python Fundamentals Quiz', '30 Minutes', '2024-01-18', 65.00),
(40, 'SQL Joins & Subqueries', '60 Minutes', '2024-02-28', 75.00),
(41, 'HTML & CSS Basics', '40 Minutes', '2024-03-15', 80.00),
(42, 'Machine Learning Algorithms', '90 Minutes', '2024-04-05', 90.00),
(43, 'Cybersecurity Threats', '70 Minutes', '2024-05-12', 85.00),
(44, 'Cloud Deployment Models', '50 Minutes', '2024-06-20', 70.00),
(45, 'DevOps Tools & Technologies', '80 Minutes', '2023-07-25', 90.00),
(46, 'Content Marketing Strategy', '60 Minutes', '2023-08-30', 90.00),
(47, 'Operating System Security', '70 Minutes', '2023-09-10', 80.00),
(48, 'Algorithm Complexity', '60 Minutes', '2023-10-01', 95.00),
(49, 'Software Design Patterns', '90 Minutes', '2023-11-05', 90.00),
(50, 'Mobile Development Frameworks', '75 Minutes', '2023-12-15', 85.00);

SELECT * from Exam

SELECT * from feedback

-- =================================================================
-- =================================================================
TRUNCATE TABLE [dbo].[Feedback];
PRINT 'Cleared all existing data from the "Feedback" table.';
GO

-- =================================================================
-- Step 3: Populate the Table with Randomized Data
-- =================================================================
DECLARE @CurrentStudentID INT = 1;
DECLARE @TotalStudents INT = 1500;
DECLARE @TotalInstructors INT = 100;

PRINT 'Starting data generation...';

-- Loop through each student from 1 to 1500
WHILE @CurrentStudentID <= @TotalStudents
BEGIN
    -- For each student, determine how many feedback entries they will provide (2, 3, or 4)
    DECLARE @NumberOfFeedbacks INT = FLOOR(RAND() * 3) + 2;
    DECLARE @FeedbackCounter INT = 0;

    -- Inner loop to create the 2-4 feedback entries for the current student
    WHILE @FeedbackCounter < @NumberOfFeedbacks
    BEGIN
        -- Generate random data for the feedback entry
        DECLARE @RandomInstructorID INT = FLOOR(RAND() * @TotalInstructors) + 1; -- A random instructor from 1 to 100
        DECLARE @RandomRating INT = FLOOR(RAND() * 5) + 1; -- A random rating from 1 (poor) to 5 (excellent)
        DECLARE @RandomDaysAgo INT = FLOOR(RAND() * 730) + 1; -- A random date within the last 2 years
        DECLARE @RandomDate DATE = DATEADD(DAY, -@RandomDaysAgo, GETDATE());

        -- Insert the generated record into the Feedback table
        INSERT INTO [dbo].[Feedback] (St_ID, InstructorID, InstructorRating, Date)
        VALUES (
            @CurrentStudentID,
            @RandomInstructorID,
            @RandomRating,
            @RandomDate
        );

        SET @FeedbackCounter = @FeedbackCounter + 1;
    END

    -- Move to the next student
    SET @CurrentStudentID = @CurrentStudentID + 1;
END

PRINT 'Data generation complete. The "Feedback" table has been populated.';
GO












-- =================================================================
-- =================================================================
TRUNCATE TABLE dbo.branch_instructor;
GO

PRINT 'Cleared existing data. Starting targeted data generation...';
GO

-- =================================================================
-- Step 3: Generation Logic
-- =================================================================
BEGIN
    -- == Configuration Variables ==
    DECLARE @TotalInstructors INT = 100;
    DECLARE @TotalBranches INT = 15;

    -- == Identify the "Hub" Branch and Determine its Size ==
    DECLARE @HubBranchID INT = FLOOR(RAND() * @TotalBranches) + 1; -- Choose a random branch to be the hub
    DECLARE @NumHubInstructors INT = FLOOR(RAND() * 9) + 10; -- Choose a random number of instructors for the hub (10-18)
    PRINT 'The Hub Branch will be Branch_ID: ' + CAST(@HubBranchID AS VARCHAR) + ' with ' + CAST(@NumHubInstructors AS VARCHAR) + ' instructors.';

    -- == In-Memory tables to manage the process ==
    DECLARE @Instructors TABLE (ID INT);
    DECLARE @Branches TABLE (ID INT);
    
    -- Populate the lists of all instructors and branches
    INSERT INTO @Instructors (ID) SELECT TOP (@TotalInstructors) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) FROM sys.all_objects;
    INSERT INTO @Branches (ID) SELECT TOP (@TotalBranches) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) FROM sys.all_objects;

    -- == Part A: Assign instructors to the Hub Branch ==
    PRINT 'Assigning ' + CAST(@NumHubInstructors AS VARCHAR) + ' instructors to the hub branch...';
    
    INSERT INTO branch_instructor (InstructorID, Branch_ID)
    SELECT TOP (@NumHubInstructors) ID, @HubBranchID
    FROM @Instructors
    ORDER BY NEWID(); -- Select N random instructors for the hub

    -- == Part B: Assign remaining branches to ALL instructors, respecting the 3-branch limit ==
    PRINT 'Assigning remaining 1-2 branches to hub instructors and 1-3 to others...';
    
    DECLARE @CurrentInstructorID INT = 1;
    WHILE @CurrentInstructorID <= @TotalInstructors
    BEGIN
        DECLARE @AssignmentsSoFar INT;
        DECLARE @MaxNewAssignments INT;
        
        -- Check how many branches this instructor is already assigned to (0 or 1)
        SELECT @AssignmentsSoFar = COUNT(*) FROM branch_instructor WHERE InstructorID = @CurrentInstructorID;
        
        -- Determine the maximum number of *new* assignments this instructor can get
        SET @MaxNewAssignments = 3 - @AssignmentsSoFar;
        
        -- Determine a random number of new assignments to give, up to the allowed max
        DECLARE @NumNewAssignments INT = FLOOR(RAND() * (@MaxNewAssignments + 1));
        
        IF @NumNewAssignments > 0
        BEGIN
            -- Insert the new, unique branch assignments for this instructor
            -- It avoids assigning a branch they already have (specifically the hub branch)
            INSERT INTO branch_instructor (InstructorID, Branch_ID)
            SELECT TOP (@NumNewAssignments) @CurrentInstructorID, b.ID
            FROM @Branches b
            WHERE b.ID NOT IN (SELECT Branch_ID FROM branch_instructor WHERE InstructorID = @CurrentInstructorID)
            ORDER BY NEWID();
        END
        
        -- Ensure every instructor has at least one assignment
        -- This handles the edge case where an instructor was not assigned to the hub and also got 0 new assignments
        IF (SELECT COUNT(*) FROM branch_instructor WHERE InstructorID = @CurrentInstructorID) = 0
        BEGIN
            INSERT INTO branch_instructor (InstructorID, Branch_ID)
            SELECT TOP 1 @CurrentInstructorID, ID FROM @Branches ORDER BY NEWID();
        END

        SET @CurrentInstructorID = @CurrentInstructorID + 1;
    END
END
GO

PRINT 'Data generation complete.';
GO








-- Assuming exam_result table has columns:
-- St_ID INT, Exam_ID INT, Course_ID INT, Exam_Date DATE, Exam_Percentage FLOAT, Result VARCHAR(20)

-- Step 1: Clear existing data
TRUNCATE TABLE exam_result;

-- Step 2: Prepare variables
DECLARE @TotalStudents INT = 1500;
DECLARE @TotalExams INT = 50;
DECLARE @MinExamsPerStudent INT = 4;
DECLARE @MaxExamsPerStudent INT = 5;

-- Temporary table to hold all exam IDs and their Course_IDs (assuming Course_ID is known per exam)
-- For demo, we assign Course_ID = Exam_ID (adjust as per your real data)
DECLARE @Exams TABLE (Exam_ID INT PRIMARY KEY, Course_ID INT);
INSERT INTO @Exams (Exam_ID, Course_ID)
SELECT number, number FROM master..spt_values WHERE type = 'P' AND number BETWEEN 1 AND @TotalExams;

-- Step 3: Loop through students and insert exam results
DECLARE @StudentID INT = 1;

WHILE @StudentID <= @TotalStudents
BEGIN
    -- Number of exams for this student (4 or 5)
    DECLARE @NumExams INT = CASE WHEN RAND(CHECKSUM(NEWID())) < 0.5 THEN 4 ELSE 5 END;

    -- Select random exams for this student
    ;WITH RandomExams AS (
        SELECT TOP (@NumExams) Exam_ID, Course_ID
        FROM @Exams
        ORDER BY NEWID()
    )
    INSERT INTO exam_result (St_ID, Exam_ID, Course_ID, Exam_Date, Exam_Percentage, Result)
    SELECT
        @StudentID,
        Exam_ID,
        Course_ID,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 365, CAST(GETDATE() AS DATE)), -- Random date within last year
        -- Generate Exam_Percentage based on desired distribution
        CASE
            WHEN RandVal < 0.2 THEN ROUND(85 + (RandVal2 * 15), 2) -- Distinction 85-100%
            WHEN RandVal < 0.8 THEN ROUND(50 + (RandVal2 * 35), 2) -- Pass 50-85%
            ELSE ROUND(RandVal2 * 50, 2) -- Fail 0-50%
        END AS Exam_Percentage,
        CASE
            WHEN RandVal < 0.2 THEN 'Distinction'
            WHEN RandVal < 0.8 THEN 'Passed'
            ELSE 'Fail'
        END AS Result
    FROM (
        SELECT
            Exam_ID,
            Course_ID,
            RAND(CHECKSUM(NEWID())) AS RandVal,
            RAND(CHECKSUM(NEWID())) AS RandVal2
        FROM RandomExams
    ) AS ExamData;

    SET @StudentID = @StudentID + 1;
END
GO

