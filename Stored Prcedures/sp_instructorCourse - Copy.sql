-- take the name and return CourseId

create or alter proc sp_instructorID
		@name nvarchar(50),
		@result int OUTPUT		
		as 
		begin
			declare @InsID int
			select @InsID = cit.InstructorID from dbo.Instructor as i
			join dbo.Course_Instructor_Intake as cit
			on cit.InstructorID = i.ID
			join dbo.Courses as c
			on c.ID = cit.CourseID and i.Name = @name
			set @result = @InsID
		end	-- end sp_instructorCourse