USE [graduation project]

-- ==================== INSTRUCTOR TABLE ====================
CREATE PROC delete_INSTRUCTOR 
@InstructorID INT = NULL
AS 
BEGIN TRY
    IF @InstructorID IS NULL
    BEGIN
        PRINT 'ENTER InstructorID'
    END
    ELSE
    IF NOT EXISTS (SELECT InstructorID FROM Instructor WHERE InstructorID = @InstructorID)
    BEGIN
        PRINT 'InstructorID does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Instructor WHERE InstructorID = @InstructorID
        PRINT 'Instructor deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Instructor - may be referenced by other records'
END CATCH

-- ==================== DEPENDENTS TABLE ====================
CREATE PROC delete_DEPENDENTS 
@Dep_ID INT = NULL,
@InstructorID INT = NULL
AS 
BEGIN TRY
    IF @Dep_ID IS NULL OR @InstructorID IS NULL
    BEGIN
        PRINT 'ENTER both Dep_ID and InstructorID'
    END
    ELSE
    IF NOT EXISTS (SELECT * FROM Dependents WHERE Dep_ID = @Dep_ID AND InstructorID = @InstructorID)
    BEGIN
        PRINT 'Dependent record does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Dependents WHERE Dep_ID = @Dep_ID AND InstructorID = @InstructorID
        PRINT 'Dependent deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Dependent'
END CATCH

-- ==================== STUDENT TABLE ====================
CREATE PROC delete_STUDENT 
@St_ID INT = NULL
AS 
BEGIN TRY
    IF @St_ID IS NULL
    BEGIN
        PRINT 'ENTER St_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT St_ID FROM Student WHERE St_ID = @St_ID)
    BEGIN
        PRINT 'St_ID does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Student WHERE St_ID = @St_ID
        PRINT 'Student deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Student - may be referenced by other records'
END CATCH

-- ==================== ST_INTAKE TABLE ====================
CREATE PROC delete_ST_INTAKE 
@St_ID INT = NULL,
@Intake_ID INT = NULL
AS 
BEGIN TRY
    IF @St_ID IS NULL OR @Intake_ID IS NULL
    BEGIN
        PRINT 'ENTER both St_ID and Intake_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT * FROM St_Intake WHERE St_ID = @St_ID AND Intake_ID = @Intake_ID)
    BEGIN
        PRINT 'St_Intake record does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM St_Intake WHERE St_ID = @St_ID AND Intake_ID = @Intake_ID
        PRINT 'St_Intake deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete St_Intake'
END CATCH

-- ==================== ATTENDANCE TABLE ====================
CREATE PROC delete_ATTENDANCE 
@Course_ID INT = NULL,
@St_ID INT = NULL
AS 
BEGIN TRY
    IF @Course_ID IS NULL OR @St_ID IS NULL
    BEGIN
        PRINT 'ENTER both Course_ID and St_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT * FROM Attendance WHERE Course_ID = @Course_ID AND St_ID = @St_ID)
    BEGIN
        PRINT 'Attendance record does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Attendance WHERE Course_ID = @Course_ID AND St_ID = @St_ID
        PRINT 'Attendance deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Attendance'
END CATCH

-- ==================== INTAKE TABLE ====================
CREATE PROC delete_INTAKE 
@Intake_ID INT = NULL
AS 
BEGIN TRY
    IF @Intake_ID IS NULL
    BEGIN
        PRINT 'ENTER Intake_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT Intake_ID FROM Intake WHERE Intake_ID = @Intake_ID)
    BEGIN
        PRINT 'Intake_ID does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Intake WHERE Intake_ID = @Intake_ID
        PRINT 'Intake deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Intake - may be referenced by other records'
END CATCH

-- ==================== ROUND TABLE ====================
CREATE PROC delete_ROUND 
@Round_ID INT = NULL
AS 
BEGIN TRY
    IF @Round_ID IS NULL
    BEGIN
        PRINT 'ENTER Round_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT Round_ID FROM Round WHERE Round_ID = @Round_ID)
    BEGIN
        PRINT 'Round_ID does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Round WHERE Round_ID = @Round_ID
        PRINT 'Round deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Round - may be referenced by other records'
END CATCH

-- ==================== ST_ROUND TABLE ====================
CREATE PROC delete_ST_ROUND 
@St_ID INT = NULL,
@Round_ID INT = NULL
AS 
BEGIN TRY
    IF @St_ID IS NULL OR @Round_ID IS NULL
    BEGIN
        PRINT 'ENTER both St_ID and Round_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT * FROM St_Round WHERE St_ID = @St_ID AND Round_ID = @Round_ID)
    BEGIN
        PRINT 'St_Round record does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM St_Round WHERE St_ID = @St_ID AND Round_ID = @Round_ID
        PRINT 'St_Round deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete St_Round'
