create or alter proc sp_studentEndExam
as begin
	---------------------------------------------------------------------------------------------
	-- declaring variables 
	declare @currentUser nvarchar(50) = suser_name()
	declare @StudentID int, @CourseID int, @ExamID int, @StudentResult int, @ExamTotalDegree int, @CorrectAnswer nchar(1)
	-- get the course and student IDs
	exec sp_StudentID @currentUser, @StudentID output, @CourseID output

	set @ExamTotalDegree = 0
	set @StudentResult  = 0

	---------------------------------------------------------------------------------------------
	-- check if the student exam data is existed before
	if exists(select * from dbo.Student_Exam_Question where StudentID = @StudentID)
	begin
		delete from dbo.Student_Exam_Question where StudentID = @StudentID
	end

	---------------------------------------------------------------------------------------------
	-- get the exam ID
	select top (1) @ExamID = icq.ExamID from dbo.Instructor as i
	join dbo.Course_Instructor_Intake as cit
	on cit.InstructorID = i.ID
	join dbo.Courses as c
	on c.ID = cit.CourseID and cit.CourseID = @CourseID
	join dbo.Instructor_Exam_Question as icq
	on icq.InstructorID = i.ID
	
	---------------------------------------------------------------------------------------------
	-- Cursor Section 
	declare @CursorAnswer nchar(1), @CursorID int, @CursorDegree int

	DECLARE vend_cursor CURSOR  
    FOR SELECT QuestionID, QuestionAnswer, QuestionDegree FROM   ##StudentExam

	OPEN vend_cursor
	
	-------
	FETCH NEXT FROM vend_cursor INTO @CursorID, @CursorAnswer, @CursorDegree ;

	------
	while @@FETCH_STATUS = 0
	begin
	
		set @ExamTotalDegree = @ExamTotalDegree + @CursorDegree
		
		-- take the question answer and question id and compare it with the correct answer 
		select @CorrectAnswer = QuestionAnswer from Question where ID = @CursorID

		if @CorrectAnswer = @CursorAnswer
		begin
			set @StudentResult = @StudentResult + @CursorDegree
		end

		FETCH NEXT FROM vend_cursor INTO @CursorID, @CursorAnswer, @CursorDegree ;

	end
	-------
	DEALLOCATE vend_cursor
	---------------------------------------------------------------------------------------------

	-- getting the questions and the answeres of the student from the temp table and paste it into the student question exam table and then we will calculate the total degrees for the student
	insert into dbo.Student_Exam_Question ([ExamID],[StudentID],[QuestionID],[StudentAnswer], [Result], [OutOf])
	select @ExamID ,@StudentID, QuestionID, QuestionAnswer, @StudentResult, @ExamTotalDegree from ##StudentExam

	select @StudentResult as 'Result' , @ExamTotalDegree as 'Out Of'

end
