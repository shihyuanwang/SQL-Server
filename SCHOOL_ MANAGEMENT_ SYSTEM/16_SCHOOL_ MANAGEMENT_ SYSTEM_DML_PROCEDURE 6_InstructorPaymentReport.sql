-- Create Store Procedure 5 "InstructorPaymentReport": show transactions and balance in instructor's account

CREATE PROCEDURE InstructorPaymentReport @FirstName nvarchar(20), @LastName nvarchar(20)
AS
BEGIN
select i.InstructorID, i.FirstName, i.LastName, p.Amount, b.Balance, p.PaidTime
from Payment p join Balance b on p.PaymentID = b.PaymentId
     join Instructor i on p.InstructorID = i.InstructorID
where i.FirstName = @FirstName and  i.LastName = @LastName
END

-- Test

--select * from Instructor
exec InstructorPaymentReport Hew, Probate