END CATCH

-- ==================== FREELANCE TABLE ====================
CREATE PROC delete_FREELANCE 
@Task_title VARCHAR(255) = NULL,
@St_ID INT = NULL
AS 
BEGIN TRY
    IF @Task_title IS NULL OR @St_ID IS NULL
    BEGIN
        PRINT 'ENTER both Task_title and St_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT * FROM Freelance WHERE Task_title = @Task_title AND St_ID = @St_ID)
    BEGIN
        PRINT 'Freelance record does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Freelance WHERE Task_title = @Task_title AND St_ID = @St_ID
        PRINT 'Freelance deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Freelance'
END CATCH

-- ==================== CERTIFICATES TABLE ====================
CREATE PROC delete_CERTIFICATES 
@Cer_ID INT = NULL
AS 
BEGIN TRY
    IF @Cer_ID IS NULL
    BEGIN
        PRINT 'ENTER Cer_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT Cer_ID FROM Certificates WHERE Cer_ID = @Cer_ID)
    BEGIN
        PRINT 'Cer_ID does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Certificates WHERE Cer_ID = @Cer_ID
        PRINT 'Certificate deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Certificate - may be referenced by other records'
END CATCH

-- ==================== STUD_GET_CERTIFICATE TABLE ====================
CREATE PROC delete_STUD_GET_CERTIFICATE 
@St_ID INT = NULL,
@Cer_ID INT = NULL
AS 
BEGIN TRY
    IF @St_ID IS NULL OR @Cer_ID IS NULL
    BEGIN
        PRINT 'ENTER both St_ID and Cer_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT * FROM Stud_get_certificate WHERE St_ID = @St_ID AND Cer_ID = @Cer_ID)
    BEGIN
        PRINT 'Stud_get_certificate record does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Stud_get_certificate WHERE St_ID = @St_ID AND Cer_ID = @Cer_ID
        PRINT 'Stud_get_certificate deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Stud_get_certificate'
END CATCH

-- ==================== FACULTIES TABLE ====================
CREATE PROC delete_FACULTIES 
@F_code INT = NULL
AS 
BEGIN TRY
    IF @F_code IS NULL
    BEGIN
        PRINT 'ENTER F_code'
    END
    ELSE
    IF NOT EXISTS (SELECT F_code FROM Faculties WHERE F_code = @F_code)
    BEGIN
        PRINT 'F_code does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Faculties WHERE F_code = @F_code
        PRINT 'Faculty deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Faculty - may be referenced by other records'
END CATCH

-- ==================== TRACKS TABLE ====================
CREATE PROC delete_TRACKS 
@Track_ID INT = NULL
AS 
BEGIN TRY
    IF @Track_ID IS NULL
    BEGIN
        PRINT 'ENTER Track_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT Track_ID FROM Tracks WHERE Track_ID = @Track_ID)
    BEGIN
        PRINT 'Track_ID does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Tracks WHERE Track_ID = @Track_ID
        PRINT 'Track deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Track - may be referenced by other records'
END CATCH

-- ==================== GRADUATES TABLE ====================
CREATE PROC delete_GRADUATES 
@Grad_ID INT = NULL
AS 
BEGIN TRY
    IF @Grad_ID IS NULL
    BEGIN
        PRINT 'ENTER Grad_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT Grad_ID FROM Graduates WHERE Grad_ID = @Grad_ID)
    BEGIN
        PRINT 'Grad_ID does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Graduates WHERE Grad_ID = @Grad_ID
        PRINT 'Graduate deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Graduate - may be referenced by other records'
END CATCH

-- ==================== COMPANY TABLE ====================
CREATE PROC delete_COMPANY 
@Com_ID INT = NULL,
@Grad_ID INT = NULL
AS 
BEGIN TRY
    IF @Com_ID IS NULL OR @Grad_ID IS NULL
    BEGIN
        PRINT 'ENTER both Com_ID and Grad_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT * FROM Company WHERE Com_ID = @Com_ID AND Grad_ID = @Grad_ID)
    BEGIN
        PRINT 'Company record does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Company WHERE Com_ID = @Com_ID AND Grad_ID = @Grad_ID
        PRINT 'Company deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Company'
END CATCH

-- ==================== MASTER TABLE ====================
CREATE PROC delete_MASTER 
@Grad_ID INT = NULL,
@Mas_title VARCHAR(255) = NULL
AS 
BEGIN TRY
    IF @Grad_ID IS NULL OR @Mas_title IS NULL
    BEGIN
        PRINT 'ENTER both Grad_ID and Mas_title'
    END
    ELSE
    IF NOT EXISTS (SELECT * FROM Master WHERE Grad_ID = @Grad_ID AND Mas_title = @Mas_title)
    BEGIN
        PRINT 'Master record does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Master WHERE Grad_ID = @Grad_ID AND Mas_title = @Mas_title
        PRINT 'Master deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Master'
