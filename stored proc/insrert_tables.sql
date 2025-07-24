-- ================================================
-- PROCEDURE: Insert_Answer_Choices
-- ================================================
CREATE PROCEDURE Insert_Answer_Choices
    @Question_ID INT,
    @Answer_Choice VARCHAR(255)
AS
BEGIN

    IF @Question_ID IS NULL OR @Answer_Choice IS NULL
    BEGIN
        PRINT 'ERROR: Both Question_ID and Answer_Choice are required.';
        RETURN;
    END

    IF NOT EXISTS (SELECT Question_ID FROM Questions WHERE Question_ID = @Question_ID)
    BEGIN
        PRINT 'ERROR: Question_ID does not exist in Questions.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Answer_Choices (Question_ID, Answer_Choice)
        VALUES (@Question_ID, @Answer_Choice);

        PRINT 'Answer choice inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO


-- ================================================
-- PROCEDURE: Insert_Attendance
-- ================================================
CREATE PROCEDURE Insert_Attendance
    @Course_ID INT,
    @St_ID INT,
    @Date DATE = NULL,
    @degree INT = NULL
AS
BEGIN

    IF @Course_ID IS NULL OR @St_ID IS NULL
    BEGIN
        PRINT 'ERROR: Course_ID and St_ID are required.';
        RETURN;
    END

    IF NOT EXISTS (SELECT Course_ID FROM Courses WHERE Course_ID = @Course_ID)
    BEGIN
        PRINT 'ERROR: Course_ID does not exist in Courses.';
        RETURN;
    END

    IF NOT EXISTS (SELECT St_ID FROM Student WHERE St_ID = @St_ID)
    BEGIN
        PRINT 'ERROR: St_ID does not exist in Student.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Attendance (Course_ID, St_ID, Date, degree)
        VALUES (@Course_ID, @St_ID, @Date, @degree);

        PRINT 'Attendance record inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO


-- ================================================
-- PROCEDURE: Insert_Branch
-- ================================================
CREATE PROCEDURE Insert_Branch
    @Branch_ID INT,
    @Branch_Name VARCHAR(255) = NULL,
    @Branch_Location VARCHAR(255) = NULL,
    @MNG_Name VARCHAR(255) = NULL,
    @Founded_Date DATE = NULL
AS
BEGIN


    IF @Branch_ID IS NULL
    BEGIN
        PRINT 'ERROR: Branch_ID is required.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Branch (
            Branch_ID, Branch_Name, Branch_Location, MNG_Name, Founded_Date
        )
        VALUES (
            @Branch_ID, @Branch_Name, @Branch_Location, @MNG_Name, @Founded_Date
        );

        PRINT 'Branch inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO


-- ================================================
-- PROCEDURE: Insert_Branch_Instructor
-- ================================================
CREATE PROCEDURE Insert_Branch_Instructor
    @InstructorID INT,
    @Branch_ID INT
AS
BEGIN


    IF @InstructorID IS NULL OR @Branch_ID IS NULL
    BEGIN
        PRINT 'ERROR: Both InstructorID and Branch_ID are required.';
        RETURN;
    END

    IF NOT EXISTS (SELECT InstructorID FROM Instructor WHERE InstructorID = @InstructorID)
    BEGIN
        PRINT 'ERROR: InstructorID does not exist in Instructor.';
        RETURN;
    END

    IF NOT EXISTS (SELECT Branch_ID FROM Branch WHERE Branch_ID = @Branch_ID)
    BEGIN
        PRINT 'ERROR: Branch_ID does not exist in Branch.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Branch_instructor (InstructorID, Branch_ID)
        VALUES (@InstructorID, @Branch_ID);

        PRINT 'Instructor assigned to Branch successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO


-- ================================================
-- PROCEDURE: Insert_Branch_Track
-- ================================================
CREATE PROCEDURE Insert_Branch_Track
    @Track_ID INT,
    @Branch_ID INT
