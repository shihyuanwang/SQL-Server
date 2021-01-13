-- Create Store Procedure 8 "InstructorCoursesInfo": instructor's courses information (for instructors)

create procedure InstructorCoursesInfo @InstructorID int, @Years char(4), @Quarters varchar(6)
AS
BEGIN
    select ti.InstructorID, i.FirstName +' '+ i.LastName as InstructorName, ti.CourseID, c.CourseName, 
       c.Unit, ti.CourseTime, d.DepartmentName, cl.Building+ ' ' + cl.RoomNo as Locations
    from Teach_I as ti 
    inner join Course as c on c.CourseID = ti.CourseID
    inner join Instructor as i on ti.InstructorID = i.InstructorID
    inner join Department as d on c.DepartmentID = d.DepartmentID
    inner join Classroom as cl on cl.ClassroomID = ti.ClassroomID
    where ti.InstructorID = @InstructorID and ti.Years =  @Years and ti.Quarters = @Quarters
END

-- Test
select * from Teach_I
exec InstructorCoursesInfo @InstructorID = 7,  @Years = '2019', @Quarters = 'Fall'
