

-- =============================================
-- 1. Stored Procedure to Generate Exam Questions
-- =============================================
CREATE PROCEDURE sp_GenerateExamQuestions
    @CourseName NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT TOP 10 
        q.Question_ID, 
        q.Question_txt, 
        q.Correct_Answer, 
        q.Question_Level, 
        q.Question_Type
    FROM Questions q
    JOIN Courses c ON q.Course_ID = c.Course_ID
    ORDER BY NEWID()
END
GO

-- =============================================
-- 2. Stored Procedure to Insert Student Answer (without grade)
-- =============================================
CREATE PROCEDURE sp_InsertStudentAnswer
    @St_ID INT,
    @Question_ID INT,
    @St_Answer NVARCHAR(500),
    @Exam_ID INT
AS
BEGIN
    
    INSERT INTO Stud_answers (St_ID, Question_ID, St_Answer, Ques_Grade, Exam_ID)
    VALUES (@St_ID, @Question_ID, @St_Answer, null, @Exam_ID);
    
END
GO

-- =============================================
-- 3. Stored Procedure to Correct Answers and Update Grades
-- =============================================
CREATE or alter PROCEDURE sp_CorrectAnswersAndUpdateGrades
    @St_ID INT,
    @Exam_ID INT
AS
declare c1 cursor 
for select Question_ID,St_Answer,Ques_Grade from Stud_answers where Exam_ID=@Exam_ID and St_ID=@St_ID
for update 
declare @Question_ID int ,@St_Answer varchar(255),@Ques_Grade int 
open c1 
fetch c1 into  @Question_ID  ,@St_Answer ,@Ques_Grade 
while @@FETCH_STATUS=0
begin 
if @St_Answer=(select Correct_Answer from Questions where Question_ID=@Question_ID)
update Stud_answers
set Ques_Grade = 1 
where current of c1 
else 
update Stud_answers
set Ques_Grade = 0 
where current of c1
fetch c1 into  @Question_ID  ,@St_Answer ,@Ques_Grade 
end 
close c1 
deallocate c1

GO

-- =============================================
-- 4. Stored Procedure to Insert Exam Result
-- =============================================
CREATE or alter PROCEDURE sp_InsertExamResult
    @St_ID INT,
    @Exam_ID INT,
    @Course_ID INT
AS
begin

declare @questions_num int
select @questions_num = count(Question_ID) from Stud_answers where Exam_ID=@Exam_ID and St_ID=@St_ID

declare @total_grades int
select @total_grades = SUM(Ques_Grade) from Stud_answers where Exam_ID=@Exam_ID and St_ID=@St_ID

declare @exam_percantage decimal(5, 2)
select @exam_percantage = (@total_grades*100.0)/@questions_num


declare @result varchar(50)
if @exam_percantage >= 60 
select @result = 'PASS'
else 
select @result = 'FAIL'


insert into Exam_Result 
VALUES (@St_ID,@Exam_ID,@Course_ID,getdate(),@exam_percantage,@result)

select  @exam_percantage as Percantage ,
        @Result AS Result
end





