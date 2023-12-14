create or alter trigger checktotalTR
on [dbo].[Instructor_Exam_Question]
instead of insert 
as

-- getting the inserted value		-- [ QuestionID & Degree ]
declare @tableDegree table (id int, degree int)
insert into @tableDegree select QuestionID,QuestionDegree from inserted
declare @degree int, @id int, @instructorID int
select @degree = degree, @id = id from @tableDegree					-- got the id and degree of the question
declare @currentUser nvarchar(100) = suser_name()
exec sp_instructorID @currentUser, @instructorID output

-- getting the sum total value for the degrees in the testsum table 
declare @total int
select @total = sum([QuestionDegree]) from [dbo].[Instructor_Exam_Question]		-- sum all the questions' degree
where InstructorID = @instructorID

-- adding the inserted value to the totale stored degrees in testsum
set @total = @total + @degree

-- getting the max degree for instructor course
declare @maxDegree int

exec sp_instructorCourse @currentUser, @maxDegree output
--select @total AS 'TOTAL'
--select @maxDegree
declare @insID int
exec sp_instructorID @currentUser, @insID output

if @total > @maxDegree or @degree > 10 or @degree <= 1
	begin
		--print 'The total degrees is bigger than the Max_Degree for the course'
		THROW 50001, 'Degrees Overload', 16;
	end
else		
	begin
		
		if exists(select * from dbo.Instructor_Exam_Question where QuestionID = @id and InstructorID = @insID)
			begin
				delete from dbo.Instructor_Exam_Question where QuestionID = @id and InstructorID = @insID
			end
		
		declare @courseName nvarchar(50)
		select @courseName = c.Name from dbo.Course_Instructor_Intake as cit
		join dbo.Courses as c
		on c.ID = cit.CourseID and cit.InstructorID = @instructorID

		declare @courseid int

		select @courseid = ID from dbo.Courses where Name = @courseName

		insert into [dbo].[Instructor_Exam_Question]([InstructorID],[ExamID],[QuestionID],[QuestionDegree],[Year], [CourseID] )
		values (@insID,@insID,@id, @degree, getdate(), @courseid)

		select @total = sum([QuestionDegree]) from [dbo].[Instructor_Exam_Question]		-- sum all the questions' degree
		where InstructorID = @insID

		-- show total picked degrees, left, number of picked questions
		--exec sp_ShowStatus	
		--select @total as 'Total Degrees', @maxDegree - @total as 'Left'
		--SELECT * FROM [dbo].[##QuestionToPick]
		--select * from [dbo].[Instructor_Exam_Question] where InstructorID = @insID

	end





