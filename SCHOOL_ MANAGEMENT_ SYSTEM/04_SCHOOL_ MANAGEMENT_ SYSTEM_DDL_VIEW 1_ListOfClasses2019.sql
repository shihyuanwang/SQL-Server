-- Create view 1 "ListOfClasses2019": a list of available classes in 2019

CREATE VIEW ListOfClasses2019 
AS
select t.TeachID as TeachID,
       c.CourseName as Course, c.Unit as Units, d.DepartmentName as Department,
	   i.FirstName + ' ' + i.LastName as Instructor, cr.Building + ' ' + cr.RoomNo as Locations, 
	   t.Quarters + ' ' + t.Years as Term, t.CourseTime as CourseTime,
	   t.Capacity, dy.SpotsLeft
from Teach_I t join Course c on t.CourseID = c.CourseID
	 join Department d on c.DepartmentID = d.DepartmentID
	 join Instructor i on t.InstructorID = i.InstructorID
	 join Classroom cr on t.ClassroomID = cr.ClassroomID
	 join DynEnroll dy on t.TeachID = dy.TeachID
where t.Years = '2019'

-- select * from ListOfClasses2019 