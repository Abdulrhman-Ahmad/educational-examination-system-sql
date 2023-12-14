
create or alter proc sp_ShowStatus
as begin

		declare @currentUser nvarchar(50) = suser_name()
		declare @total int, @maxDegree int, @insID int, @numberOfQuestion int
		
		exec sp_instructorID @currentUser, @insID output
		exec sp_instructorCourse @currentUser, @maxDegree output

		select @total = sum([QuestionDegree]) from [dbo].[Instructor_Exam_Question]		-- sum all the questions' degree
		where InstructorID = @insID

		select @numberOfQuestion = count(QuestionID) from [dbo].[Instructor_Exam_Question] where InstructorID = @insID
		
		select @total as 'Total Degrees', @maxDegree - @total as 'Left', @numberOfQuestion as 'Total Picked'
		SELECT * FROM [dbo].[##QuestionToPick]
		select * from [dbo].[Instructor_Exam_Question] where InstructorID = @insID

end 