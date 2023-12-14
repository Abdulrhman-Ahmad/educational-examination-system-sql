--drop database ExaminationSystem
--  Database
CREATE DATABASE ExaminationSystem
ON PRIMARY (
		NAME = 'ExaminationSystem',
		FILENAME = N'D:\SQL Project\ExaminationSystem-Data.mdf',
		SIZE = 8MB, 
		FILEGROWTH = 10%,
		MAXSIZE = 50MB
) LOG ON (
		NAME = 'Net23-Company-Log',
		FILENAME = N'D:\SQL Project\ExaminationSystem-Log.Ldf',
		SIZE = 8MB,
		FILEGROWTH = 10%,
		MAXSIZE = 50MB
)
go
-----------------------------------------------------  instructor table
use ExaminationSystem
go
create table Instructor
(
	ID int  identity(1,1) not null,
	Name nvarchar(50) not null,
	Address nvarchar(50),
	Age int not null,
	Gender nchar(1),
	JobTitle nvarchar(20),
	
	-- adding constraint for instructor table [ primary key and check the gender ]
	constraint InstructorIDPK primary key (ID),
	constraint InstructorGenderCK check ( Gender in ( 'F', 'M'))

)
go
-----------------------------------------------------  intake table
create table Intake
(
	ID int identity(1,1) not null,
	IntakeYear date,

	-- adding constraint primary key 
	constraint IntakeIDPK primary key ( ID )
)
go
-----------------------------------------------------  student table
drop table Student
(
	ID int  identity(1,1) not null,
	Name nvarchar(50) not null,
	Address nvarchar(50),
	Age int not null,
	Gender nchar(1),
	Level int not null,
	IntakeID int,
	CourseID int,
	
	-- adding constraint for instructor table [ primary key and check the gender ]
	constraint StudentIDPK primary key (ID),
	constraint StudentGenderCK check ( Gender in ( 'F', 'M')),

	-- foreign key		
	constraint StudentIntakeIDFK foreign key (IntakeID) references Intake(ID)
	constraint StudentCourseIDFK foreign key (CourseID) references Courses(ID)
)
go
-----------------------------------------------------  Courses table
create table Courses
(
	ID int identity (1,1) not null,
	Name nvarchar(50),
	Title nvarchar(50),
	Max_Degree int,
	Min_Degree int,

	-- constraints
	constraint CourseIDPK primary key (ID)
)
go
-----------------------------------------------------  Exam table			
create table Exam
(
	ID int identity(1,1) not null,
	Type nvarchar(50),
	StartTime int,
	EndTime int,
	TotalTime int,
	TotalDegree int,

	-- constraints
	constraint ExamIDPK primary key (ID),
	constraint TypeCK check ( Type in ('corrective', 'exam'))
)
go
-----------------------------------------------------  Question table	
create table Question 
(
	ID int identity (1,1) not null,
	QuestionTitle nvarchar(max),
	Type nvarchar(50),
	QuestionAnswer nvarchar(max),
	CourseID int,

	-- constraint 
	constraint QuestionIDPK primary key (ID),
	constraint questionCourseIDFK foreign key (CourseID) references [dbo].[Courses](ID)
)



go
-----------------------------------------------------  Choices table 
create table Choices
(
	ID int identity (1,1) not null,
	ChoiceA nvarchar(max),
	ChoiceB nvarchar(max),
	ChoiceC nvarchar(max),
	ChoiceD nvarchar(max),
	QuestionID int,

	-- constraint 
	constraint ChoicesIDPK primary key (ID),
	constraint choicesQuesiontIDFK foreign key (QuestionID) references [dbo].[Question](ID)
)

go

-----------------------------------------------------  Branch table
create table Branch
(
	ID int identity (1,1) not null,
	Name nvarchar(50),
	Address nvarchar(50),
	IntakeID int,
	InstructorID int,
	
	-- primary constraint 
	constraint BranchIDPK primary key (ID),

	-- adding foreign key INAKE
	constraint BranchIntakeIDFK foreign key (IntakeID) references Intake(ID),
	constraint InstructorIDFK foreign key (InstructorID) references Instructor(ID)
)
go
-----------------------------------------------------  Department table
create table Department
(
	ID int identity (1,1) not null,
	Name nvarchar(50),
	IntakeID int,
	
	-- primary constraint 
	constraint DepartmentIDPK primary key (ID),

	-- adding foreign key INAKE
	constraint DepartmentIntakeIDFK foreign key (IntakeID) references Intake(ID)
)
go
-----------------------------------------------------  Track table
create table Track
(
	ID int identity (1,1) not null,
	Name nvarchar(50),
	IntakeID int,
	
	-- primary constraint 
	constraint TrackIDPK primary key (ID),

	-- adding foreign key INAKE
	constraint TrackIntakeIDFK foreign key (IntakeID) references Intake(ID)
)
go

-------------------------------------  [ RELATIONS ] ------------------------------------------


-----------------------------------------------------  Course_Instructor_Intake	table
create table Course_Instructor_Intake
(
	CourseID int,	
	IntakeID int,
	InstructorID int,

	constraint Course_Instructor_Intake_PK primary key (CourseID, IntakeID,InstructorID),

	-- adding foreign key 

	constraint Course_Instructor_IntakeCourseIDFK foreign key (CourseID) references Courses(ID),
	constraint Course_Instructor_IntakeIntakeIDFK foreign key (IntakeID) references Intake(ID),
	constraint Course_Instructor_IntakeInstructorIDFK foreign key (InstructorID) references Instructor(ID)

)
go
-----------------------------------------------------  Student_Exam_Question table		

create table Student_Exam_Question					
(
	ExamID		int,
	StudentID	int,
	QuestionID	int,
	StudentAnswer nvarchar(50),

	-- constraint
	constraint Student_Exam_QuestionPK primary key (StudentID, QuestionID, ExamID),
	
	constraint Student_Exam_QuestionStudentIDFK foreign key (StudentID) references Student(ID),
	constraint Student_Exam_QuestionQuestionIDFK foreign key (QuestionID) references Question(ID),
	constraint Student_Exam_QuestionExamIDFK foreign key (ExamID) references Exam(ID)
)
go
------------------------------------------------------------------------------------------------

create table Instructor_Exam_Question													
(
	InstructorID int,
	ExamID int,
	QuestionID int,
	QuestionDegree int,
	Year date, 
	Course nvarchar(50)

	constraint Instructor_Exam_QuestionPK primary key (InstructorID,ExamID,QuestionID),

	constraint Instructor_Exam_QuestionInstructorFK foreign key (InstructorID) references Instructor(ID),
	constraint Instructor_Exam_QuestionExamFK foreign key (ExamID) references Exam(ID),
	constraint Instructor_Exam_QuestionQuestionDegreeFK foreign key (QuestionDegree) references Question(ID)
)


