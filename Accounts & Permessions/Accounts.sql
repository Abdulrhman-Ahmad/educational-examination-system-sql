use master
go

--------------------- [ Instructor ] --------------------------
-- creating three instructors accounts for sarah, nawal, mirihan
create login Mirihan with password = '1234'						-- [ Training Manger ]
create login Nawal with password = '1234'
create login Sarah with password = '1234'

go 
use ExaminationSystem	
go
-- creating user name for each instructor with the same name
create user Mirihan for login Mirihan
create user Nawal for login Nawal
create user Sarah for login Sarah
-------------------------------------------------------------------------
go
use master 
go


--------------------- [ Student ] --------------------------
-- creating login accounts for students abdulrahman, mohamed, doha
create login Abdo with password = '1234'
create login Mohamed with password = '1234'
create login Doha with password = '1234'
go
use ExaminationSystem
go
-- creating user name for each student account
create user Abdo for login Abdo
create user Mohamed for login Mohamed
create user Doha for login Doha



