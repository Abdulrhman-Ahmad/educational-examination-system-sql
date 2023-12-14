-- this procedure take instructor name and return the max degree of the course that he is teching
-- @name is the name of the instructor
-- @result is the max degree of the exam
create or alter proc sp_instructorCourse
@name nvarchar(50),
@result int OUTPUT
as 
begin
	declare @degree int
	select @degree = c.Max_Degree from dbo.Instructor as i
	join dbo.Course_Instructor_Intake as cit
	on cit.InstructorID = i.ID
	join dbo.Courses as c
	on c.ID = cit.CourseID and i.Name = @name
	set @result = @degree
end
-------------------------------------------------------------------------------------------------

-- triger for cheking the total degree for the questions that the instructor pick and 
-- compare it with the max degree for the course that the instructorr teachs
create or alter trigger checktotalTR
on [dbo].[tesstsum]
instead of insert 
as

-- getting the inserted value
declare @d table (dd int)
insert into @d select * from inserted
declare @dd int
select @dd = dd from @d					-- @dd is the inserted value 

-- getting the sum total value for the degrees in the testsum table 
declare @total int
select @total = sum([degree]) from [dbo].[tesstsum]

-- adding the inserted value to the totale stored degrees in testsum
set @total = @total + @dd

-- getting the max degree for instructor course
declare @rr int
declare @currentUser nvarchar(50) = suser_name()
 exec sp_instructorCourse @currentUser, @rr output

if @total > @rr
begin
print 'The total degrees is bigger than the Max_Degree for the course'
end
else 
begin
	
	insert into [dbo].[tesstsum] ([degree])
	values (@dd)
	print 'here'
end
----------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- adding intake date from 2010 to 2023
declare @date date = '2010'
while @date != '2024'
begin
insert into [ExaminationSystem].[dbo].[Intake] values (@date)
set @date = dateadd(year, 1, @date)
-----------------------------------------------------------------------------------





-- just for testing on this table 
create table tesstsum
(degree int)


INSERT INTO DBO.tesstsum VALUES (10)

delete from dbo.tesstsum