AS
BEGIN


    IF @Track_ID IS NULL OR @Branch_ID IS NULL
    BEGIN
        PRINT 'ERROR: Both Track_ID and Branch_ID are required.';
        RETURN;
    END

    IF NOT EXISTS (SELECT Track_ID FROM Tracks WHERE Track_ID = @Track_ID)
    BEGIN
        PRINT 'ERROR: Track_ID does not exist in Tracks.';
        RETURN;
    END

    IF NOT EXISTS (SELECT Branch_ID FROM Branch WHERE Branch_ID = @Branch_ID)
    BEGIN
        PRINT 'ERROR: Branch_ID does not exist in Branch.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Branch_Track (Track_ID, Branch_ID)
        VALUES (@Track_ID, @Branch_ID);

        PRINT 'Track assigned to Branch successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO

-- ================================================
-- PROCEDURE: Insert_Certificates
-- ================================================
CREATE PROCEDURE Insert_Certificates
    @Cer_ID INT,
    @Cer_Name VARCHAR(255) = NULL,
    @Acquired_Date DATE = NULL,
    @Provider_Name VARCHAR(255) = NULL
AS
BEGIN


    IF @Cer_ID IS NULL
    BEGIN
        PRINT 'ERROR: Cer_ID is required.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Certificates (
            Cer_ID, Cer_Name, Acquired_Date, Provider_Name
        )
        VALUES (
            @Cer_ID, @Cer_Name, @Acquired_Date, @Provider_Name
        );

        PRINT 'Certificate inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO


-- ================================================
-- PROCEDURE: Insert_Company
-- ================================================
CREATE PROCEDURE Insert_Company
    @Com_ID INT,
    @Grad_ID INT,
    @Com_Name VARCHAR(255) = NULL,
    @C_City VARCHAR(255) = NULL,
    @Job_Type VARCHAR(255) = NULL,
    @Hiring_date DATE = NULL,
    @Job_title VARCHAR(255) = NULL,
    @Salary_Range VARCHAR(100) = NULL
AS
BEGIN

    IF @Com_ID IS NULL OR @Grad_ID IS NULL
    BEGIN
        PRINT 'ERROR: Both Com_ID and Grad_ID are required.';
        RETURN;
    END

    IF NOT EXISTS (SELECT Grad_ID FROM Graduates WHERE Grad_ID = @Grad_ID)
    BEGIN
        PRINT 'ERROR: Grad_ID does not exist in Graduates.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Company (
            Com_ID, Grad_ID, Com_Name, C_City, Job_Type, Hiring_date, Job_title, Salary_Range
        )
        VALUES (
            @Com_ID, @Grad_ID, @Com_Name, @C_City, @Job_Type, @Hiring_date, @Job_title, @Salary_Range
        );

        PRINT 'Company record inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO


-- ================================================
-- PROCEDURE: Insert_Courses
-- ================================================
CREATE PROCEDURE Insert_Courses
    @Course_ID INT,
    @Course_Name VARCHAR(255) = NULL,
    @C_Status VARCHAR(50) = NULL,
    @C_duration VARCHAR(50) = NULL,
    @InstructorID INT = NULL
AS
BEGIN

    IF @Course_ID IS NULL
    BEGIN
        PRINT 'ERROR: Course_ID is required.';
        RETURN;
    END

    IF @InstructorID IS NOT NULL AND NOT EXISTS (SELECT InstructorID FROM Instructor WHERE InstructorID = @InstructorID)
    BEGIN
        PRINT 'ERROR: InstructorID does not exist in Instructor.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Courses (
            Course_ID, Course_Name, C_Status, C_duration, InstructorID
        )
        VALUES (
            @Course_ID, @Course_Name, @C_Status, @C_duration, @InstructorID
        );

        PRINT 'Course inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO


