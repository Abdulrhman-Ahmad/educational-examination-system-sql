	------------------------ [ Training Manger ] ---------------------------

	-- Training Manger can control instructor table 
	grant select, delete, update, insert on [dbo].[Instructor] to Mirihan 

	-- Training Manger can control Courses Table 
	grant select, delete, update, insert on [dbo].[Exam] to Mirihan 

	-- Training Manger can edit and add to [ Branch, Department, Intake ] 
	grant select, update, insert on [dbo].[Branch] to Mirihan 
	grant select, update, insert on [dbo].[Department] to Mirihan 
	grant select, update, insert on [dbo].[Track] to Mirihan 

	-- Training Manger can Add new intake
	grant select, insert on [dbo].[Intake] to Mirihan 

	-- Training Manger can edit update on Student Table 
	grant select, update, insert on [dbo].[Student] to Mirihan 

	-- training  manger can access the view for the intake details and student details
	grant select on [dbo].[InTakeDetails] to Mirihan
	grant select on [dbo].[StudentDetails] to Mirihan


	------------------------ [ Instructors ] -------------------------------

	-- instructor can start picking exam questions -- create temp table and take its course questions
	grant exec on sp_instructorStartExam to Sarah 
	grant exec on sp_instructorStartExam to Nawal 
	grant exec on sp_instructorStartExam to Mirihan 

	-- instructor can pick questions from his course
	grant exec on sp_instructorPickQuestion to Sarah 
	grant exec on sp_instructorPickQuestion to Nawal 
	grant exec on sp_instructorPickQuestion to Mirihan 

	-- instructor can show the picked questions and [ left, total degrees ]
	grant exec on sp_ShowStatus to Sarah 
	grant exec on sp_ShowStatus to Nawal 
	grant exec on sp_ShowStatus to Mirihan 

	-- instructor can randomly choose questions
	grant exec on sp_instructorRandomPick to Sarah 
	grant exec on sp_instructorRandomPick to Nawal 
	grant exec on sp_instructorRandomPick to Mirihan 
		
	grant select, delete, alter, update on [dbo].[Instructor_Exam_Question] to Sarah 
	grant select, delete, alter, update on [dbo].[Instructor_Exam_Question] to Nawal 
	grant select, delete, alter, update on [dbo].[Instructor_Exam_Question] to Mirihan 
					   
	grant select, delete, alter, update on [dbo].[Exam] to Sarah 
	grant select, delete, alter, update on [dbo].[Exam] to Nawal 
	grant select, delete, alter, update on [dbo].[Exam] to Mirihan 

	-------------------- [ Student  ] --------------------------
	
	-- can start the exam get the questions of its course and put them in a temp table
	grant exec on sp_StudentStartExam to Abdo 
	grant exec on sp_StudentStartExam to Mohamed 
	grant exec on sp_StudentStartExam to Doha 

	-- student can answer the qeustions in the temp table by the question id and the answer of the selected question id
	grant exec on sp_StudentAnswerQuestion to Abdo 
	grant exec on sp_StudentAnswerQuestion to Mohamed 
	grant exec on sp_StudentAnswerQuestion to Doha 

	-- student can end the exam and let the system calculate the the total result and store it in the student question exam
	grant exec on sp_studentEndExam to Abdo 
	grant exec on sp_studentEndExam to Mohamed 
	grant exec on sp_studentEndExam to Doha 
	