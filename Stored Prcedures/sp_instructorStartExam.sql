-- used for intializing temp table for the picked questions and another temp table that store the questions that the instructor can pick from only
create or alter proc sp_instructorStartExam
@Type nvarchar(50),
@StartTime int,
@EndTime int,
@TotalTime int
as begin

		-- check if the table exists, if not create it
		if object_id(N'tempdb.dbo.##InstructorExam') is null
			begin
				create table ##InstructorExam (QuestionID int, degree int)
		end
		else
			begin
				if exists (select * from ##InstructorExam)
					begin
						delete from ##InstructorExam
					end

		end	-- end ##InstructorExam

		-----------------------------------------------------------------------------------------------

		-- in this table we put the questions that belongs to the course that the intructor is teaching 
		if object_id(N'tempdb.dbo.##QuestionToPick') is null
			begin	
				create table ##QuestionToPick (QuestionID int, QuestionName nvarchar(max), QuestionType nvarchar(50))
			end
		else
		begin 
			if exists (select * from ##QuestionToPick)
				begin
					delete from ##QuestionToPick
				end
	end	-- end ##QuestionToPick

	-----------------------------------------------------------------------------------------------

	
	-- getting the questions for the course that the current instructor is teaching
	-- get [ courseID ] and [ instructorID ]
	declare @courseID int
	declare @instructorID int
	declare @currentUser nvarchar(50) = suser_name()		
	select @courseID = cit.CourseID, @instructorID = i.ID from dbo.Instructor as i
	join dbo.Course_Instructor_Intake as cit
	on cit.InstructorID = i.ID
	join dbo.Courses as c
	on c.ID = cit.CourseID  and i.Name = @currentUser

	-- NEWLY
	-----------------------------------------------------------------------------------------------
	if exists(select * from [dbo].[Instructor_Exam_Question] where [InstructorID] = @instructorID)
	begin
		delete from [dbo].[Instructor_Exam_Question] where [InstructorID] = @instructorID
	end
	-----------------------------------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------
	if exists(select * from [dbo].[Student_Exam_Question] where ExamID = @instructorID)
	begin
		delete from [dbo].[Student_Exam_Question] where ExamID = @instructorID
	end
	-----------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------------
	if exists(select * from [dbo].Exam where ID = @instructorID)
	begin
		delete from [dbo].Exam where ID = @instructorID
	end

	-- inserting into the temp table the questions that belongs to the course that the instructor is teaching
	insert into ##QuestionToPick (QuestionID, QuestionName, QuestionType) 
	select ID,[QuestionTitle],[Type] from dbo.Question where CourseID = @courseID

			-- getting the max degree for the course
			declare @TotalDegree int
			select @TotalDegree = Max_Degree from dbo.Courses

			delete from dbo.Exam where ID = @instructorID

			SET IDENTITY_INSERT [dbo].[Exam] ON; 
			-- inserting into exam for the instructor with the instructor ID
			insert into [dbo].[Exam] ([ID],[Type],[StartTime],[EndTime],[TotalTime], [TotalDegree])
			values (@instructorID,@Type, @StartTime, @EndTime, @TotalTime, @TotalDegree)

			SET IDENTITY_INSERT [dbo].[Exam] OFF;	

			-- total picekd degrees, left, total number of picked questions
			exec sp_ShowStatus

	-- display the question of the instructor to pick from that belong to the course that he is teaching 
	-- in the global temp table questiontopick
	--select * from ##QuestionToPick
	--select * from [dbo].[Instructor_Exam_Question] where InstructorID = @instructorID

end	-- end sp_instructorStartExam