-- ================================================
-- PROCEDURE: Insert_Dependents
-- ================================================
CREATE PROCEDURE Insert_Dependents
    @Dep_ID INT,
    @InstructorID INT,
    @Dep_Name VARCHAR(255) = NULL,
    @Gender VARCHAR(50) = NULL,
    @Age INT = NULL
AS
BEGIN


    IF @Dep_ID IS NULL OR @InstructorID IS NULL
    BEGIN
        PRINT 'ERROR: Both Dep_ID and InstructorID are required.';
        RETURN;
    END

    IF NOT EXISTS (SELECT InstructorID FROM Instructor WHERE InstructorID = @InstructorID)
    BEGIN
        PRINT 'ERROR: InstructorID does not exist in Instructor.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Dependents (
            Dep_ID, InstructorID, Dep_Name, Gender, Age
        )
        VALUES (
            @Dep_ID, @InstructorID, @Dep_Name, @Gender, @Age
        );

        PRINT 'Dependent inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO


-- ================================================
-- PROCEDURE: Insert_Exam
-- ================================================
CREATE PROCEDURE Insert_Exam
    @Exam_ID INT,
    @Exam_Name VARCHAR(255) = NULL,
    @Exam_Duration VARCHAR(50) = NULL,
    @Exam_Date DATE = NULL,
    @Exam_Mark DECIMAL(5,2) = NULL,
    @Exam_Level VARCHAR(50) = NULL
AS
BEGIN

    IF @Exam_ID IS NULL
    BEGIN
        PRINT 'ERROR: Exam_ID is required.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Exam (
            Exam_ID, Exam_Name, Exam_Duration, Exam_Date, Exam_Mark, Exam_Level
        )
        VALUES (
            @Exam_ID, @Exam_Name, @Exam_Duration, @Exam_Date, @Exam_Mark, @Exam_Level
        );

        PRINT 'Exam inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO

-- ================================================
-- PROCEDURE: Insert_Exam_Ques
-- ================================================
CREATE PROCEDURE Insert_Exam_Ques
    @Exam_ID INT,
    @Question_ID INT
AS
BEGIN


    IF @Exam_ID IS NULL OR @Question_ID IS NULL
    BEGIN
        PRINT 'ERROR: Both Exam_ID and Question_ID are required.';
        RETURN;
    END

    IF NOT EXISTS (SELECT Exam_ID FROM Exam WHERE Exam_ID = @Exam_ID)
    BEGIN
        PRINT 'ERROR: Exam_ID does not exist in Exam.';
        RETURN;
    END

    IF NOT EXISTS (SELECT Question_ID FROM Questions WHERE Question_ID = @Question_ID)
    BEGIN
        PRINT 'ERROR: Question_ID does not exist in Questions.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Exam_Ques (Exam_ID, Question_ID)
        VALUES (@Exam_ID, @Question_ID);

        PRINT 'Exam question mapping inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO


-- ================================================
-- PROCEDURE: Insert_Exam_Result
-- ================================================
CREATE PROCEDURE Insert_Exam_Result
    @St_ID INT,
    @Exam_ID INT,
    @Course_ID INT,
    @Exam_Date DATE = NULL,
    @Exam_Percentage DECIMAL(5,2) = NULL,
    @Result VARCHAR(50) = NULL
AS
BEGIN


    IF @St_ID IS NULL OR @Exam_ID IS NULL OR @Course_ID IS NULL
    BEGIN
        PRINT 'ERROR: St_ID, Exam_ID, and Course_ID are required.';
        RETURN;
    END

    IF NOT EXISTS (SELECT St_ID FROM Student WHERE St_ID = @St_ID)
    BEGIN
        PRINT 'ERROR: St_ID does not exist in Student.';
        RETURN;
    END

    IF NOT EXISTS (SELECT Exam_ID FROM Exam WHERE Exam_ID = @Exam_ID)
    BEGIN
        PRINT 'ERROR: Exam_ID does not exist in Exam.';
        RETURN;
    END

    IF NOT EXISTS (SELECT Course_ID FROM Courses WHERE Course_ID = @Course_ID)
    BEGIN
        PRINT 'ERROR: Course_ID does not exist in Courses.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Exam_Result (
            St_ID, Exam_ID, Course_ID, Exam_Date, Exam_Percentage, Result
        )
        VALUES (
            @St_ID, @Exam_ID, @Course_ID, @Exam_Date, @Exam_Percentage, @Result
        );

        PRINT 'Exam result inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO


