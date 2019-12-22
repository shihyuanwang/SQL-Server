-- Create Store Procedure 5 "DropStudentsinDeficit": 
-- On the tuition payment deadline: if the status is 'Deficit' -> can't choose any classes (drop all enrolled classes)

CREATE PROCEDURE DropStudentsinDeficit
AS
BEGIN
	declare @max int
	set @max = (select max(TakeID) from Take_S)

	declare @i int
	set @i = (select min(TakeID) from Take_S)

	WHILE (@i <= @max)
	BEGIN
		IF EXISTS (select @i from Take_S)
	    BEGIN
		     delete from Take_S  
		     where StudentID in (select ts.StudentID from TuitionStatus ts where TheStatus = 'Deficit')
		     and TakeID = @i
		     set @i = @i + 1
	    END
	 END
END


-- Test

begin tran try1

select * from Take_S tks join TuitionStatus tus on tks.StudentID = tus.StudentID 
where tus.TheStatus = 'Deficit'

exec DropStudentsinDeficit
select * from Take_S

rollback tran try1
