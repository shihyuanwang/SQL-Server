-- Create Trigger 3 "ChangeSpotsLeft" / "ChangeSpotsLeft1": update SpotsLeft column in DynEnroll table after enrolling in and dropping the class

-- After enrollment

CREATE TRIGGER ChangeSpotsLeft      
ON Take_S
AFTER INSERT
AS
BEGIN
	declare @dyn int
	set @dyn = (select SpotsLeft from DynEnroll where TeachID = (select TeachID from inserted))
	set @dyn = @dyn - 1
	
	update DynEnroll
	set SpotsLeft = @dyn
	where TeachID = (select TeachID from inserted)
END

-----------------------

-- After dropping the class

CREATE TRIGGER ChangeSpotsLeft1     
ON Take_S
AFTER DELETE
AS
BEGIN
	declare @dyn int
	set @dyn = (select SpotsLeft from DynEnroll where TeachID = (select TeachID from deleted))
	set @dyn = @dyn + 1
	
	update DynEnroll
	set SpotsLeft = @dyn
	where TeachID = (select TeachID from deleted)
END