-- ================================================
-- PROCEDURE: Insert_Faculties
-- ================================================
CREATE PROCEDURE Insert_Faculties
    @F_code INT,
    @F_Name VARCHAR(255) = NULL,
    @City VARCHAR(255) = NULL
AS
BEGIN


    IF @F_code IS NULL
    BEGIN
        PRINT 'ERROR: F_code is required.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Faculties (
            F_code, F_Name, City
        )
        VALUES (
            @F_code, @F_Name, @City
        );

        PRINT 'Faculty inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO


-- ================================================
-- PROCEDURE: Insert_Feedback
-- ================================================
CREATE PROCEDURE Insert_Feedback
    @St_ID INT,
    @InstructorID INT,
    @Course_ID INT,
    @InstructorRating INT = NULL,
    @CourseRating INT = NULL,
    @Date DATE = NULL
AS
BEGIN


    IF @St_ID IS NULL OR @InstructorID IS NULL OR @Course_ID IS NULL
    BEGIN
        PRINT 'ERROR: St_ID, InstructorID, and Course_ID are required.';
        RETURN;
    END

    IF NOT EXISTS (SELECT St_ID FROM Student WHERE St_ID = @St_ID)
    BEGIN
        PRINT 'ERROR: St_ID does not exist in Student.';
        RETURN;
    END

    IF NOT EXISTS (SELECT InstructorID FROM Instructor WHERE InstructorID = @InstructorID)
    BEGIN
        PRINT 'ERROR: InstructorID does not exist in Instructor.';
        RETURN;
    END

    IF NOT EXISTS (SELECT Course_ID FROM Courses WHERE Course_ID = @Course_ID)
    BEGIN
        PRINT 'ERROR: Course_ID does not exist in Courses.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Feedback (
            St_ID, InstructorID, Course_ID, InstructorRating, CourseRating, Date
        )
        VALUES (
            @St_ID, @InstructorID, @Course_ID, @InstructorRating, @CourseRating, @Date
        );

        PRINT 'Feedback inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO


-- ================================================
-- PROCEDURE: Insert_Freelance
-- ================================================
CREATE PROCEDURE Insert_Freelance
    @Task_title VARCHAR(255),
    @St_ID INT,
    @Related_Field VARCHAR(255) = NULL,
    @Task_Duration VARCHAR(50) = NULL,
    @Cost DECIMAL(10,2) = NULL
AS
BEGIN


    IF @Task_title IS NULL OR @St_ID IS NULL
    BEGIN
        PRINT 'ERROR: Task_title and St_ID are required.';
        RETURN;
    END

    IF NOT EXISTS (SELECT St_ID FROM Student WHERE St_ID = @St_ID)
    BEGIN
        PRINT 'ERROR: St_ID does not exist in Student.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Freelance (
            Task_title, St_ID, Related_Field, Task_Duration, Cost
        )
        VALUES (
            @Task_title, @St_ID, @Related_Field, @Task_Duration, @Cost
        );

        PRINT 'Freelance task inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ';
    END CATCH
END
GO

-- ================================================
-- PROCEDURE: Insert_Graduates
-- ================================================
CREATE PROCEDURE Insert_Graduates
    @Grad_ID INT,
    @Grad_Name VARCHAR(255) = NULL,
    @Git_URL VARCHAR(255) = NULL,
    @LinkedIn_URL VARCHAR(255) = NULL,
    @Graduate_Date DATE = NULL,
    @Track_ID INT = NULL
