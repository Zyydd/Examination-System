USE [graduation project]
GO

Update_Attendance  1 ,1,1, 5000

-- 2. Attendance
CREATE OR ALTER PROCEDURE Update_Attendance
    @Old_Course_ID INT,
    @Old_St_ID INT,
    @New_Course_ID INT = NULL,
    @New_St_ID INT = NULL,
    @Date DATE = NULL,
    @degree INT = NULL
AS
BEGIN TRY
    IF @Old_Course_ID IS NULL OR @Old_St_ID IS NULL
    BEGIN
        PRINT 'Old_Course_ID and Old_St_ID must not be NULL.'
        RETURN
    END
    
    SET @New_Course_ID = ISNULL(@New_Course_ID, @Old_Course_ID)
    SET @New_St_ID = ISNULL(@New_St_ID, @Old_St_ID)
    
    IF NOT EXISTS (SELECT 1 FROM Attendance WHERE Course_ID = @Old_Course_ID AND St_ID = @Old_St_ID)
    BEGIN
        PRINT 'Original record not found.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Courses WHERE Course_ID = @New_Course_ID)
    BEGIN
        PRINT 'Invalid new Course_ID - does not exist in Courses table.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Student WHERE St_ID = @New_St_ID)
    BEGIN
        PRINT 'Invalid new St_ID - does not exist in Student table.'
        RETURN
    END
    
    IF (@New_Course_ID <> @Old_Course_ID OR @New_St_ID <> @Old_St_ID)
        AND EXISTS (SELECT 1 FROM Attendance WHERE Course_ID = @New_Course_ID AND St_ID = @New_St_ID)
    BEGIN
        PRINT 'New combination already exists in Attendance table.'
        RETURN
    END
    
    BEGIN TRANSACTION;
    
    IF @New_Course_ID <> @Old_Course_ID OR @New_St_ID <> @Old_St_ID
    BEGIN
        DELETE FROM Attendance WHERE Course_ID = @Old_Course_ID AND St_ID = @Old_St_ID;
        INSERT INTO Attendance (Course_ID, St_ID, Date, degree)
        VALUES (
            @New_Course_ID, 
            @New_St_ID,
            ISNULL(@Date, (SELECT Date FROM Attendance WHERE Course_ID = @Old_Course_ID AND St_ID = @Old_St_ID)),
            ISNULL(@degree, (SELECT degree FROM Attendance WHERE Course_ID = @Old_Course_ID AND St_ID = @Old_St_ID))
        );
    END
    ELSE
    BEGIN
        UPDATE Attendance
        SET 
		Date = ISNULL(@Date, Date), 
		degree = ISNULL(@degree, degree)
        WHERE Course_ID = @Old_Course_ID AND St_ID = @Old_St_ID;
    END
    
    COMMIT TRANSACTION;
    PRINT 'Attendance updated successfully.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'Error updating Attendance: ' + ERROR_MESSAGE();
END CATCH
GO

-- 3. Branch
CREATE OR ALTER PROCEDURE Update_Branch
    @Branch_ID INT,
    @Branch_Name VARCHAR(255) = NULL,
    @Branch_Location VARCHAR(255) = NULL,
    @MNG_Name VARCHAR(255) = NULL,
    @Founded_Date DATE = NULL
AS
BEGIN TRY
    IF @Branch_ID IS NULL
    BEGIN
        PRINT 'Branch_ID must not be NULL.'
        RETURN
    END

    UPDATE Branch
    SET 
        Branch_Name = ISNULL(@Branch_Name, Branch_Name),
        Branch_Location = ISNULL(@Branch_Location, Branch_Location),
        MNG_Name = ISNULL(@MNG_Name, MNG_Name),
        Founded_Date = ISNULL(@Founded_Date, Founded_Date)
    WHERE Branch_ID = @Branch_ID
END TRY
BEGIN CATCH
    PRINT 'Error updating Branch: ' + ERROR_MESSAGE();
END CATCH
GO

-- 4. Branch_instructor
CREATE OR ALTER PROCEDURE Update_Branch_instructor
    @Old_InstructorID INT,
    @Old_Branch_ID INT,
    @New_InstructorID INT = NULL,
    @New_Branch_ID INT = NULL
AS
BEGIN TRY
    IF @Old_InstructorID IS NULL OR @Old_Branch_ID IS NULL
    BEGIN
        PRINT 'Old_InstructorID and Old_Branch_ID must not be NULL.'
        RETURN
    END
    
    SET @New_InstructorID = ISNULL(@New_InstructorID, @Old_InstructorID)
    SET @New_Branch_ID = ISNULL(@New_Branch_ID, @Old_Branch_ID)
    
    IF NOT EXISTS (SELECT 1 FROM Branch_instructor WHERE InstructorID = @Old_InstructorID AND Branch_ID = @Old_Branch_ID)
    BEGIN
        PRINT 'Original record not found.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Instructor WHERE InstructorID = @New_InstructorID)
    BEGIN
        PRINT 'Invalid new InstructorID - does not exist in Instructor table.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Branch WHERE Branch_ID = @New_Branch_ID)
    BEGIN
        PRINT 'Invalid new Branch_ID - does not exist in Branch table.'
        RETURN
    END
    
    IF (@New_InstructorID <> @Old_InstructorID OR @New_Branch_ID <> @Old_Branch_ID)
        AND EXISTS (SELECT 1 FROM Branch_instructor WHERE InstructorID = @New_InstructorID AND Branch_ID = @New_Branch_ID)
    BEGIN
        PRINT 'New combination already exists in Branch_instructor table.'
        RETURN
    END
    
    BEGIN TRANSACTION;
    
    IF @New_InstructorID <> @Old_InstructorID OR @New_Branch_ID <> @Old_Branch_ID
    BEGIN
        DELETE FROM Branch_instructor WHERE InstructorID = @Old_InstructorID AND Branch_ID = @Old_Branch_ID;
        INSERT INTO Branch_instructor (InstructorID, Branch_ID) VALUES (@New_InstructorID, @New_Branch_ID);
    END
    
    COMMIT TRANSACTION;
    PRINT 'Branch_instructor updated successfully.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'Error updating Branch_instructor: ' + ERROR_MESSAGE();
END CATCH
GO

-- 5. Branch_Track
CREATE OR ALTER PROCEDURE Update_Branch_Track
    @Old_Track_ID INT,
    @Old_Branch_ID INT,
    @New_Track_ID INT = NULL,
    @New_Branch_ID INT = NULL
