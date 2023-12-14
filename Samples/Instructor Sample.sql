-- exec sp_instructorStartExam 'exammmm', 8, 9, 60	-- check constraint

-- instructor start picking question for the specified exam
	exec sp_instructorStartExam 'exam', 8, 9, 60

-- instrucot pick questions for the exam [ manually ]
	exec sp_instructorPickQuestion 9, 10

-- show status after adding a question
	exec sp_ShowStatus

-- instructor pick questions for the exam [ randomlly ]
	exec sp_instructorRandomPick



-- training manger add students and instructors

-- view for the training manger to show the intake details
	--Select * from  InTakeDetails

-- view for the training manger to show the student details	-- not completed yet
	--Select * from  StudentDetails


	-- adding students

-- insert into dbo.Student values ('khled', 'cairo', 22, 'm', 2,14,1)
-- insert into dbo.Student values ('Said', 'cairo', 22, 'm', 2,14,1)