AS
BEGIN


    IF @Grad_ID IS NULL
    BEGIN
        PRINT 'ERROR: Grad_ID is required.';
        RETURN;
    END

    IF @Track_ID IS NOT NULL AND NOT EXISTS (SELECT Track_ID FROM Tracks WHERE Track_ID = @Track_ID)
    BEGIN
        PRINT 'ERROR: Track_ID does not exist in Tracks.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Graduates (
            Grad_ID, Grad_Name, Git_URL, LinkedIn_URL, Graduate_Date, Track_ID
        )
        VALUES (
            @Grad_ID, @Grad_Name, @Git_URL, @LinkedIn_URL, @Graduate_Date, @Track_ID
        );

        PRINT 'Graduate inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO


-- ================================================
-- PROCEDURE: Insert_Instructor
-- ================================================
CREATE PROCEDURE Insert_Instructor
    @InstructorID INT,
    @Fname VARCHAR(255) = NULL,
    @Lname VARCHAR(255) = NULL,
    @Email VARCHAR(255) = NULL,
    @City VARCHAR(255) = NULL,
    @Street VARCHAR(255) = NULL,
    @Zip_Code VARCHAR(10) = NULL,
    @Gender VARCHAR(50) = NULL,
    @BirthDate DATE = NULL,
    @HiringDate DATE = NULL,
    @Salary DECIMAL(10,2) = NULL,
    @ManagerID INT = NULL,
    @Phonenumber VARCHAR(20) = NULL
AS
BEGIN


    IF @InstructorID IS NULL
    BEGIN
        PRINT 'ERROR: InstructorID is required.';
        RETURN;
    END

    IF @ManagerID IS NOT NULL AND NOT EXISTS (SELECT InstructorID FROM Instructor WHERE InstructorID = @ManagerID)
    BEGIN
        PRINT 'ERROR: ManagerID does not exist in Instructor.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Instructor (
            InstructorID, Fname, Lname, Email, City, Street, Zip_Code, Gender,
            BirthDate, HiringDate, Salary, ManagerID, Phonenumber
        )
        VALUES (
            @InstructorID, @Fname, @Lname, @Email, @City, @Street, @Zip_Code, @Gender,
            @BirthDate, @HiringDate, @Salary, @ManagerID, @Phonenumber
        );

        PRINT 'Instructor inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO


-- ================================================
-- PROCEDURE: Insert_Intake
-- ================================================
CREATE PROCEDURE Insert_Intake
    @Intake_ID INT,
    @Intake_Name VARCHAR(255) = NULL,
    @StartDate DATE = NULL,
    @EndDate DATE = NULL
AS
BEGIN


    IF @Intake_ID IS NULL
    BEGIN
        PRINT 'ERROR: Intake_ID is required.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Intake (
            Intake_ID, Intake_Name, StartDate, EndDate
        )
        VALUES (
            @Intake_ID, @Intake_Name, @StartDate, @EndDate
        );

        PRINT 'Intake inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO


-- ================================================
-- PROCEDURE: Insert_Master
-- ================================================
CREATE PROCEDURE Insert_Master
    @Mas_title VARCHAR(255),
    @Grad_ID INT,
    @Country VARCHAR(255) = NULL,
    @University VARCHAR(255) = NULL,
    @Field VARCHAR(255) = NULL
AS
BEGIN


    IF @Mas_title IS NULL OR @Grad_ID IS NULL
    BEGIN
        PRINT 'ERROR: Both Mas_title and Grad_ID are required.';
        RETURN;
    END

    IF NOT EXISTS (SELECT Grad_ID FROM Graduates WHERE Grad_ID = @Grad_ID)
    BEGIN
        PRINT 'ERROR: Grad_ID does not exist in Graduates.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Master (
            Mas_title, Grad_ID, Country, University, Field
        )
        VALUES (
            @Mas_title, @Grad_ID, @Country, @University, @Field
        );

        PRINT 'Master record inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ';
    END CATCH
