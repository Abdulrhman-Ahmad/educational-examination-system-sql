-- returns the maximum and minimum degree of the instuctor course

create or alter proc sp_instructorID
		@name nvarchar(50),
		@result int OUTPUT		
		as 
		begin
			declare @InsID int
			select @InsID = ID from dbo.Instructor
			where Name = @name
			set @result = @InsID
		end	-- end sp_instructorCourse



 -- for reset the identity value
  DBCC CHECKIDENT ('[dbo].[Exam]', RESEED, 0);



