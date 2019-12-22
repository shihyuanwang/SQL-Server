-- Create Store Procedure 4 TuitionCheck (for TuitionStatus table)
-- "TuitionCheck1": insert or update tuition status information of a student in TuitionStatus table
-- "TuitionCheckAll": check all students' tuition status, execute TuitionCheck1, and return students whose tuition(study fee) has not been paid yet

CREATE PROCEDURE TuitionCheck1 @StudentID int
AS
BEGIN
	declare @Paid numeric(10,2) -- Total paid tuition
	set @Paid = (select sum(Amount) from Tuition where StudentID = @StudentID)
	
	declare @Payable numeric(10,2)  -- Total tuition(StudyFee) payable
	declare @StagingVar numeric(10,2)
	set @StagingVar = (select sum(c.StudyFee)
				    	from Take_S ts join Teach_I ti on ts.TeachID = ti.TeachID
						 join Course c on ti.CourseID = c.CourseID
					   where ts.StudentID = @StudentID)
	set @Payable = isnull(@StagingVar,0)
	
	IF EXISTS (select StudentID from TuitionStatus where StudentID = @StudentID)
	BEGIN
	    if(@Paid < @Payable) 
	    update TuitionStatus set Paid = @Paid, Payable = @Payable, TheStatus = 'Deficit' 
		where StudentID = @StudentID

	    if(@Paid < @Payable)
	    select * from TuitionStatus where StudentID = @StudentID  -- only show students whose tuition(study fee) has not been paid yet

	    if(@Paid > @Payable)
	    update TuitionStatus set Paid = @Paid, Payable = @Payable, TheStatus = 'Surplus' 
		where StudentID = @StudentID

	    if(@Paid = @Payable)
	    update TuitionStatus set Paid = @Paid, Payable = @Payable, TheStatus = 'Equilibrium' 
		where StudentID = @StudentID
	END
	
	Else
	BEGIN
	    if(@Paid < @Payable) 
	    insert into TuitionStatus values(@StudentID, @Paid, @Payable, 'Deficit')

	    if(@Paid < @Payable)
	    select * from TuitionStatus where StudentID = @StudentID  -- only show students whose tuition(study fee) has not been paid yet

	    if(@Paid > @Payable)
	    insert into TuitionStatus values(@StudentID, @Paid, @Payable, 'Surplus') 

	    if(@Paid = @Payable)
	    insert into TuitionStatus values(@StudentID, @Paid, @Payable, 'Equilibrium')
	END
END

----------------------

CREATE PROCEDURE TuitionCheckAll
AS
BEGIN
	declare @max int
	set @max = (select max(StudentID) from Student)

	declare @i int
	set @i = (select min(StudentID) from Student)
	WHILE (@i <= @max)
	BEGIN
	IF EXISTS (select StudentID from Student where StudentID = @i)
	   BEGIN
		   exec TuitionCheck1 @i       -- insert or update tuition status 
		   set @i = @i + 1
	   END
	END
END


-- Test
exec TuitionCheckAll
select * from TuitionStatus