AS
BEGIN TRY
    IF @Old_Track_ID IS NULL OR @Old_Branch_ID IS NULL
    BEGIN
        PRINT 'Old_Track_ID and Old_Branch_ID must not be NULL.'
        RETURN
    END
    
    SET @New_Track_ID = ISNULL(@New_Track_ID, @Old_Track_ID)
    SET @New_Branch_ID = ISNULL(@New_Branch_ID, @Old_Branch_ID)
    
    IF NOT EXISTS (SELECT 1 FROM Branch_Track WHERE Track_ID = @Old_Track_ID AND Branch_ID = @Old_Branch_ID)
    BEGIN
        PRINT 'Original record not found.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Tracks WHERE Track_ID = @New_Track_ID)
    BEGIN
        PRINT 'Invalid new Track_ID - does not exist in Tracks table.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Branch WHERE Branch_ID = @New_Branch_ID)
    BEGIN
        PRINT 'Invalid new Branch_ID - does not exist in Branch table.'
        RETURN
    END
    
    IF (@New_Track_ID <> @Old_Track_ID OR @New_Branch_ID <> @Old_Branch_ID)
        AND EXISTS (SELECT 1 FROM Branch_Track WHERE Track_ID = @New_Track_ID AND Branch_ID = @New_Branch_ID)
    BEGIN
        PRINT 'New combination already exists in Branch_Track table.'
        RETURN
    END
    
    BEGIN TRANSACTION;
    
    IF @New_Track_ID <> @Old_Track_ID OR @New_Branch_ID <> @Old_Branch_ID
    BEGIN
        DELETE FROM Branch_Track WHERE Track_ID = @Old_Track_ID AND Branch_ID = @Old_Branch_ID;
        INSERT INTO Branch_Track (Track_ID, Branch_ID) VALUES (@New_Track_ID, @New_Branch_ID);
    END
    
    COMMIT TRANSACTION;
    PRINT 'Branch_Track updated successfully.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'Error updating Branch_Track: ' + ERROR_MESSAGE();
END CATCH
GO

-- 6. Certificates
CREATE OR ALTER PROCEDURE Update_Certificates
    @Cer_ID INT,
    @Cer_Name VARCHAR(255) = NULL,
    @Acquired_Date DATE = NULL,
    @Provider_Name VARCHAR(255) = NULL
AS
BEGIN TRY
    IF @Cer_ID IS NULL
    BEGIN
        PRINT 'Cer_ID must not be NULL.'
        RETURN
    END

    UPDATE Certificates
    SET 
        Cer_Name = ISNULL(@Cer_Name, Cer_Name),
        Acquired_Date = ISNULL(@Acquired_Date, Acquired_Date),
        Provider_Name = ISNULL(@Provider_Name, Provider_Name)
    WHERE Cer_ID = @Cer_ID
END TRY
BEGIN CATCH
    PRINT 'Error updating Certificates: ' + ERROR_MESSAGE();
END CATCH
GO

-- 7. Company
CREATE OR ALTER PROCEDURE Update_Company
    @Old_Com_ID INT,
    @Old_Grad_ID INT,
    @New_Com_ID INT = NULL,
    @New_Grad_ID INT = NULL,
    @Com_Name VARCHAR(255) = NULL,
    @C_City VARCHAR(255) = NULL,
    @Job_Type VARCHAR(255) = NULL,
    @Hiring_date DATE = NULL,
    @Job_title VARCHAR(255) = NULL,
    @Salary_Range VARCHAR(100) = NULL
AS
BEGIN TRY
    IF @Old_Com_ID IS NULL OR @Old_Grad_ID IS NULL
    BEGIN
        PRINT 'Old_Com_ID and Old_Grad_ID must not be NULL.'
        RETURN
    END
    
    SET @New_Com_ID = ISNULL(@New_Com_ID, @Old_Com_ID)
    SET @New_Grad_ID = ISNULL(@New_Grad_ID, @Old_Grad_ID)
    
    IF NOT EXISTS (SELECT 1 FROM Company WHERE Com_ID = @Old_Com_ID AND Grad_ID = @Old_Grad_ID)
    BEGIN
        PRINT 'Original record not found.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Graduates WHERE Grad_ID = @New_Grad_ID)
    BEGIN
        PRINT 'Invalid new Grad_ID - does not exist in Graduates table.'
        RETURN
    END
    
    IF (@New_Com_ID <> @Old_Com_ID OR @New_Grad_ID <> @Old_Grad_ID)
        AND EXISTS (SELECT 1 FROM Company WHERE Com_ID = @New_Com_ID AND Grad_ID = @New_Grad_ID)
    BEGIN
        PRINT 'New combination already exists in Company table.'
        RETURN
    END
    
    BEGIN TRANSACTION;
    
    IF @New_Com_ID <> @Old_Com_ID OR @New_Grad_ID <> @Old_Grad_ID
    BEGIN
        DECLARE @Current_Com_Name VARCHAR(255), @Current_C_City VARCHAR(255),
                @Current_Job_Type VARCHAR(255), @Current_Hiring_date DATE,
                @Current_Job_title VARCHAR(255), @Current_Salary_Range VARCHAR(100)
                
        SELECT 
            @Current_Com_Name = Com_Name,
            @Current_C_City = C_City,
            @Current_Job_Type = Job_Type,
            @Current_Hiring_date = Hiring_date,
            @Current_Job_title = Job_title,
            @Current_Salary_Range = Salary_Range
        FROM Company WHERE Com_ID = @Old_Com_ID AND Grad_ID = @Old_Grad_ID;
        
        DELETE FROM Company WHERE Com_ID = @Old_Com_ID AND Grad_ID = @Old_Grad_ID;
        
        INSERT INTO Company (
            Com_ID, Grad_ID, Com_Name, C_City, Job_Type, Hiring_date, Job_title, Salary_Range
        )
        VALUES (
            @New_Com_ID, @New_Grad_ID,
            ISNULL(@Com_Name, @Current_Com_Name),
            ISNULL(@C_City, @Current_C_City),
            ISNULL(@Job_Type, @Current_Job_Type),
            ISNULL(@Hiring_date, @Current_Hiring_date),
            ISNULL(@Job_title, @Current_Job_title),
            ISNULL(@Salary_Range, @Current_Salary_Range)
        );
    END
    ELSE
    BEGIN
        UPDATE Company
        SET 
            Com_Name = ISNULL(@Com_Name, Com_Name),
            C_City = ISNULL(@C_City, C_City),
            Job_Type = ISNULL(@Job_Type, Job_Type),
            Hiring_date = ISNULL(@Hiring_date, Hiring_date),
            Job_title = ISNULL(@Job_title, Job_title),
            Salary_Range = ISNULL(@Salary_Range, Salary_Range)
        WHERE Com_ID = @Old_Com_ID AND Grad_ID = @Old_Grad_ID;
    END
    
    COMMIT TRANSACTION;
    PRINT 'Company updated successfully.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'Error updating Company: ' + ERROR_MESSAGE();
END CATCH
GO

-- 8. Courses
CREATE OR ALTER PROCEDURE Update_Courses
    @Course_ID INT,
    @Course_Name VARCHAR(255) = NULL,
    @C_Status VARCHAR(50) = NULL,
    @C_duration VARCHAR(50) = NULL,
    @InstructorID INT = NULL
AS
BEGIN TRY
    IF @Course_ID IS NULL
    BEGIN
        PRINT 'Course_ID must not be NULL.'
        RETURN
    END

    IF @InstructorID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Instructor WHERE InstructorID = @InstructorID)
    BEGIN
        PRINT 'Invalid foreign key: InstructorID does not exist.'
        RETURN
    END

    UPDATE Courses
    SET 
        Course_Name = ISNULL(@Course_Name, Course_Name),
        C_Status = ISNULL(@C_Status, C_Status),
        C_duration = ISNULL(@C_duration, C_duration),
        InstructorID = ISNULL(@InstructorID, InstructorID)
    WHERE Course_ID = @Course_ID
