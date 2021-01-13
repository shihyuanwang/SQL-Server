-- Create Trigger1 "CalculateBalance": Payment transaction -> Calculate instructor's account balance of school -> Insert into Balance table

CREATE TRIGGER dbo.CalculateBalance
	ON dbo.Payment
	AFTER INSERT
AS
BEGIN

	Declare @Balance numeric(10,2)
	Declare @var numeric(10,2)

	set @var = (select TOP 1 Balance from Balance b join inserted i on b.InstructorID = i.InstructorID
				    Order by b.PaidTime DESC) 
	set @Balance = (select TOP 1 Amount from inserted i Order BY i.PaidTime DESC) + isnull(@var, 0)
	

	insert into dbo.Balance
	select i.PaymentID, i.InstructorID, @Balance, i.PaidTime
	from inserted i

END

-- Test
begin tran try1

insert into Payment values(19, 100, getdate())
insert into Payment values(20, 200, getdate())       
select * from Payment
select * from Balance

rollback tran try1