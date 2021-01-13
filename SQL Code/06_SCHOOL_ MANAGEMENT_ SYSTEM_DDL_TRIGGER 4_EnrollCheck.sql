-- Create Trigger 4 "EnrollCheck": Check no conflict in inserted information in Take_S table

CREATE TRIGGER EnrollCheck
ON Take_S
INSTEAD OF INSERT
AS
BEGIN
	-- course validation check
	declare @num3 int
	set @num3 = (select count(*)
	             from inserted i join ListOfClasses2019 lc on i.TeachID = lc.TeachID)
	if(@num3 = 0)
	select GETDATE() as ErrorTime, 'No such courses in 2019!' as Error
	
	-- capacity check
	declare @dyn int
	set @dyn = (select SpotsLeft from DynEnroll where TeachID = (select TeachID from inserted))
	if (@dyn = 0)
	select GETDATE() as ErrorTime, 'The class is Full!' as Error

	-- repeated enrollment check
	declare @num2 int
	set @num2 = (select count(*)
	             from Take_S ts join inserted i 
				 on ts.TeachID = i.TeachID and ts.StudentID = i.StudentID)
	if(@num2 != 0)
	select GETDATE() as ErrorTime, 'Already enrolled!' as Error

	-- time conflict check
	declare @num1 int
	set @num1 = (select count(*)
	             from Take_S ts join ListOfClasses2019 lc on ts.TeachID = lc.TeachID
				 where ts.StudentID = (select StudentID from inserted) and
				       lc.CourseTime = (select lc1.CourseTime from inserted i1 join ListOfClasses2019 lc1
					                    on i1.TeachID = lc1.TeachID ) and
					   lc.Term = (select lc2.Term from inserted i2 join ListOfClasses2019 lc2
					                    on i2.TeachID = lc2.TeachID))
	if(@num1 != 0)
	select GETDATE() as ErrorTime, 'Time Conlict!' as Error
	

	if(@dyn != 0 and @num1 = 0 and @num2 = 0 and @num3 != 0)
	insert into Take_S(StudentID, TeachID)
	select StudentID, TeachID
	from inserted
END