END TRY
BEGIN CATCH
    PRINT 'Error updating Courses: ' + ERROR_MESSAGE();
END CATCH
GO

-- 9. Dependents
CREATE OR ALTER PROCEDURE Update_Dependents
    @Dep_ID INT,
    @InstructorID INT,
    @Dep_Name VARCHAR(255) = NULL,
    @Gender VARCHAR(50) = NULL,
    @Age INT = NULL
AS
BEGIN TRY
    IF @Dep_ID IS NULL OR @InstructorID IS NULL
    BEGIN
        PRINT 'Dep_ID and InstructorID must not be NULL.'
        RETURN
    END

    IF NOT EXISTS (SELECT 1 FROM Instructor WHERE InstructorID = @InstructorID)
    BEGIN
        PRINT 'Invalid foreign key: InstructorID does not exist.'
        RETURN
    END

    UPDATE Dependents
    SET 
        Dep_Name = ISNULL(@Dep_Name, Dep_Name),
        Gender = ISNULL(@Gender, Gender),
        Age = ISNULL(@Age, Age)
    WHERE Dep_ID = @Dep_ID AND InstructorID = @InstructorID
END TRY
BEGIN CATCH
    PRINT 'Error updating Dependents: ' + ERROR_MESSAGE();
END CATCH
GO

-- 10. Exam
CREATE OR ALTER PROCEDURE Update_Exam
    @Exam_ID INT,
    @Exam_Name VARCHAR(255) = NULL,
    @Exam_Duration VARCHAR(50) = NULL,
    @Exam_Date DATE = NULL,
    @Exam_Mark DECIMAL(5, 2) = NULL,
    @Exam_Level VARCHAR(50) = NULL
AS
BEGIN TRY
    IF @Exam_ID IS NULL
    BEGIN
        PRINT 'Exam_ID must not be NULL.'
        RETURN
    END

    UPDATE Exam
    SET 
        Exam_Name = ISNULL(@Exam_Name, Exam_Name),
        Exam_Duration = ISNULL(@Exam_Duration, Exam_Duration),
        Exam_Date = ISNULL(@Exam_Date, Exam_Date),
        Exam_Mark = ISNULL(@Exam_Mark, Exam_Mark),
        Exam_Level = ISNULL(@Exam_Level, Exam_Level)
    WHERE Exam_ID = @Exam_ID
END TRY
BEGIN CATCH
    PRINT 'Error updating Exam: ' + ERROR_MESSAGE();
END CATCH
GO

-- 11. Exam_Result
CREATE OR ALTER PROCEDURE Update_Exam_Result
    @Old_St_ID INT,
    @Old_Exam_ID INT,
    @Old_Course_ID INT,
    @New_St_ID INT = NULL,
    @New_Exam_ID INT = NULL,
    @New_Course_ID INT = NULL,
    @Exam_Date DATE = NULL,
    @Exam_Percentage DECIMAL(5, 2) = NULL,
    @Result VARCHAR(50) = NULL
AS
BEGIN TRY
    IF @Old_St_ID IS NULL OR @Old_Exam_ID IS NULL OR @Old_Course_ID IS NULL
    BEGIN
        PRINT 'Old_St_ID, Old_Exam_ID and Old_Course_ID must not be NULL.'
        RETURN
    END
    
    SET @New_St_ID = ISNULL(@New_St_ID, @Old_St_ID)
    SET @New_Exam_ID = ISNULL(@New_Exam_ID, @Old_Exam_ID)
    SET @New_Course_ID = ISNULL(@New_Course_ID, @Old_Course_ID)
    
    IF NOT EXISTS (SELECT 1 FROM Exam_Result WHERE St_ID = @Old_St_ID AND Exam_ID = @Old_Exam_ID AND Course_ID = @Old_Course_ID)
    BEGIN
        PRINT 'Original record not found.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Student WHERE St_ID = @New_St_ID)
    BEGIN
        PRINT 'Invalid new St_ID - does not exist in Student table.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Exam WHERE Exam_ID = @New_Exam_ID)
    BEGIN
        PRINT 'Invalid new Exam_ID - does not exist in Exam table.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Courses WHERE Course_ID = @New_Course_ID)
    BEGIN
        PRINT 'Invalid new Course_ID - does not exist in Courses table.'
        RETURN
    END
    
    IF (@New_St_ID <> @Old_St_ID OR @New_Exam_ID <> @Old_Exam_ID OR @New_Course_ID <> @Old_Course_ID)
        AND EXISTS (SELECT 1 FROM Exam_Result WHERE St_ID = @New_St_ID AND Exam_ID = @New_Exam_ID AND Course_ID = @New_Course_ID)
    BEGIN
        PRINT 'New combination already exists in Exam_Result table.'
        RETURN
    END
    
    BEGIN TRANSACTION;
    
    IF @New_St_ID <> @Old_St_ID OR @New_Exam_ID <> @Old_Exam_ID OR @New_Course_ID <> @Old_Course_ID
    BEGIN
        DECLARE @Current_Exam_Date DATE, @Current_Exam_Percentage DECIMAL(5, 2), @Current_Result VARCHAR(50)
                
        SELECT 
            @Current_Exam_Date = Exam_Date,
            @Current_Exam_Percentage = Exam_Percentage,
            @Current_Result = Result
        FROM Exam_Result WHERE St_ID = @Old_St_ID AND Exam_ID = @Old_Exam_ID AND Course_ID = @Old_Course_ID;
        
        DELETE FROM Exam_Result WHERE St_ID = @Old_St_ID AND Exam_ID = @Old_Exam_ID AND Course_ID = @Old_Course_ID;
        
        INSERT INTO Exam_Result (
            St_ID, Exam_ID, Course_ID, Exam_Date, Exam_Percentage, Result
        )
        VALUES (
            @New_St_ID, @New_Exam_ID, @New_Course_ID,
            ISNULL(@Exam_Date, @Current_Exam_Date),
            ISNULL(@Exam_Percentage, @Current_Exam_Percentage),
            ISNULL(@Result, @Current_Result)
        );
    END
    ELSE
    BEGIN
        UPDATE Exam_Result
        SET 
            Exam_Date = ISNULL(@Exam_Date, Exam_Date),
            Exam_Percentage = ISNULL(@Exam_Percentage, Exam_Percentage),
            Result = ISNULL(@Result, Result)
        WHERE St_ID = @Old_St_ID AND Exam_ID = @Old_Exam_ID AND Course_ID = @Old_Course_ID;
    END
    
    COMMIT TRANSACTION;
    PRINT 'Exam_Result updated successfully.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'Error updating Exam_Result: ' + ERROR_MESSAGE();
END CATCH
GO

-- 12. Faculties
CREATE OR ALTER PROCEDURE Update_Faculties
    @F_code INT,
    @F_Name VARCHAR(255) = NULL,
    @City VARCHAR(255) = NULL
