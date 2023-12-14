create or alter proc sp_instructorRandomPick
as begin
declare @currentUser nvarchar(50) = suser_name()
declare @maxDegree int, @questionDegree int, @instructorID int, @randCounter int, @randNumber int
declare @start int, @end int, @QuestionNumber int

select top(1) @start = QuestionID from dbo.##questiontopick order by QuestionID ASC
select top(1) @end = QuestionID from dbo.##questiontopick order by QuestionID DESC

exec sp_instructorID @currentUser, @instructorID output

select @maxDegree = Max_Degree from dbo.Courses where ID = @instructorID

set @questionDegree = @maxDegree / 8

-- delete the instructor exam question where the instructor id equal to the current user
	delete from dbo.Instructor_Exam_Question where InstructorID = @instructorID
	
set @QuestionNumber = 1

-- setting random

while @QuestionNumber < 8
	begin
		set @randNumber = FLOOR(RAND() * (@end - @start + 1)) + @start;
		exec sp_instructorPickQuestion @randNumber, @questionDegree
		
		select @questionNumber = count([QuestionID]) from [dbo].[Instructor_Exam_Question]
		where InstructorID  = @instructorID

	end

	exec sp_showStatus


end