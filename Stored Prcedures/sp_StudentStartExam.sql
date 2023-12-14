create or alter proc sp_StudentStartExam
as begin 

declare @currentUser nvarchar(50) = suser_name()
declare @studentID int, @courseID int

		--------------------------------------------------------------------------------------------
		-- get the id for the student and the course
		exec sp_StudentID @currentUser, @studentID output, @courseID output

		--------------------------------------------------------------------------------------------
		-- check if the table exists, if not create it
		if object_id(N'tempdb.dbo.##StudentExam') is null
			begin
				create table ##StudentExam   (StudentID int, QuestionID int, QuestionTitle nvarchar(max), QuestionType nvarchar(50), QuestionDegree int, QuestionAnswer nchar(1), a nvarchar(max), b nvarchar(max), c nvarchar(max), d nvarchar(max))
			end
		else
			begin
				if exists (select * from ##StudentExam)
					begin
						delete from ##StudentExam where StudentID = @studentID
					end

		end	-- end ####StudentExam

		--------------------------------------------------------------------------------------------
		-- getting the questions that belongs to that student to that temp table
		insert into ##StudentExam (StudentID, QuestionID, QuestionTitle, QuestionType, QuestionDegree, a, b, c, d)
		select @studentID, i.QuestionID, q.QuestionTitle, q.Type, i.QuestionDegree , c.ChoiceA, c.ChoiceB, c.ChoiceC, c.ChoiceD
		from dbo.Question as q
		join dbo.Instructor_Exam_Question as i
		on i.QuestionID = q.ID and i.InstructorID = @courseID		-- change it to currenUser
		join Choices as c
		on q.ID = c.QuestionID

		insert into ##StudentExam (StudentID, QuestionID, QuestionTitle, QuestionType, QuestionDegree)
		select @studentID, i.QuestionID, q.QuestionTitle, q.Type, i.QuestionDegree
		from dbo.Question as q
		join dbo.Instructor_Exam_Question as i
		on i.QuestionID = q.ID and i.InstructorID = @courseID and q.Type <> 'MCQ'

		-- getting the choices for each mcq Questions


			-- show exam for the student
			select QuestionID as 'id', QuestionTitle as 'title', QuestionType as 'type', QuestionDegree as 'degree', QuestionAnswer as 'answer',a,b,c,d from dbo.##studentExam

end