AS
BEGIN TRY
    IF @F_code IS NULL
    BEGIN
        PRINT 'F_code must not be NULL.'
        RETURN
    END

    UPDATE Faculties
    SET 
        F_Name = ISNULL(@F_Name, F_Name),
        City = ISNULL(@City, City)
    WHERE F_code = @F_code
END TRY
BEGIN CATCH
    PRINT 'Error updating Faculties: ' + ERROR_MESSAGE();
END CATCH
GO

-- 13. Feedback
CREATE OR ALTER PROCEDURE Update_Feedback
    @Old_St_ID INT,
    @Old_InstructorID INT,
    @Old_Course_ID INT,
    @New_St_ID INT = NULL,
    @New_InstructorID INT = NULL,
    @New_Course_ID INT = NULL,
    @InstructorRating INT = NULL,
    @CourseRating INT = NULL,
    @Date DATE = NULL
AS
BEGIN TRY
    IF @Old_St_ID IS NULL OR @Old_InstructorID IS NULL OR @Old_Course_ID IS NULL
    BEGIN
        PRINT 'Old_St_ID, Old_InstructorID and Old_Course_ID must not be NULL.'
        RETURN
    END
    
    SET @New_St_ID = ISNULL(@New_St_ID, @Old_St_ID)
    SET @New_InstructorID = ISNULL(@New_InstructorID, @Old_InstructorID)
    SET @New_Course_ID = ISNULL(@New_Course_ID, @Old_Course_ID)
    
    IF NOT EXISTS (SELECT 1 FROM Feedback WHERE St_ID = @Old_St_ID AND InstructorID = @Old_InstructorID AND Course_ID = @Old_Course_ID)
    BEGIN
        PRINT 'Original record not found.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Student WHERE St_ID = @New_St_ID)
    BEGIN
        PRINT 'Invalid new St_ID - does not exist in Student table.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Instructor WHERE InstructorID = @New_InstructorID)
    BEGIN
        PRINT 'Invalid new InstructorID - does not exist in Instructor table.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Courses WHERE Course_ID = @New_Course_ID)
    BEGIN
        PRINT 'Invalid new Course_ID - does not exist in Courses table.'
        RETURN
    END
    
    IF (@New_St_ID <> @Old_St_ID OR @New_InstructorID <> @Old_InstructorID OR @New_Course_ID <> @Old_Course_ID)
        AND EXISTS (SELECT 1 FROM Feedback WHERE St_ID = @New_St_ID AND InstructorID = @New_InstructorID AND Course_ID = @New_Course_ID)
    BEGIN
        PRINT 'New combination already exists in Feedback table.'
        RETURN
    END
    
    BEGIN TRANSACTION;
    
    IF @New_St_ID <> @Old_St_ID OR @New_InstructorID <> @Old_InstructorID OR @New_Course_ID <> @Old_Course_ID
    BEGIN
        DECLARE @Current_InstructorRating INT, @Current_CourseRating INT, @Current_Date DATE
                
        SELECT 
            @Current_InstructorRating = InstructorRating,
            @Current_CourseRating = CourseRating,
            @Current_Date = Date
        FROM Feedback WHERE St_ID = @Old_St_ID AND InstructorID = @Old_InstructorID AND Course_ID = @Old_Course_ID;
        
        DELETE FROM Feedback WHERE St_ID = @Old_St_ID AND InstructorID = @Old_InstructorID AND Course_ID = @Old_Course_ID;
        
        INSERT INTO Feedback (
            St_ID, InstructorID, Course_ID, InstructorRating, CourseRating, Date
        )
        VALUES (
            @New_St_ID, @New_InstructorID, @New_Course_ID,
            ISNULL(@InstructorRating, @Current_InstructorRating),
            ISNULL(@CourseRating, @Current_CourseRating),
            ISNULL(@Date, @Current_Date)
        );
    END
    ELSE
    BEGIN
        UPDATE Feedback
        SET 
            InstructorRating = ISNULL(@InstructorRating, InstructorRating),
            CourseRating = ISNULL(@CourseRating, CourseRating),
            Date = ISNULL(@Date, Date)
        WHERE St_ID = @Old_St_ID AND InstructorID = @Old_InstructorID AND Course_ID = @Old_Course_ID;
    END
    
    COMMIT TRANSACTION;
    PRINT 'Feedback updated successfully.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'Error updating Feedback: ' + ERROR_MESSAGE();
END CATCH
GO

-- 14. Freelance
CREATE OR ALTER PROCEDURE Update_Freelance
    @Old_Task_title VARCHAR(255),
    @Old_St_ID INT,
    @New_Task_title VARCHAR(255) = NULL,
    @New_St_ID INT = NULL,
    @Related_Field VARCHAR(255) = NULL,
    @Task_Duration VARCHAR(50) = NULL,
    @Cost DECIMAL(10, 2) = NULL
AS
BEGIN TRY
    IF @Old_Task_title IS NULL OR @Old_St_ID IS NULL
    BEGIN
        PRINT 'Old_Task_title and Old_St_ID must not be NULL.'
        RETURN
    END
    
    SET @New_Task_title = ISNULL(@New_Task_title, @Old_Task_title)
    SET @New_St_ID = ISNULL(@New_St_ID, @Old_St_ID)
    
    IF NOT EXISTS (SELECT 1 FROM Freelance WHERE Task_title = @Old_Task_title AND St_ID = @Old_St_ID)
    BEGIN
        PRINT 'Original record not found.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Student WHERE St_ID = @New_St_ID)
    BEGIN
        PRINT 'Invalid new St_ID - does not exist in Student table.'
        RETURN
    END
    
    IF (@New_Task_title <> @Old_Task_title OR @New_St_ID <> @Old_St_ID)
        AND EXISTS (SELECT 1 FROM Freelance WHERE Task_title = @New_Task_title AND St_ID = @New_St_ID)
    BEGIN
        PRINT 'New combination already exists in Freelance table.'
        RETURN
    END
    
    BEGIN TRANSACTION;
    
    IF @New_Task_title <> @Old_Task_title OR @New_St_ID <> @Old_St_ID
    BEGIN
        DECLARE @Current_Related_Field VARCHAR(255), @Current_Task_Duration VARCHAR(50), @Current_Cost DECIMAL(10, 2)
                
        SELECT 
            @Current_Related_Field = Related_Field,
            @Current_Task_Duration = Task_Duration,
            @Current_Cost = Cost
        FROM Freelance WHERE Task_title = @Old_Task_title AND St_ID = @Old_St_ID;
        
        DELETE FROM Freelance WHERE Task_title = @Old_Task_title AND St_ID = @Old_St_ID;
        
        INSERT INTO Freelance (
            Task_title, St_ID, Related_Field, Task_Duration, Cost
        )
        VALUES (
            @New_Task_title, @New_St_ID,
            ISNULL(@Related_Field, @Current_Related_Field),
            ISNULL(@Task_Duration, @Current_Task_Duration),
            ISNULL(@Cost, @Current_Cost)
        );
    END
    ELSE
    BEGIN
        UPDATE Freelance
        SET 
            Related_Field = ISNULL(@Related_Field, Related_Field),
            Task_Duration = ISNULL(@Task_Duration, Task_Duration),
            Cost = ISNULL(@Cost, Cost)
        WHERE Task_title = @Old_Task_title AND St_ID = @Old_St_ID;
    END
    
    COMMIT TRANSACTION;
    PRINT 'Freelance updated successfully.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'Error updating Freelance: ' + ERROR_MESSAGE();
