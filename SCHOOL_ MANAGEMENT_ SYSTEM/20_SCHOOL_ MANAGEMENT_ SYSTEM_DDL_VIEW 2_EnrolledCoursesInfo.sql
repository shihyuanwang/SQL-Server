-- Create View 2 "EnrolledCoursesInfo": students' enrolleded courses information view (for students)

create view EnrolledCoursesInfo 
AS
select ts.StudentID, ts.TakeID, ti.TeachID, s.FirstName +' '+ s.LastName as StudentName, c.CourseID, c.CourseName, c.Unit, d.DepartmentName, 
       cl.Building+ ' ' + cl.RoomNo as Locations, 
	   ti.Quarters + ' ' + ti.Years as Term, ti.CourseTime as CourseTime
from Course as c 
inner join Teach_I as ti on c.CourseID = ti.CourseID
inner join Department as d on c.DepartmentID = d.DepartmentID
inner join Classroom as cl on cl.ClassroomID = ti.ClassroomID
inner join Take_S as ts on ti.TeachID = ts.TeachID
inner join Student as s on ts.StudentID = s.StudentID;

-- Test
select * from EnrolledCoursesInfo
select * from EnrolledCoursesInfo where StudentID = 56
select * from EnrolledCoursesInfo where StudentID = 56 and Term = 'Fall 2019'
