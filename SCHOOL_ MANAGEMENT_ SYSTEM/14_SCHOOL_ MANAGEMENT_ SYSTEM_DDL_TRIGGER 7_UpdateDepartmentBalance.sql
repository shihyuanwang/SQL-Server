-- Create Trigger7 "UpdateDepartmentBalance": Payment transaction -> update balance of the department 

CREATE TRIGGER UpdateDepartmentBalance 
	ON dbo.Payment
	AFTER INSERT
AS
BEGIN
	declare @Amount numeric(10,2)
	set @Amount = (select Amount from inserted)

	declare @Balance numeric(10,2)
	set @Balance = (select Balance from Department where DepartmentID = 
					(select i2.DepartmentID from inserted i1 join Instructor i2
																on i1.InstructorID = i2.InstructorID))
	update Department
	set Balance = @Balance - @Amount
	where DepartmentID = (select i2.DepartmentID from inserted i1 join Instructor i2
																on i1.InstructorID = i2.InstructorID)
END


-- Test
begin tran try2
insert into Payment values(1, 1000, GETDATE())
select * from Payment
select * from Balance
select * from Department
rollback tran try2
