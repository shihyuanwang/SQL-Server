-- Create Store Procedure 9 SalaryPayment (for Payment table)
-- "SalaryPayment1": Pay salary for one instructor per quarter, calculated by total teach fee, instructor's title, and service length 
-- "SalaryPaymentAll": Pay salaries for all instructors per quarter, calculated by total teach fee, instructor's title, and service length 

CREATE PROCEDURE SalaryPayment1 @InstructorID int, @quarters varchar(6), @years char(4) 
AS
BEGIN
declare @Salary numeric(10,2)
declare @TeachFee numeric(10,2)
declare @TitleFee numeric(10,2)
declare @ServiceLength numeric(10,2)

-- Total teach fee per quarter
set @TeachFee = isnull((select sum(c.TeachFee)
				from Teach_I t join Course c on t.CourseID = c.CourseID
				where InstructorID = @InstructorID
					  and t.Quarters = @quarters
					  and t.Years = @years
				group by InstructorID),0)

-- Salary based on instructor's title
if((select Title from Instructor where InstructorID = @InstructorID) = 'Professor')
set @TitleFee = 50000
if((select Title from Instructor where InstructorID = @InstructorID) = 'AssociateProfessor')
set @TitleFee = 40000
if((select Title from Instructor where InstructorID = @InstructorID) = 'AssistantProfessor')
set @TitleFee = 30000

-- Salary based on instructor's service length
declare @day datetime
set @day = (select EntryDate from Instructor where InstructorID = @InstructorID)
if(DATEDIFF(year, @day, getdate()) < 5)
set @ServiceLength = 2000
if(DATEDIFF(year, @day, getdate()) < 10 and DATEDIFF(year, @day, getdate()) >= 5)
set @ServiceLength = 3000
if(DATEDIFF(year, @day, getdate()) < 15 and DATEDIFF(year, @day, getdate()) >= 10)
set @ServiceLength = 4000
if(DATEDIFF(year, @day, getdate()) < 20 and DATEDIFF(year, @day, getdate()) >= 15)
set @ServiceLength = 5000
if(DATEDIFF(year, @day, getdate()) >= 20)
set @ServiceLength = 6000

-- Caculate total Salary for the instructor
set @Salary = @TeachFee + @TitleFee + @ServiceLength

insert into Payment
values(@InstructorID, @Salary, GETDATE())
END
-------------------------

CREATE PROCEDURE SalaryPaymentAll @quarters varchar(6), @years char(4) 
AS
BEGIN
	declare @max int
	set @max = (select max(InstructorID) from Instructor)

	declare @i int
	set @i = (select min(InstructorID) from Instructor)
	WHILE (@i <= @max)
	BEGIN
		IF EXISTS (select @i from Instructor)
	    BEGIN
		     exec SalaryPayment1 @i, @quarters, @years 
	    END
		set @i = @i + 1
	 END
END


--Test1
begin tran try1
exec SalaryPayment1 17, 'Spring', '2019'
select * from Payment
exec InstructorPaymentReport 'Karisa', 'Althrope'
select * from Department
rollback tran try1


--Test2
begin tran try2
exec SalaryPaymentAll 'Spring', '2019'
select * from Payment
select * from Balance
select * from Department
rollback tran try2