-- returns the maximum and minimum degree of the instuctor course

create or alter proc sp_instructorCourse
		@name nvarchar(50),
		@result1 int OUTPUT
		
		as 
		begin
			declare @degree int, @degree2 int
			select @degree = c.Max_Degree, @degree2 = c.Min_Degree from dbo.Instructor as i
			join dbo.Course_Instructor_Intake as cit
			on cit.InstructorID = i.ID
			join dbo.Courses as c
			on c.ID = cit.CourseID and i.Name = @name
			set @result1 = @degree
		end	-- end sp_instructorCourse