END CATCH
GO

-- 15. Graduates
CREATE OR ALTER PROCEDURE Update_Graduates
    @Grad_ID INT,
    @Grad_Name VARCHAR(255) = NULL,
    @Git_URL VARCHAR(255) = NULL,
    @LinkedIn_URL VARCHAR(255) = NULL,
    @Graduate_Date DATE = NULL,
    @Track_ID INT = NULL
AS
BEGIN TRY
    IF @Grad_ID IS NULL
    BEGIN
        PRINT 'Grad_ID must not be NULL.'
        RETURN
    END

    IF @Track_ID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Tracks WHERE Track_ID = @Track_ID)
    BEGIN
        PRINT 'Invalid foreign key: Track_ID does not exist.'
        RETURN
    END

    UPDATE Graduates
    SET 
        Grad_Name = ISNULL(@Grad_Name, Grad_Name),
        Git_URL = ISNULL(@Git_URL, Git_URL),
        LinkedIn_URL = ISNULL(@LinkedIn_URL, LinkedIn_URL),
        Graduate_Date = ISNULL(@Graduate_Date, Graduate_Date),
        Track_ID = ISNULL(@Track_ID, Track_ID)
    WHERE Grad_ID = @Grad_ID
END TRY
BEGIN CATCH
    PRINT 'Error updating Graduates: ' + ERROR_MESSAGE();
END CATCH
GO

-- 16. Instructor
CREATE OR ALTER PROCEDURE Update_Instructor
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
    @Salary DECIMAL(10, 2) = NULL,
    @ManagerID INT = NULL,
    @Phonenumber VARCHAR(20) = NULL
AS
BEGIN TRY
    IF @InstructorID IS NULL
    BEGIN
        PRINT 'InstructorID must not be NULL.'
        RETURN
    END

    IF @ManagerID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Instructor WHERE InstructorID = @ManagerID)
    BEGIN
        PRINT 'Invalid foreign key: ManagerID does not exist.'
        RETURN
    END

    UPDATE Instructor
    SET 
        Fname = ISNULL(@Fname, Fname),
        Lname = ISNULL(@Lname, Lname),
        Email = ISNULL(@Email, Email),
        City = ISNULL(@City, City),
        Street = ISNULL(@Street, Street),
        Zip_Code = ISNULL(@Zip_Code, Zip_Code),
        Gender = ISNULL(@Gender, Gender),
        BirthDate = ISNULL(@BirthDate, BirthDate),
        HiringDate = ISNULL(@HiringDate, HiringDate),
        Salary = ISNULL(@Salary, Salary),
        ManagerID = ISNULL(@ManagerID, ManagerID),
        Phonenumber = ISNULL(@Phonenumber, Phonenumber)
    WHERE InstructorID = @InstructorID
END TRY
BEGIN CATCH
    PRINT 'Error updating Instructor: ' + ERROR_MESSAGE();
END CATCH
GO

-- 17. Intake
CREATE OR ALTER PROCEDURE Update_Intake
    @Intake_ID INT,
    @Intake_Name VARCHAR(255) = NULL,
    @StartDate DATE = NULL,
    @EndDate DATE = NULL
AS
BEGIN TRY
    IF @Intake_ID IS NULL
    BEGIN
        PRINT 'Intake_ID must not be NULL.'
        RETURN
    END

    UPDATE Intake
    SET 
        Intake_Name = ISNULL(@Intake_Name, Intake_Name),
        StartDate = ISNULL(@StartDate, StartDate),
        EndDate = ISNULL(@EndDate, EndDate)
    WHERE Intake_ID = @Intake_ID
END TRY
BEGIN CATCH
    PRINT 'Error updating Intake: ' + ERROR_MESSAGE();
END CATCH
GO

-- 18. Master
CREATE OR ALTER PROCEDURE Update_Master
    @Old_Mas_title VARCHAR(255),
    @Old_Grad_ID INT,
    @New_Mas_title VARCHAR(255) = NULL,
    @New_Grad_ID INT = NULL,
    @Country VARCHAR(255) = NULL,
    @University VARCHAR(255) = NULL,
    @Field VARCHAR(255) = NULL
AS
BEGIN TRY
    IF @Old_Mas_title IS NULL OR @Old_Grad_ID IS NULL
    BEGIN
        PRINT 'Old_Mas_title and Old_Grad_ID must not be NULL.'
        RETURN
    END
    
    SET @New_Mas_title = ISNULL(@New_Mas_title, @Old_Mas_title)
    SET @New_Grad_ID = ISNULL(@New_Grad_ID, @Old_Grad_ID)
    
    IF NOT EXISTS (SELECT 1 FROM Master WHERE Mas_title = @Old_Mas_title AND Grad_ID = @Old_Grad_ID)
    BEGIN
        PRINT 'Original record not found.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Graduates WHERE Grad_ID = @New_Grad_ID)
    BEGIN
        PRINT 'Invalid new Grad_ID - does not exist in Graduates table.'
        RETURN
    END
    
    IF (@New_Mas_title <> @Old_Mas_title OR @New_Grad_ID <> @Old_Grad_ID)
        AND EXISTS (SELECT 1 FROM Master WHERE Mas_title = @New_Mas_title AND Grad_ID = @New_Grad_ID)
    BEGIN
        PRINT 'New combination already exists in Master table.'
        RETURN
    END
    
    BEGIN TRANSACTION;
    
    IF @New_Mas_title <> @Old_Mas_title OR @New_Grad_ID <> @Old_Grad_ID
    BEGIN
        DECLARE @Current_Country VARCHAR(255), @Current_University VARCHAR(255), @Current_Field VARCHAR(255)
                
        SELECT 
            @Current_Country = Country,
            @Current_University = University,
            @Current_Field = Field
        FROM Master WHERE Mas_title = @Old_Mas_title AND Grad_ID = @Old_Grad_ID;
        
        DELETE FROM Master WHERE Mas_title = @Old_Mas_title AND Grad_ID = @Old_Grad_ID;
        
        INSERT INTO Master (
            Mas_title, Grad_ID, Country, University, Field
        )
        VALUES (
            @New_Mas_title, @New_Grad_ID,
            ISNULL(@Country, @Current_Country),
            ISNULL(@University, @Current_University),
            ISNULL(@Field, @Current_Field)
        );
    END
    ELSE
    BEGIN
        UPDATE Master
        SET 
            Country = ISNULL(@Country, Country),
            University = ISNULL(@University, University),
            Field = ISNULL(@Field, Field)
        WHERE Mas_title = @Old_Mas_title AND Grad_ID = @Old_Grad_ID;
    END
    
    COMMIT TRANSACTION;
    PRINT 'Master updated successfully.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'Error updating Master: ' + ERROR_MESSAGE();
END CATCH
GO

