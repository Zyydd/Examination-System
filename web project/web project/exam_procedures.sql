
-- Stored Procedures for Examination System
-- These procedures follow the exact flow described by the user

USE [Project OLTP]
GO

-- =============================================
-- Stored Procedure: sp_generate_exam_on_login
-- Description: Generates exam when student logs in with email and course name
-- Parameters: @email (student email), @course_name (course name)
-- Returns: @st_id, @course_id, @exam_id
-- =============================================

CREATE OR ALTER PROCEDURE sp_generate_exam_on_login
    @email VARCHAR(255),
    @course_name VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @st_id INT;
    DECLARE @course_id INT;
    DECLARE @exam_id INT;
    DECLARE @exam_name VARCHAR(255);
    DECLARE @current_date DATE = GETDATE();

    BEGIN TRY
        -- Get student ID from email
        SELECT @st_id = St_ID 
        FROM Student 
        WHERE Email = @email;

        -- Check if student exists
        IF @st_id IS NULL
        BEGIN
            RAISERROR('Student not found with provided email', 16, 1);
            RETURN;
        END

        -- Get course ID from course name
        SELECT @course_id = Course_ID 
        FROM Courses 
        WHERE Course_Name = @course_name;

        -- Check if course exists
        IF @course_id IS NULL
        BEGIN
            RAISERROR('Course not found with provided name', 16, 1);
            RETURN;
        END

        -- Generate new exam ID (you can use IDENTITY or custom logic)
        SELECT @exam_id = ISNULL(MAX(Exam_ID), 0) + 1 FROM Exam;

        -- Set exam name
        SET @exam_name = @course_name + ' Exam - ' + CONVERT(VARCHAR, @current_date, 105);

        -- Create new exam record
        INSERT INTO Exam (Exam_ID, Exam_Name, Exam_Duration, Exam_Date, Exam_Mark, Exam_Level)
        VALUES (@exam_id, @exam_name, '60', @current_date, 100.00, 'Intermediate');

        -- Populate exam with questions from the course
        INSERT INTO Exam_Ques (Exam_ID, Question_ID)
        SELECT @exam_id, Question_ID 
        FROM Questions 
        WHERE Course_ID = @course_id
        ORDER BY NEWID() -- Random selection
        -- You can add TOP clause to limit number of questions if needed

        -- Return the generated IDs
        SELECT 
            @st_id AS st_id,
            @course_id AS course_id,
            @exam_id AS exam_id,
            @exam_name AS exam_name,
            'Exam generated successfully' AS message;

    END TRY
    BEGIN CATCH
        -- Error handling
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO

-- =============================================
-- Stored Procedure: sp_start_exam
-- Description: Starts the exam and returns questions for display
-- Parameters: @st_id (student ID), @exam_id (exam ID)
-- Returns: Questions for the exam
-- =============================================

CREATE OR ALTER PROCEDURE sp_start_exam
    @st_id INT,
    @exam_id INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @course_id INT;

    BEGIN TRY
        -- Verify that the exam exists
        IF NOT EXISTS (SELECT 1 FROM Exam WHERE Exam_ID = @exam_id)
        BEGIN
            RAISERROR('Exam not found', 16, 1);
            RETURN;
        END

        -- Verify that the student exists
        IF NOT EXISTS (SELECT 1 FROM Student WHERE St_ID = @st_id)
        BEGIN
            RAISERROR('Student not found', 16, 1);
            RETURN;
        END

        -- Check if student has already taken this exam
        IF EXISTS (SELECT 1 FROM Exam_Result WHERE St_ID = @st_id AND Exam_ID = @exam_id)
        BEGIN
            RAISERROR('Student has already taken this exam', 16, 1);
            RETURN;
        END

        -- Return exam questions with their answer choices
        SELECT 
            q.Question_ID,
            q.Question_txt,
            q.Question_Level,
            q.Question_Type,
            ac.Answer_Choice,
            ROW_NUMBER() OVER (PARTITION BY q.Question_ID ORDER BY ac.Answer_Choice) as Choice_Number
        FROM Exam_Ques eq
        INNER JOIN Questions q ON eq.Question_ID = q.Question_ID
        LEFT JOIN Answer_Choices ac ON q.Question_ID = ac.Question_ID
        WHERE eq.Exam_ID = @exam_id
        ORDER BY q.Question_ID, ac.Answer_Choice;

        -- Also return exam details
        SELECT 
            e.Exam_ID,
            e.Exam_Name,
            e.Exam_Duration,
            e.Exam_Date,
            e.Exam_Mark,
            e.Exam_Level,
            COUNT(eq.Question_ID) as Total_Questions
        FROM Exam e
        LEFT JOIN Exam_Ques eq ON e.Exam_ID = eq.Exam_ID
        WHERE e.Exam_ID = @exam_id
        GROUP BY e.Exam_ID, e.Exam_Name, e.Exam_Duration, e.Exam_Date, e.Exam_Mark, e.Exam_Level;

    END TRY
    BEGIN CATCH
        -- Error handling
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO

-- =============================================
-- Additional Stored Procedure: sp_submit_exam
-- Description: Submits exam answers and calculates results
-- Parameters: @st_id, @exam_id, @course_id, answer parameters
-- =============================================