END
GO


-- ================================================
-- PROCEDURE: Insert_Questions
-- ================================================
CREATE PROCEDURE Insert_Questions
    @Question_ID INT,
    @Question_txt TEXT = NULL,
    @Correct_Answer VARCHAR(255) = NULL,
    @Question_Level VARCHAR(50) = NULL,
    @Question_Type VARCHAR(50) = NULL,
    @Course_ID INT = NULL
AS
BEGIN


    IF @Question_ID IS NULL
    BEGIN
        PRINT 'ERROR: Question_ID is required.';
        RETURN;
    END

    IF @Course_ID IS NOT NULL AND NOT EXISTS (SELECT Course_ID FROM Courses WHERE Course_ID = @Course_ID)
    BEGIN
        PRINT 'ERROR: Course_ID does not exist in Courses.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Questions (
            Question_ID, Question_txt, Correct_Answer, Question_Level, Question_Type, Course_ID
        )
        VALUES (
            @Question_ID, @Question_txt, @Correct_Answer, @Question_Level, @Question_Type, @Course_ID
        );

        PRINT 'Question inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ';
    END CATCH
END
GO

-- ================================================
-- PROCEDURE: Insert_Round
-- ================================================
CREATE PROCEDURE Insert_Round
    @Round_ID INT,
    @Round_Name VARCHAR(255) = NULL,
    @StartDate DATE = NULL,
    @EndDate DATE = NULL
AS
BEGIN


    IF @Round_ID IS NULL
    BEGIN
        PRINT 'ERROR: Round_ID is required.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Round (
            Round_ID, Round_Name, StartDate, EndDate
        )
        VALUES (
            @Round_ID, @Round_Name, @StartDate, @EndDate
        );

        PRINT 'Round inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO


-- ================================================
-- PROCEDURE: Insert_St_Intake
-- ================================================
CREATE PROCEDURE Insert_St_Intake
    @St_ID INT,
    @Intake_ID INT
AS
BEGIN


    IF @St_ID IS NULL OR @Intake_ID IS NULL
    BEGIN
        PRINT 'ERROR: Both St_ID and Intake_ID are required.';
        RETURN;
    END

    IF NOT EXISTS (SELECT St_ID FROM Student WHERE St_ID = @St_ID)
    BEGIN
        PRINT 'ERROR: St_ID does not exist in Student.';
        RETURN;
    END

    IF NOT EXISTS (SELECT Intake_ID FROM Intake WHERE Intake_ID = @Intake_ID)
    BEGIN
        PRINT 'ERROR: Intake_ID does not exist in Intake.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO St_Intake (St_ID, Intake_ID)
        VALUES (@St_ID, @Intake_ID);

        PRINT 'Student-Intake mapping inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO


-- ================================================
-- PROCEDURE: Insert_St_Round
-- ================================================
CREATE PROCEDURE Insert_St_Round
    @St_ID INT,
    @Round_ID INT
AS
BEGIN


    IF @St_ID IS NULL OR @Round_ID IS NULL
    BEGIN
        PRINT 'ERROR: Both St_ID and Round_ID are required.';
        RETURN;
    END

    IF NOT EXISTS (SELECT St_ID FROM Student WHERE St_ID = @St_ID)
    BEGIN
        PRINT 'ERROR: St_ID does not exist in Student.';
        RETURN;
    END

    IF NOT EXISTS (SELECT Round_ID FROM Round WHERE Round_ID = @Round_ID)
    BEGIN
        PRINT 'ERROR: Round_ID does not exist in Round.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO St_Round (St_ID, Round_ID)
        VALUES (@St_ID, @Round_ID);

        PRINT 'Student-Round mapping inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO


