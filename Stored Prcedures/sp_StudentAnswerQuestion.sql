create or alter proc sp_StudentAnswerQuestion
@QuestionID int,
@QuestionAnswer nchar(1)
as begin
	
	-- get the type of the answered question to check the answer parameter value if not obtained
	declare @type nvarchar(50)
	select @type = Type from dbo.Question where ID = @QuestionID

	-- condition to make sure that the input value is in the choices or true and false
	if (@type = 'MCQ' and @QuestionAnswer in ('a', 'b', 'c', 'd'))  
		begin
			update ##StudentExam
			set QuestionAnswer = @QuestionAnswer
			where QuestionID = @QuestionID
			select QuestionID as 'id', QuestionTitle as 'title', QuestionType as 'type', QuestionDegree as 'degree', QuestionAnswer as 'answer',a,b,c,d from dbo.##studentExam
		end
	else if (@type = 'True & False' and @QuestionAnswer in ('t', 'f'))
		begin
			update ##StudentExam
			set QuestionAnswer = @QuestionAnswer
			where QuestionID = @QuestionID
			select QuestionID as 'id', QuestionTitle as 'title', QuestionType as 'type', QuestionDegree as 'degree', QuestionAnswer as 'answer',a,b,c,d from dbo.##studentExam
		end
	else
		begin	
			   THROW 50002, 'Not Obtained Answer', 1
		end
		
end