CREATE OR ALTER PROCEDURE sp_submit_exam
    @st_id INT,
    @exam_id INT,
    @course_id INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @total_questions INT;
    DECLARE @correct_answers INT;
    DECLARE @percentage DECIMAL(5,2);
    DECLARE @result VARCHAR(50);
    DECLARE @current_date DATE = GETDATE();

    BEGIN TRY
        -- Calculate total questions
        SELECT @total_questions = COUNT(*) 
        FROM Exam_Ques 
        WHERE Exam_ID = @exam_id;

        -- Calculate correct answers
        SELECT @correct_answers = COUNT(*)
        FROM Stud_answers sa
        INNER JOIN Questions q ON sa.Question_ID = q.Question_ID
        WHERE sa.St_ID = @st_id 
        AND sa.Exam_ID = @exam_id
        AND sa.St_Answer = q.Correct_Answer;

        -- Calculate percentage
        SET @percentage = CASE 
            WHEN @total_questions > 0 THEN (@correct_answers * 100.0) / @total_questions
            ELSE 0
        END;

        -- Determine result
        SET @result = CASE 
            WHEN @percentage >= 60 THEN 'Pass'
            ELSE 'Fail'
        END;

        -- Insert exam result
        INSERT INTO Exam_Result (St_ID, Exam_ID, Course_ID, Exam_Date, Exam_Percentage, Result)
        VALUES (@st_id, @exam_id, @course_id, @current_date, @percentage, @result);

        -- Return results
        SELECT 
            @st_id AS student_id,
            @exam_id AS exam_id,
            @total_questions AS total_questions,
            @correct_answers AS correct_answers,
            @percentage AS percentage,
            @result AS result,
            'Exam submitted successfully' AS message;

    END TRY
    BEGIN CATCH
        -- Error handling
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO

-- =============================================
-- Sample data insertion for testing
-- =============================================

-- Insert sample courses if not exists
IF NOT EXISTS (SELECT 1 FROM Courses WHERE Course_Name = 'Database Management')
BEGIN
    INSERT INTO Courses (Course_ID, Course_Name, C_Status, C_duration, InstructorID)
    VALUES (101, 'Database Management', 'Active', '3 months', 1);
END

IF NOT EXISTS (SELECT 1 FROM Courses WHERE Course_Name = 'Web Development')
BEGIN
    INSERT INTO Courses (Course_ID, Course_Name, C_Status, C_duration, InstructorID)
    VALUES (102, 'Web Development', 'Active', '4 months', 2);
END

IF NOT EXISTS (SELECT 1 FROM Courses WHERE Course_Name = 'Data Structures')
BEGIN
    INSERT INTO Courses (Course_ID, Course_Name, C_Status, C_duration, InstructorID)
    VALUES (103, 'Data Structures', 'Active', '3 months', 3);
END

-- Insert sample students if not exists
IF NOT EXISTS (SELECT 1 FROM Student WHERE Email = 'john.doe@email.com')
BEGIN
    INSERT INTO Student (St_ID, Fname, Lname, Email, Phonenumber, City, Street, Zip_Code, Gender, BirthDate, LinkedIn_URL, Graduation_Year, Grade, F_codeFK, Track_IDFK)
    VALUES (1, 'John', 'Doe', 'john.doe@email.com', '1234567890', 'Cairo', 'Main St', '12345', 'Male', '1995-01-15', 'linkedin.com/johndoe', 2023, 85.5, 1, 1);
END

IF NOT EXISTS (SELECT 1 FROM Student WHERE Email = 'jane.smith@email.com')
BEGIN
    INSERT INTO Student (St_ID, Fname, Lname, Email, Phonenumber, City, Street, Zip_Code, Gender, BirthDate, LinkedIn_URL, Graduation_Year, Grade, F_codeFK, Track_IDFK)
    VALUES (2, 'Jane', 'Smith', 'jane.smith@email.com', '0987654321', 'Alexandria', 'Second St', '54321', 'Female', '1996-03-22', 'linkedin.com/janesmith', 2023, 92.0, 1, 2);
END

-- Insert sample questions
IF NOT EXISTS (SELECT 1 FROM Questions WHERE Course_ID = 101)
BEGIN
    INSERT INTO Questions (Question_ID, Question_txt, Correct_Answer, Question_Level, Question_Type, Course_ID)
    VALUES 
    (1, 'What is a primary key in database?', 'A unique identifier', 'Easy', 'Multiple Choice', 101),
    (2, 'What does SQL stand for?', 'Structured Query Language', 'Easy', 'Multiple Choice', 101),
    (3, 'What is a foreign key?', 'A key from another table', 'Medium', 'Multiple Choice', 101);

    -- Insert answer choices
    INSERT INTO Answer_Choices (Question_ID, Answer_Choice)
    VALUES 
    (1, 'A unique identifier'), (1, 'A foreign key'), (1, 'An index'), (1, 'A constraint'),
    (2, 'Structured Query Language'), (2, 'Simple Query Language'), (2, 'Standard Query Language'), (2, 'System Query Language'),
    (3, 'A key from another table'), (3, 'A primary key'), (3, 'An index'), (3, 'A constraint');
END

IF NOT EXISTS (SELECT 1 FROM Questions WHERE Course_ID = 102)
BEGIN
    INSERT INTO Questions (Question_ID, Question_txt, Correct_Answer, Question_Level, Question_Type, Course_ID)
    VALUES 
    (4, 'Which HTML tag is used for headings?', '<h1>', 'Easy', 'Multiple Choice', 102),
    (5, 'Which CSS property is used to change background color?', 'background-color', 'Easy', 'Multiple Choice', 102);

    -- Insert answer choices
    INSERT INTO Answer_Choices (Question_ID, Answer_Choice)
    VALUES 
    (4, '<h1>'), (4, '<head>'), (4, '<title>'), (4, '<header>'),
    (5, 'background-color'), (5, 'color'), (5, 'bg-color'), (5, 'background');
END

PRINT 'Stored procedures and sample data created successfully!';
