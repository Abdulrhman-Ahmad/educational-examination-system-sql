-- create new login 
use master
go
create login abdo with password = '12341234'
go

create server role limitation
alter server role limitation
add member abdo



exec sp_addrolemember 'limitation', 'abdo'
-- create a user for login abdo
use ITI
go
create user abdoUser for login abdo

exec sp_addrolemember 'abdoAccess', 'abdoUser'

-- view tempData

grant select on dbo.course to abdoAccess

grant update on dbo.course to abdoAccess

grant select on tempData to abdoAccess

deny select, update, delete, alter on database::ITI to abdoAccess

select * from dbo.Course

deny EXTERNAL ACCESS ASSEMBLY to limitation
deny IMPERSONATE ANY LOGIN to limitation

grant SELECT ALL USER SECURABLES to limitation
grant UNSAFE ASSEMBLY to limitation
grant VIEW ANY DATABASE  to limitation
grant VIEW ANY DEFINITION to limitation
grant VIEW SERVER STATE to limitation

-- empNo
go
create view empNo as
select Crs_Name as 'courses' from dbo.Course

grant select on dbo.department to abdoAccess
grant select on dbo.empNo to abdoAccess

deny select on [dbo].[Ins_Course] to abdoAccess