-- ================================================
-- PROCEDURE: Insert_Stud_answers
-- ================================================
CREATE PROCEDURE Insert_Stud_answers
    @St_ID INT,
    @Question_ID INT,
    @St_Answer VARCHAR(255),
    @Ques_Grade DECIMAL(5,2) = NULL,
    @Exam_ID INT = NULL
AS
BEGIN


    IF @St_ID IS NULL OR @Question_ID IS NULL OR @St_Answer IS NULL
    BEGIN
        PRINT 'ERROR: St_ID, Question_ID, and St_Answer are required.';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Student WHERE St_ID = @St_ID)
    BEGIN
        PRINT 'ERROR: St_ID does not exist in Student.';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Questions WHERE Question_ID = @Question_ID)
    BEGIN
        PRINT 'ERROR: Question_ID does not exist in Questions.';
        RETURN;
    END

    IF @Exam_ID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Exam WHERE Exam_ID = @Exam_ID)
    BEGIN
        PRINT 'ERROR: Exam_ID does not exist in Exam.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Stud_answers (
            St_ID, Question_ID, St_Answer, Ques_Grade, Exam_ID
        )
        VALUES (
            @St_ID, @Question_ID, @St_Answer, @Ques_Grade, @Exam_ID
        );

        PRINT 'Student answer inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO


-- ================================================
-- PROCEDURE: Insert_Stud_get_certificate
-- ================================================
CREATE PROCEDURE Insert_Stud_get_certificate
    @St_ID INT,
    @Cer_ID INT
AS
BEGIN


    IF @St_ID IS NULL OR @Cer_ID IS NULL
    BEGIN
        PRINT 'ERROR: Both St_ID and Cer_ID are required.';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Student WHERE St_ID = @St_ID)
    BEGIN
        PRINT 'ERROR: St_ID does not exist in Student.';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Certificates WHERE Cer_ID = @Cer_ID)
    BEGIN
        PRINT 'ERROR: Cer_ID does not exist in Certificates.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Stud_get_certificate (St_ID, Cer_ID)
        VALUES (@St_ID, @Cer_ID);

        PRINT 'Student-Certificate mapping inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO

-- ================================================
-- PROCEDURE: Insert_Student
-- ================================================
CREATE PROCEDURE Insert_Student
    @St_ID INT,
    @Fname VARCHAR(255) = NULL,
    @Lname VARCHAR(255) = NULL,
    @Email VARCHAR(255) = NULL,
    @City VARCHAR(255) = NULL,
    @Street VARCHAR(255) = NULL,
    @Zip_Code VARCHAR(10) = NULL,
    @Gender VARCHAR(50) = NULL,
    @BirthDate DATE = NULL,
    @F_code INT = NULL,
    @Phonenumber VARCHAR(20) = NULL
AS
BEGIN


    IF @St_ID IS NULL
    BEGIN
        PRINT 'ERROR: St_ID is required.';
        RETURN;
    END

    IF @F_code IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Faculties WHERE F_code = @F_code)
    BEGIN
        PRINT 'ERROR: F_code does not exist in Faculties.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Student (
            St_ID, Fname, Lname, Email, City, Street, Zip_Code, Gender,
            BirthDate, F_code, Phonenumber
        )
        VALUES (
            @St_ID, @Fname, @Lname, @Email, @City, @Street, @Zip_Code, @Gender,
            @BirthDate, @F_code, @Phonenumber
        );

        PRINT 'Student inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO


-- ================================================
-- PROCEDURE: Insert_Tracks
-- ================================================
CREATE PROCEDURE Insert_Tracks
    @Track_ID INT,
    @Track_Name VARCHAR(255) = NULL,
    @Field VARCHAR(255) = NULL
AS
BEGIN


    IF @Track_ID IS NULL
    BEGIN
        PRINT 'ERROR: Track_ID is required.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Tracks (
            Track_ID, Track_Name, Field
        )
        VALUES (
            @Track_ID, @Track_Name, @Field
        );

        PRINT 'Track inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' ;
    END CATCH
END
GO
