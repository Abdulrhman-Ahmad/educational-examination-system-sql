-- add question with its degree in the 
create or alter proc sp_instructorPickQuestion
	@QuestionID int,
	@DegreeValue int
	as 
begin

	declare @currentUser nvarchar(50) = suser_name()
	declare @InsID int
	exec sp_instructorID @currentUser,@InsID OUTPUT
	insert into [dbo].[Instructor_Exam_Question] ([QuestionID],[QuestionDegree])
	values (@QuestionID, @DegreeValue)
	
		--select * from ##QuestionToPick
		--select * from [dbo].[Instructor_Exam_Question]

end