-- 19. Questions
CREATE OR ALTER PROCEDURE Update_Questions
    @Question_ID INT,
    @Question_txt TEXT = NULL,
    @Correct_Answer VARCHAR(255) = NULL,
    @Question_Level VARCHAR(50) = NULL,
    @Question_Type VARCHAR(50) = NULL,
    @Course_ID INT = NULL
AS
BEGIN TRY
    IF @Question_ID IS NULL
    BEGIN
        PRINT 'Question_ID must not be NULL.'
        RETURN
    END

    IF @Course_ID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Courses WHERE Course_ID = @Course_ID)
    BEGIN
        PRINT 'Invalid foreign key: Course_ID does not exist.'
        RETURN
    END

    UPDATE Questions
    SET 
        Question_txt = ISNULL(@Question_txt, Question_txt),
        Correct_Answer = ISNULL(@Correct_Answer, Correct_Answer),
        Question_Level = ISNULL(@Question_Level, Question_Level),
        Question_Type = ISNULL(@Question_Type, Question_Type),
        Course_ID = ISNULL(@Course_ID, Course_ID)
    WHERE Question_ID = @Question_ID
END TRY
BEGIN CATCH
    PRINT 'Error updating Questions: ' + ERROR_MESSAGE();
END CATCH
GO

-- 20. Round
CREATE OR ALTER PROCEDURE Update_Round
    @Round_ID INT,
    @Round_Name VARCHAR(255) = NULL,
    @StartDate DATE = NULL,
    @EndDate DATE = NULL
AS
BEGIN TRY
    IF @Round_ID IS NULL
    BEGIN
        PRINT 'Round_ID must not be NULL.'
        RETURN
    END

    UPDATE Round
    SET 
        Round_Name = ISNULL(@Round_Name, Round_Name),
        StartDate = ISNULL(@StartDate, StartDate),
        EndDate = ISNULL(@EndDate, EndDate)
    WHERE Round_ID = @Round_ID
END TRY
BEGIN CATCH
    PRINT 'Error updating Round: ' + ERROR_MESSAGE();
END CATCH
GO

-- 21. St_Intake
CREATE OR ALTER PROCEDURE Update_St_Intake
    @Old_St_ID INT,
    @Old_Intake_ID INT,
    @New_St_ID INT = NULL,
    @New_Intake_ID INT = NULL
AS
BEGIN TRY
    IF @Old_St_ID IS NULL OR @Old_Intake_ID IS NULL
    BEGIN
        PRINT 'Old_St_ID and Old_Intake_ID must not be NULL.'
        RETURN
    END
    
    SET @New_St_ID = ISNULL(@New_St_ID, @Old_St_ID)
    SET @New_Intake_ID = ISNULL(@New_Intake_ID, @Old_Intake_ID)
    
    IF NOT EXISTS (SELECT 1 FROM St_Intake WHERE St_ID = @Old_St_ID AND Intake_ID = @Old_Intake_ID)
    BEGIN
        PRINT 'Original record not found.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Student WHERE St_ID = @New_St_ID)
    BEGIN
        PRINT 'Invalid new St_ID - does not exist in Student table.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Intake WHERE Intake_ID = @New_Intake_ID)
    BEGIN
        PRINT 'Invalid new Intake_ID - does not exist in Intake table.'
        RETURN
    END
    
    IF (@New_St_ID <> @Old_St_ID OR @New_Intake_ID <> @Old_Intake_ID)
        AND EXISTS (SELECT 1 FROM St_Intake WHERE St_ID = @New_St_ID AND Intake_ID = @New_Intake_ID)
    BEGIN
        PRINT 'New combination already exists in St_Intake table.'
        RETURN
    END
    
    BEGIN TRANSACTION;
    
    IF @New_St_ID <> @Old_St_ID OR @New_Intake_ID <> @Old_Intake_ID
    BEGIN
        DELETE FROM St_Intake WHERE St_ID = @Old_St_ID AND Intake_ID = @Old_Intake_ID;
        INSERT INTO St_Intake (St_ID, Intake_ID) VALUES (@New_St_ID, @New_Intake_ID);
    END
    
    COMMIT TRANSACTION;
    PRINT 'St_Intake updated successfully.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'Error updating St_Intake: ' + ERROR_MESSAGE();
END CATCH
GO

-- 22. St_Round
CREATE OR ALTER PROCEDURE Update_St_Round
    @Old_St_ID INT,
    @Old_Round_ID INT,
    @New_St_ID INT = NULL,
    @New_Round_ID INT = NULL
AS
BEGIN TRY
    IF @Old_St_ID IS NULL OR @Old_Round_ID IS NULL
    BEGIN
        PRINT 'Old_St_ID and Old_Round_ID must not be NULL.'
        RETURN
    END
    
    SET @New_St_ID = ISNULL(@New_St_ID, @Old_St_ID)
    SET @New_Round_ID = ISNULL(@New_Round_ID, @Old_Round_ID)
    
    IF NOT EXISTS (SELECT 1 FROM St_Round WHERE St_ID = @Old_St_ID AND Round_ID = @Old_Round_ID)
    BEGIN
        PRINT 'Original record not found.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Student WHERE St_ID = @New_St_ID)
    BEGIN
        PRINT 'Invalid new St_ID - does not exist in Student table.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Round WHERE Round_ID = @New_Round_ID)
    BEGIN
        PRINT 'Invalid new Round_ID - does not exist in Round table.'
        RETURN
    END
    
    IF (@New_St_ID <> @Old_St_ID OR @New_Round_ID <> @Old_Round_ID)
        AND EXISTS (SELECT 1 FROM St_Round WHERE St_ID = @New_St_ID AND Round_ID = @New_Round_ID)
    BEGIN
        PRINT 'New combination already exists in St_Round table.'
        RETURN
    END
    
    BEGIN TRANSACTION;
    
    IF @New_St_ID <> @Old_St_ID OR @New_Round_ID <> @Old_Round_ID
    BEGIN
        DELETE FROM St_Round WHERE St_ID = @Old_St_ID AND Round_ID = @Old_Round_ID;
        INSERT INTO St_Round (St_ID, Round_ID) VALUES (@New_St_ID, @New_Round_ID);
    END
    
    COMMIT TRANSACTION;
    PRINT 'St_Round updated successfully.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'Error updating St_Round: ' + ERROR_MESSAGE();
END CATCH
GO

-- 23. Stud_answers
CREATE OR ALTER PROCEDURE Update_Stud_answers
    @Old_St_ID INT,
    @Old_Question_ID INT,
    @Old_St_Answer VARCHAR(255),
    @New_St_ID INT = NULL,
    @New_Question_ID INT = NULL,
    @New_St_Answer VARCHAR(255) = NULL,
    @Ques_Grade DECIMAL(5, 2) = NULL,
    @Exam_ID INT = NULL