END CATCH

-- ==================== BRANCH TABLE ====================
CREATE PROC delete_BRANCH 
@Branch_ID INT = NULL
AS 
BEGIN TRY
    IF @Branch_ID IS NULL
    BEGIN
        PRINT 'ENTER Branch_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT Branch_ID FROM Branch WHERE Branch_ID = @Branch_ID)
    BEGIN
        PRINT 'Branch_ID does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Branch WHERE Branch_ID = @Branch_ID
        PRINT 'Branch deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Branch - may be referenced by other records'
END CATCH

-- ==================== BRANCH_INSTRUCTOR TABLE ====================
CREATE PROC delete_BRANCH_INSTRUCTOR 
@InstructorID INT = NULL,
@Branch_ID INT = NULL
AS 
BEGIN TRY
    IF @InstructorID IS NULL OR @Branch_ID IS NULL
    BEGIN
        PRINT 'ENTER both InstructorID and Branch_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT * FROM Branch_instructor WHERE InstructorID = @InstructorID AND Branch_ID = @Branch_ID)
    BEGIN
        PRINT 'Branch_instructor record does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Branch_instructor WHERE InstructorID = @InstructorID AND Branch_ID = @Branch_ID
        PRINT 'Branch_instructor deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Branch_instructor'
END CATCH

-- ==================== BRANCH_TRACK TABLE ====================
CREATE PROC delete_BRANCH_TRACK 
@Track_ID INT = NULL,
@Branch_ID INT = NULL
AS 
BEGIN TRY
    IF @Track_ID IS NULL OR @Branch_ID IS NULL
    BEGIN
        PRINT 'ENTER both Track_ID and Branch_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT * FROM Branch_Track WHERE Track_ID = @Track_ID AND Branch_ID = @Branch_ID)
    BEGIN
        PRINT 'Branch_Track record does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Branch_Track WHERE Track_ID = @Track_ID AND Branch_ID = @Branch_ID
        PRINT 'Branch_Track deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Branch_Track'
END CATCH

-- ==================== COURSES TABLE ====================
CREATE PROC delete_COURSES 
@Course_ID INT = NULL
AS 
BEGIN TRY
    IF @Course_ID IS NULL
    BEGIN
        PRINT 'ENTER Course_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT Course_ID FROM Courses WHERE Course_ID = @Course_ID)
    BEGIN
        PRINT 'Course_ID does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Courses WHERE Course_ID = @Course_ID
        PRINT 'Course deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Course - may be referenced by other records'
END CATCH

-- ==================== TRACK_COUSEURS TABLE ====================
CREATE PROC delete_TRACK_COUSEURS 
@Track_ID INT = NULL,
@Course_ID INT = NULL
AS 
BEGIN TRY
    IF @Track_ID IS NULL OR @Course_ID IS NULL
    BEGIN
        PRINT 'ENTER both Track_ID and Course_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT * FROM Track_couseurs WHERE Track_ID = @Track_ID AND Course_ID = @Course_ID)
    BEGIN
        PRINT 'Track_couseurs record does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Track_couseurs WHERE Track_ID = @Track_ID AND Course_ID = @Course_ID
        PRINT 'Track_couseurs deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Track_couseurs'
END CATCH

-- ==================== TOPICS TABLE ====================
CREATE PROC delete_TOPICS 
@Topic_ID INT = NULL
AS 
BEGIN TRY
    IF @Topic_ID IS NULL
    BEGIN
        PRINT 'ENTER Topic_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT Topic_ID FROM Topics WHERE Topic_ID = @Topic_ID)
    BEGIN
        PRINT 'Topic_ID does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Topics WHERE Topic_ID = @Topic_ID
        PRINT 'Topic deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Topic - may be referenced by other records'
END CATCH

-- ==================== FEEDBACK TABLE ====================
CREATE PROC delete_FEEDBACK 
@St_ID INT = NULL,
@InstructorID INT = NULL,
@Course_ID INT = NULL
AS 
BEGIN TRY
    IF @St_ID IS NULL OR @InstructorID IS NULL OR @Course_ID IS NULL
    BEGIN
        PRINT 'ENTER St_ID, InstructorID, and Course_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT * FROM Feedback WHERE St_ID = @St_ID AND InstructorID = @InstructorID AND Course_ID = @Course_ID)
    BEGIN
        PRINT 'Feedback record does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Feedback WHERE St_ID = @St_ID AND InstructorID = @InstructorID AND Course_ID = @Course_ID
        PRINT 'Feedback deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Feedback'
