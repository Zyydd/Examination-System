
-------------------------------------------------------Stored_Report_1-------------------------------------------------

 CREATE OR ALTER PROCEDURE GetStudentsByDepartment2
    @DepartmentNo INT
AS
BEGIN
    SELECT 
        S.St_ID AS StudentID,
        S.Fname + ' ' + S.Lname AS FullName,
        S.Phonenumber,
        S.Email,
        S.City,
        S.Street,
        S.Zip_Code,
        S.Gender,
        S.BirthDate,
        S.LinkedIn_URL,
        S.Graduation_Year,
        S.Grade,
        T.Track_ID AS DepartmentNo,
        T.Track_Name AS DepartmentName
    FROM Student S
    INNER JOIN Tracks T ON S.Track_IDFK = T.Track_ID
    WHERE T.Track_ID = @DepartmentNo
END


GetStudentsByDepartment2 10

-------------------------------------------------------Stored_Report_2-------------------------------------------------
CREATE OR ALTER PROCEDURE GetStudentGrades
    @Student_ID INT
AS
BEGIN
	SELECT 
		s.Fname + ' ' + s.Lname AS Fullname,
		c.Course_Name AS [Course Name],
		CAST(er.Exam_Percentage AS VARCHAR(10)) + '%' AS [Grade Percentage]
		
	FROM Exam_Result er
	INNER JOIN Student s ON er.St_ID = s.St_ID
	INNER JOIN Courses c ON er.Course_ID = c.Course_ID
	WHERE er.St_ID = @Student_ID
END

EXEC GetStudentGrades 50

-------------------------------------------------------Stored_Report_3-------------------------------------------------
CREATE OR ALTER PROCEDURE GetCoursesAndStudentCountByInstructor
    @Instructor_ID INT
AS
BEGIN
    SELECT 
        I.Fname + ' ' + I.Lname AS InstructorName,
        C.Course_ID,
        C.Course_Name,
        COUNT(DISTINCT S.St_ID) AS [NumberOfStudents]
    FROM Instructor I
    INNER JOIN Courses C ON I.CourseID = C.Course_ID
    INNER JOIN Track_couseurs TC ON C.Course_ID = TC.Course_ID
    INNER JOIN Tracks T ON TC.Track_ID = T.Track_ID
    LEFT JOIN Student S ON S.Track_IDFK = T.Track_ID
    WHERE I.InstructorID = @Instructor_ID
    GROUP BY I.Fname, I.Lname, C.Course_ID, C.Course_Name
END



EXEC GetCoursesAndStudentCountByInstructor 100


-------------------------------------------------------Stored_Report_4-------------------------------------------------
CREATE OR ALTER PROCEDURE GetTopics
    @Course_ID INT
AS
BEGIN
	SELECT 
		c.Course_Name, 
		t.Topic_Name
	FROM Courses c
	INNER JOIN Topics t ON c.Course_ID = t.Course_ID
	WHERE c.Course_ID = @Course_ID
END


 GetTopics 6


-------------------------------------------------------Stored_Report_5-------------------------------------------------
CREATE OR ALTER PROCEDURE GetQandChoicesByExam
    @Exam_ID INT
AS
BEGIN
    SELECT 
        q.Question_ID,
        q.Question_txt AS Question_Text,
        ac.Answer_Choice AS Choice_Text
    FROM Stud_answers sa
    INNER JOIN Questions q ON sa.Question_ID = q.Question_ID
    INNER JOIN Answer_Choices ac ON q.Question_ID = ac.Question_ID
    WHERE sa.Exam_ID = @Exam_ID
    ORDER BY q.Question_ID
END


 GetQandChoicesByExam 10



-------------------------------------------------------Stored_Report_6-------------------------------------------------
CREATE OR ALTER PROCEDURE GetQuestionsAndAnswersByStudent
    @Student_ID INT,
    @Exam_ID INT
AS
BEGIN
	SELECT 
		
		s.Fname + ' ' + s.Lname AS Fullname,
	
		q.Question_txt AS Question_Text,
		sa.St_Answer AS Student_Answer,
		sa.Ques_Grade AS Question_Grade
	FROM Stud_answers sa
	INNER JOIN Student s ON sa.St_ID = s.St_ID
	INNER JOIN Questions q ON sa.Question_ID = q.Question_ID
	WHERE sa.St_ID = @Student_ID AND sa.Exam_ID = @Exam_ID
END

 GetQuestionsAndAnswersByStudent 1, 3













