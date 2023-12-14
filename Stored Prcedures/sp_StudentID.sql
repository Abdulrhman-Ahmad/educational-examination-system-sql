create or alter proc sp_StudentID
@name nvarchar(50),
@StudentID int output,
@CourseID int output
as begin
select @StudentID = ID, @CourseID = CourseID from Student where Name = @name
end