END CATCH

-- ==================== QUESTIONS TABLE ====================
CREATE PROC delete_QUESTIONS 
@Question_ID INT = NULL
AS 
BEGIN TRY
    IF @Question_ID IS NULL
    BEGIN
        PRINT 'ENTER Question_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT Question_ID FROM Questions WHERE Question_ID = @Question_ID)
    BEGIN
        PRINT 'Question_ID does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Questions WHERE Question_ID = @Question_ID
        PRINT 'Question deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Question - may be referenced by other records'
END CATCH

-- ==================== ANSWER_CHOICES TABLE ====================
CREATE PROC delete_ANSWER_CHOICES 
@Question_ID INT = NULL,
@Answer_Choice VARCHAR(255) = NULL
AS 
BEGIN TRY
    IF @Question_ID IS NULL OR @Answer_Choice IS NULL
    BEGIN
        PRINT 'ENTER both Question_ID and Answer_Choice'
    END
    ELSE
    IF NOT EXISTS (SELECT * FROM Answer_Choices WHERE Question_ID = @Question_ID AND Answer_Choice = @Answer_Choice)
    BEGIN
        PRINT 'Answer_Choice record does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Answer_Choices WHERE Question_ID = @Question_ID AND Answer_Choice = @Answer_Choice
        PRINT 'Answer_Choice deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Answer_Choice'
END CATCH

-- ==================== EXAM TABLE ====================
CREATE PROC delete_EXAM 
@Exam_ID INT = NULL
AS 
BEGIN TRY
    IF @Exam_ID IS NULL
    BEGIN
        PRINT 'ENTER Exam_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT Exam_ID FROM Exam WHERE Exam_ID = @Exam_ID)
    BEGIN
        PRINT 'Exam_ID does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Exam WHERE Exam_ID = @Exam_ID
        PRINT 'Exam deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Exam - may be referenced by other records'
END CATCH

-- ==================== EXAM_QUES TABLE ====================
CREATE PROC delete_EXAM_QUES 
@Exam_ID INT = NULL,
@Question_ID INT = NULL
AS 
BEGIN TRY
    IF @Exam_ID IS NULL OR @Question_ID IS NULL
    BEGIN
        PRINT 'ENTER both Exam_ID and Question_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT * FROM Exam_Ques WHERE Exam_ID = @Exam_ID AND Question_ID = @Question_ID)
    BEGIN
        PRINT 'Exam_Ques record does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Exam_Ques WHERE Exam_ID = @Exam_ID AND Question_ID = @Question_ID
        PRINT 'Exam_Ques deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Exam_Ques'
END CATCH

-- ==================== EXAM_RESULT TABLE ====================
CREATE PROC delete_EXAM_RESULT 
@St_ID INT = NULL,
@Exam_ID INT = NULL,
@Course_ID INT = NULL
AS 
BEGIN TRY
    IF @St_ID IS NULL OR @Exam_ID IS NULL OR @Course_ID IS NULL
    BEGIN
        PRINT 'ENTER St_ID, Exam_ID, and Course_ID'
    END
    ELSE
    IF NOT EXISTS (SELECT * FROM Exam_Result WHERE St_ID = @St_ID AND Exam_ID = @Exam_ID AND Course_ID = @Course_ID)
    BEGIN
        PRINT 'Exam_Result record does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Exam_Result WHERE St_ID = @St_ID AND Exam_ID = @Exam_ID AND Course_ID = @Course_ID
        PRINT 'Exam_Result deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Exam_Result'
END CATCH

-- ==================== STUD_ANSWERS TABLE ====================
CREATE PROC delete_STUD_ANSWERS 
@St_ID INT = NULL,
@Question_ID INT = NULL,
@St_Answer VARCHAR(255) = NULL
AS 
BEGIN TRY
    IF @St_ID IS NULL OR @Question_ID IS NULL OR @St_Answer IS NULL
    BEGIN
        PRINT 'ENTER St_ID, Question_ID, and St_Answer'
    END
    ELSE
    IF NOT EXISTS (SELECT * FROM Stud_answers WHERE St_ID = @St_ID AND Question_ID = @Question_ID AND St_Answer = @St_Answer)
    BEGIN
        PRINT 'Stud_answers record does not exist'
    END
    ELSE
    BEGIN
        DELETE FROM Stud_answers WHERE St_ID = @St_ID AND Question_ID = @Question_ID AND St_Answer = @St_Answer
        PRINT 'Stud_answers deleted successfully'
    END
END TRY 
BEGIN CATCH 
    PRINT 'Error: Cannot delete Stud_answers'
END CATCH