-- Create Trigger 2 "TeachCheck": Check no conflict in inserted information in Teach_I table

CREATE TRIGGER TeachCheck
ON Teach_I
INSTEAD OF INSERT
AS
BEGIN
	-- conflict of time and classroom
	declare @num1 int
	set @num1 = (select count(*)
				from inserted i join Teach_I ti
				on i.Quarters = ti.Quarters  and i.Years = ti.Years and 
				   i.CourseTime = ti.CourseTime and i.ClassroomID = ti.ClassroomID)
	if(@num1 > 0)
	select getdate() as ErrorTime, 'Classroom is occupied at the time!' as Error
    
	-- conflict of instructor and time
	declare @num2 int
	set @num2 = (select count(*)
				 from inserted i join Teach_I ti
				 on i.InstructorID = ti.InstructorID and i.Quarters = ti.Quarters
				 and i.Years = ti.Years and i.CourseTime = ti.CourseTime)
	if(@num2 > 0)
	select getdate() as ErrorTime, 'Instructor cannot teach 2 classes at the same time!' as Error

	-- instructor cannot teach the class in department he/she is not in
	declare @a int
	declare @b int
	set @a = (select c.DepartmentID
			  from inserted i join course c on i.CourseID = c.CourseID)
	set @b = (select ins.DepartmentID
			  from inserted i join Instructor ins on i.InstructorID = ins.InstructorID)
	if (@a != @b)
	select getdate() as ErrorTime, 'Instructor cannot teach the class in department he/she is not in!' as Error

	if(@num1 = 0 and @num2 = 0 and @a = @b)
	insert into Teach_I
	select CourseID, InstructorID, Quarters, Years, CourseTime, ClassroomID, Capacity
	from inserted
END


-- test
begin tran try1
insert into Teach_I values(1, 1, 'Spring', '2019', '8:00', 1, 20)
insert into Teach_I values(1, 2, 'Spring', '2019', '8:00', 1, 20)
insert into Teach_I values(1, 3, 'Spring', '2019', '8:00', 1, 20)
insert into Teach_I values(2, 2, 'Spring', '2019', '8:00', 2, 20)

select * from Teach_I
rollback tran try1