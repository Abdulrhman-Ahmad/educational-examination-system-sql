


-- View To Display InTake Details
Create View InTakeDetails
as
Select b.[Name]'Branch Name' ,
i.[IntakeYear]'Intak Year' ,
t.[Name]' Track Name'
from [dbo].[Branch] b , [dbo].[Intake] i , [dbo].[Track] t
where b.IntakeID=i.[ID]
and i.ID = t.IntakeID
Go 

Select * from  InTakeDetails;

Go
-- View To Display Student Details
Create or alter View StudentDetails
As
select s.[Name] 'Student Name' ,
s.[Address]  'Student Address', 
s.[Age]'Age' ,
s.[Gender] 'Gender' ,
s.[Level] 'Level',
b.[Name]'Branch Name' ,
i.[IntakeYear]'Intak Year' ,
t.[Name]' Track Name'
from [dbo].[Student] s ,[dbo].[Branch] b, [dbo].[Intake] i, [dbo].[Track] t
where s.IntakeID=i.ID And  b.IntakeID=i.[ID]
And i.ID = t.IntakeID and s.CourseID in (select CourseID from dbo.Courses)

Go 

Select * from  StudentDetails;



;