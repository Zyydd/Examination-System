CREATE PROC DynamicSelect_Company
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Company')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
 DynamicSelect_Company '*'

-------------------------------------------------------------Answer_Choices-------------------------------------------------------------


CREATE PROC DynamicSelect_Answer_Choices
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Answer_Choices')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_Answer_Choices '*'

-------------------------------------------------------------Attendance-------------------------------------------------------------------
CREATE PROC DynamicSelect_Attendance
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Attendance')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_Attendance '*'

-------------------------------------------------------------Branch----------------------------------------------------------------------
CREATE PROC DynamicSelect_Branch
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Branch')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_Branch '*'

-------------------------------------------------------------Branch_instructor-----------------------------------------------------------
CREATE PROC DynamicSelect_Branch_instructor
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Branch_instructor')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
 DynamicSelect_Branch_instructor '*'

-------------------------------------------------------------Branch_Track--------------------------------------------------------------
 CREATE PROC DynamicSelect_Branch_Track
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Branch_Track')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_Branch_Track '*'

-------------------------------------------------------------Certificates----------------------------------------------------------------
 CREATE PROC DynamicSelect_Certificates
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Certificates')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_Certificates'*'
-------------------------------------------------------------Courses--------------------------------------------------------------------
 CREATE PROC DynamicSelect_Courses
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Courses')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_Courses '*'


-------------------------------------------------------------Dependents--------------------------------------------------------------------
 CREATE PROC DynamicSelect_Dependents
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Dependents')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_Dependents '*'

-------------------------------------------------------------Exam----------------------------------------------------------------------

 CREATE PROC DynamicSelect_Exam
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Exam')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
 DynamicSelect_Exam '*'

 -------------------------------------------------------------Exam_Result----------------------------------------------------------------
 
 CREATE PROC DynamicSelect_Exam_Result
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Exam_Result')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
 DynamicSelect_Exam_Result '*'

 -------------------------------------------------------------Faculties---------------------------------------------------------------
  CREATE PROC DynamicSelect_Faculties
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Faculties')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
 DynamicSelect_Faculties '*'

 -------------------------------------------------------------Feedback-----------------------------------------------------------------
 CREATE PROC DynamicSelect_Feedback
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Feedback')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_Feedback '*'


-------------------------------------------------------------Freelance----------------------------------------------------------------
 CREATE PROC DynamicSelect_Freelance
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Freelance')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_Freelance '*'

-------------------------------------------------------------Graduates--------------------------------------------------------------------
 CREATE PROC DynamicSelect_Graduates
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Graduates')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_Graduates '*'


-------------------------------------------------------------Instructor------------------------------------------------------------------
 CREATE PROC DynamicSelect_Instructor
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Instructor')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_Instructor '*'

-------------------------------------------------------------Intake---------------------------------------------------------------------
 CREATE PROC DynamicSelect_Intake
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Intake')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_Intake '*'

-------------------------------------------------------------Master---------------------------------------------------------------------
 CREATE PROC DynamicSelect_Master
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Master')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
 DynamicSelect_Master '*'

 -------------------------------------------------------------Questions----------------------------------------------------------------
  CREATE PROC DynamicSelect_Questions
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Questions')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_Questions'*'

-------------------------------------------------------------Round---------------------------------------------------------------------
  CREATE PROC DynamicSelect_Round
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Round')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_Round '*'

-------------------------------------------------------------St_Intake------------------------------------------------------------------
  CREATE PROC DynamicSelect_St_Intake
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'St_Intake')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_St_Intake '*'

-------------------------------------------------------------St_Round--------------------------------------------------------------------
  CREATE PROC DynamicSelect_St_Round
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'St_Round')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_St_Round '*'

-------------------------------------------------------------Stud_answers------------------------------------------------------------------
  CREATE PROC DynamicSelect_Stud_answers
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Stud_answers')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_Stud_answers '*'

-------------------------------------------------------------Stud_get_certificate---------------------------------------------------
 CREATE PROC DynamicSelect_Stud_get_certificate
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Stud_get_certificate')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_Stud_get_certificate '*'

-------------------------------------------------------------Student-------------------------------------------------------------------
 CREATE PROC DynamicSelect_Student
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Student')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_Student '*'

-------------------------------------------------------------Topics----------------------------------------------------------------------
 CREATE PROC DynamicSelect_Topics
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Topics')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_Topics '*'

-------------------------------------------------------------Track_couseurs-------------------------------------------------------------
 CREATE PROC DynamicSelect_Track_couseurs
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Track_couseurs')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_Track_couseurs '*'



-------------------------------------------------------------Tracks---------------------------------------------------------------------
 CREATE PROC DynamicSelect_Tracks
    @Column VARCHAR(100) 
   
AS
BEGIN
    BEGIN TRY
        EXECUTE('SELECT ' + @Column + ' FROM ' + 'Tracks')
    END TRY
    BEGIN CATCH
        PRINT 'Invalid column name'
       
    END CATCH
END

--calling
DynamicSelect_Tracks '*'