AS
BEGIN TRY
    IF @Old_St_ID IS NULL OR @Old_Question_ID IS NULL OR @Old_St_Answer IS NULL
    BEGIN
        PRINT 'Old_St_ID, Old_Question_ID and Old_St_Answer must not be NULL.'
        RETURN
    END
    
    SET @New_St_ID = ISNULL(@New_St_ID, @Old_St_ID)
    SET @New_Question_ID = ISNULL(@New_Question_ID, @Old_Question_ID)
    SET @New_St_Answer = ISNULL(@New_St_Answer, @Old_St_Answer)
    
    IF NOT EXISTS (SELECT 1 FROM Stud_answers WHERE St_ID = @Old_St_ID AND Question_ID = @Old_Question_ID AND St_Answer = @Old_St_Answer)
    BEGIN
        PRINT 'Original record not found.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Student WHERE St_ID = @New_St_ID)
    BEGIN
        PRINT 'Invalid new St_ID - does not exist in Student table.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Questions WHERE Question_ID = @New_Question_ID)
    BEGIN
        PRINT 'Invalid new Question_ID - does not exist in Questions table.'
        RETURN
    END
    
    IF @Exam_ID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Exam WHERE Exam_ID = @Exam_ID)
    BEGIN
        PRINT 'Invalid Exam_ID - does not exist in Exam table.'
        RETURN
    END
    
    IF (@New_St_ID <> @Old_St_ID OR @New_Question_ID <> @Old_Question_ID OR @New_St_Answer <> @Old_St_Answer)
        AND EXISTS (SELECT 1 FROM Stud_answers WHERE St_ID = @New_St_ID AND Question_ID = @New_Question_ID AND St_Answer = @New_St_Answer)
    BEGIN
        PRINT 'New combination already exists in Stud_answers table.'
        RETURN
    END
    
    BEGIN TRANSACTION;
    
    IF @New_St_ID <> @Old_St_ID OR @New_Question_ID <> @Old_Question_ID OR @New_St_Answer <> @Old_St_Answer
    BEGIN
        DECLARE @Current_Ques_Grade DECIMAL(5, 2), @Current_Exam_ID INT
                
        SELECT 
            @Current_Ques_Grade = Ques_Grade,
            @Current_Exam_ID = Exam_ID
        FROM Stud_answers WHERE St_ID = @Old_St_ID AND Question_ID = @Old_Question_ID AND St_Answer = @Old_St_Answer;
        
        DELETE FROM Stud_answers WHERE St_ID = @Old_St_ID AND Question_ID = @Old_Question_ID AND St_Answer = @Old_St_Answer;
        
        INSERT INTO Stud_answers (
            St_ID, Question_ID, St_Answer, Ques_Grade, Exam_ID
        )
        VALUES (
            @New_St_ID, @New_Question_ID, @New_St_Answer,
            ISNULL(@Ques_Grade, @Current_Ques_Grade),
            ISNULL(@Exam_ID, @Current_Exam_ID)
        );
    END
    ELSE
    BEGIN
        UPDATE Stud_answers
        SET 
            Ques_Grade = ISNULL(@Ques_Grade, Ques_Grade),
            Exam_ID = ISNULL(@Exam_ID, Exam_ID)
        WHERE St_ID = @Old_St_ID AND Question_ID = @Old_Question_ID AND St_Answer = @Old_St_Answer;
    END
    
    COMMIT TRANSACTION;
    PRINT 'Stud_answers updated successfully.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'Error updating Stud_answers: ' + ERROR_MESSAGE();
END CATCH
GO

-- 24. Stud_get_certificate
CREATE OR ALTER PROCEDURE Update_Stud_get_certificate
    @Old_St_ID INT,
    @Old_Cer_ID INT,
    @New_St_ID INT = NULL,
    @New_Cer_ID INT = NULL
AS
BEGIN TRY
    IF @Old_St_ID IS NULL OR @Old_Cer_ID IS NULL
    BEGIN
        PRINT 'Old_St_ID and Old_Cer_ID must not be NULL.'
        RETURN
    END
    
    SET @New_St_ID = ISNULL(@New_St_ID, @Old_St_ID)
    SET @New_Cer_ID = ISNULL(@New_Cer_ID, @Old_Cer_ID)
    
    IF NOT EXISTS (SELECT 1 FROM Stud_get_certificate WHERE St_ID = @Old_St_ID AND Cer_ID = @Old_Cer_ID)
    BEGIN
        PRINT 'Original record not found.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Student WHERE St_ID = @New_St_ID)
    BEGIN
        PRINT 'Invalid new St_ID - does not exist in Student table.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Certificates WHERE Cer_ID = @New_Cer_ID)
    BEGIN
        PRINT 'Invalid new Cer_ID - does not exist in Certificates table.'
        RETURN
    END
    
    IF (@New_St_ID <> @Old_St_ID OR @New_Cer_ID <> @Old_Cer_ID)
        AND EXISTS (SELECT 1 FROM Stud_get_certificate WHERE St_ID = @New_St_ID AND Cer_ID = @New_Cer_ID)
    BEGIN
        PRINT 'New combination already exists in Stud_get_certificate table.'
        RETURN
    END
    
    BEGIN TRANSACTION;
    
    IF @New_St_ID <> @Old_St_ID OR @New_Cer_ID <> @Old_Cer_ID
    BEGIN
        DELETE FROM Stud_get_certificate WHERE St_ID = @Old_St_ID AND Cer_ID = @Old_Cer_ID;
        INSERT INTO Stud_get_certificate (St_ID, Cer_ID) VALUES (@New_St_ID, @New_Cer_ID);
    END
    
    COMMIT TRANSACTION;
    PRINT 'Stud_get_certificate updated successfully.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'Error updating Stud_get_certificate: ' + ERROR_MESSAGE();
END CATCH
GO

-- 25. Student
CREATE OR ALTER PROCEDURE Update_Student
    @St_ID INT,
    @Fname VARCHAR(255) = NULL,
    @Lname VARCHAR(255) = NULL,
    @Phonenumber VARCHAR(20) = NULL,
    @Email VARCHAR(255) = NULL,
    @City VARCHAR(255) = NULL,
    @Street VARCHAR(255) = NULL,
    @Zip_Code VARCHAR(10) = NULL,
    @Gender VARCHAR(50) = NULL,
    @BirthDate DATE = NULL,
    @LinkedIn_URL VARCHAR(255) = NULL,
    @Graduation_Year INT = NULL,
    @Grade DECIMAL(4, 2) = NULL,
    @F_code INT = NULL,
    @Track_ID INT = NULL
AS
BEGIN TRY
    IF @St_ID IS NULL
    BEGIN
        PRINT 'St_ID must not be NULL.'
        RETURN
    END

    IF @F_code IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Faculties WHERE F_code = @F_code)
    BEGIN
        PRINT 'Invalid foreign key: F_code does not exist.'
        RETURN
    END

    IF @Track_ID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Tracks WHERE Track_ID = @Track_ID)
    BEGIN
        PRINT 'Invalid foreign key: Track_ID does not exist.'
        RETURN
    END

    UPDATE Student
    SET 
        Fname = ISNULL(@Fname, Fname),
        Lname = ISNULL(@Lname, Lname),
        Phonenumber = ISNULL(@Phonenumber, Phonenumber),
        Email = ISNULL(@Email, Email),
        City = ISNULL(@City, City),
        Street = ISNULL(@Street, Street),
        Zip_Code = ISNULL(@Zip_Code, Zip_Code),
        Gender = ISNULL(@Gender, Gender),
        BirthDate = ISNULL(@BirthDate, BirthDate),
        LinkedIn_URL = ISNULL(@LinkedIn_URL, LinkedIn_URL),
        Graduation_Year = ISNULL(@Graduation_Year, Graduation_Year),
        Grade = ISNULL(@Grade, Grade),
        F_code = ISNULL(@F_code, F_code),
        Track_ID = ISNULL(@Track_ID, Track_ID)
    WHERE St_ID = @St_ID
