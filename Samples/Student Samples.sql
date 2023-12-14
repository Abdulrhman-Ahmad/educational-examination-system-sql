-- start exam copy instructor exam to a temp table and show it
	exec sp_StudentStartExam

-- answer each question individually with entering the question id and the answer character [ a, b, c, d, t, f ]
	exec sp_StudentAnswerQuestion 2, 'b'

	
-- calculate the correct answer and store the total result in the student exam question 
	exec sp_studentEndExam


-- view to show student result 
--