END TRY
BEGIN CATCH
    PRINT 'Error updating Student: ' + ERROR_MESSAGE();
END CATCH
GO

-- 26. Topics
CREATE OR ALTER PROCEDURE Update_Topics
    @Topic_ID INT,
    @Topic_Name VARCHAR(255) = NULL,
    @Course_ID INT = NULL
AS
BEGIN TRY
    IF @Topic_ID IS NULL
    BEGIN
        PRINT 'Topic_ID must not be NULL.'
        RETURN
    END

    IF @Course_ID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Courses WHERE Course_ID = @Course_ID)
    BEGIN
        PRINT 'Invalid foreign key: Course_ID does not exist.'
        RETURN
    END

    UPDATE Topics
    SET 
        Topic_Name = ISNULL(@Topic_Name, Topic_Name),
        Course_ID = ISNULL(@Course_ID, Course_ID)
    WHERE Topic_ID = @Topic_ID
END TRY
BEGIN CATCH
    PRINT 'Error updating Topics: ' + ERROR_MESSAGE();
END CATCH
GO

-- 27. Track_couseurs
CREATE OR ALTER PROCEDURE Update_Track_couseurs
    @Old_Track_ID INT,
    @Old_Course_ID INT,
    @New_Track_ID INT = NULL,
    @New_Course_ID INT = NULL
AS
BEGIN TRY
    IF @Old_Track_ID IS NULL OR @Old_Course_ID IS NULL
    BEGIN
        PRINT 'Old_Track_ID and Old_Course_ID must not be NULL.'
        RETURN
    END
    
    SET @New_Track_ID = ISNULL(@New_Track_ID, @Old_Track_ID)
    SET @New_Course_ID = ISNULL(@New_Course_ID, @Old_Course_ID)
    
    IF NOT EXISTS (SELECT 1 FROM Track_couseurs WHERE Track_ID = @Old_Track_ID AND Course_ID = @Old_Course_ID)
    BEGIN
        PRINT 'Original record not found.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Tracks WHERE Track_ID = @New_Track_ID)
    BEGIN
        PRINT 'Invalid new Track_ID - does not exist in Tracks table.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Courses WHERE Course_ID = @New_Course_ID)
    BEGIN
        PRINT 'Invalid new Course_ID - does not exist in Courses table.'
        RETURN
    END
    
    IF (@New_Track_ID <> @Old_Track_ID OR @New_Course_ID <> @Old_Course_ID)
        AND EXISTS (SELECT 1 FROM Track_couseurs WHERE Track_ID = @New_Track_ID AND Course_ID = @New_Course_ID)
    BEGIN
        PRINT 'New combination already exists in Track_couseurs table.'
        RETURN
    END
    
    BEGIN TRANSACTION;
    
    IF @New_Track_ID <> @Old_Track_ID OR @New_Course_ID <> @Old_Course_ID
    BEGIN
        DELETE FROM Track_couseurs WHERE Track_ID = @Old_Track_ID AND Course_ID = @Old_Course_ID;
        INSERT INTO Track_couseurs (Track_ID, Course_ID) VALUES (@New_Track_ID, @New_Course_ID);
    END
    
    COMMIT TRANSACTION;
    PRINT 'Track_couseurs updated successfully.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'Error updating Track_couseurs: ' + ERROR_MESSAGE();
END CATCH
GO

-- 28. Tracks
CREATE OR ALTER PROCEDURE Update_Tracks
    @Track_ID INT,
    @Track_Name VARCHAR(255) = NULL,
    @Track_Duration VARCHAR(50) = NULL,
    @InstructorID INT = NULL
AS
BEGIN TRY
    IF @Track_ID IS NULL
    BEGIN
        PRINT 'Track_ID must not be NULL.'
        RETURN
    END

    IF @InstructorID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Instructor WHERE InstructorID = @InstructorID)
    BEGIN
        PRINT 'Invalid foreign key: InstructorID does not exist.'
        RETURN
    END

    UPDATE Tracks
    SET 
        Track_Name = ISNULL(@Track_Name, Track_Name),
        Track_Duration = ISNULL(@Track_Duration, Track_Duration),
        InstructorID = ISNULL(@InstructorID, InstructorID)
    WHERE Track_ID = @Track_ID
END TRY
BEGIN CATCH
    PRINT 'Error updating Tracks: ' + ERROR_MESSAGE();
END CATCH
GO

-- 1. Answer_Choices
CREATE OR ALTER PROCEDURE Update_Answer_Choices
    @Old_Question_ID INT,
    @Old_Answer_Choice VARCHAR(255),
    @New_Question_ID INT = NULL,
    @New_Answer_Choice VARCHAR(255) = NULL
AS
BEGIN TRY
    IF @Old_Question_ID IS NULL OR @Old_Answer_Choice IS NULL
    BEGIN
        PRINT 'Old_Question_ID and Old_Answer_Choice must not be NULL.'
        RETURN
    END
    
    SET @New_Question_ID = ISNULL(@New_Question_ID, @Old_Question_ID)
    SET @New_Answer_Choice = ISNULL(@New_Answer_Choice, @Old_Answer_Choice)
    
    IF NOT EXISTS (SELECT 1 FROM Answer_Choices WHERE Question_ID = @Old_Question_ID AND Answer_Choice = @Old_Answer_Choice)
    BEGIN
        PRINT 'Original record not found.'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Questions WHERE Question_ID = @New_Question_ID)
    BEGIN
        PRINT 'Invalid new Question_ID - does not exist in Questions table.'
        RETURN
    END
    
    IF (@New_Question_ID <> @Old_Question_ID OR @New_Answer_Choice <> @Old_Answer_Choice)
        AND EXISTS (SELECT 1 FROM Answer_Choices WHERE Question_ID = @New_Question_ID AND Answer_Choice = @New_Answer_Choice)
    BEGIN
        PRINT 'New combination already exists in Answer_Choices table.'
        RETURN
    END
    
    BEGIN TRANSACTION;
    
    IF @New_Question_ID <> @Old_Question_ID OR @New_Answer_Choice <> @Old_Answer_Choice
    BEGIN
        DELETE FROM Answer_Choices WHERE Question_ID = @Old_Question_ID AND Answer_Choice = @Old_Answer_Choice;
        INSERT INTO Answer_Choices (Question_ID, Answer_Choice) VALUES (@New_Question_ID, @New_Answer_Choice);
    END
    
    COMMIT TRANSACTION;
    PRINT 'Answer_Choices updated successfully.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'Error updating Answer_Choices: ' + ERROR_MESSAGE();
END CATCH
GO
