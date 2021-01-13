-- Create Store Procedure 7 "GradeView": For students to get grades information on each enrolled class

CREATE PROCEDURE GradeView @StudentID int
AS
BEGIN
select ts.TakeID as TakeID, s.StudentID as StudentID, s.FirstName +' '+ s.LastName as StudentName,
       ti.TeachID as TeachID, c.CourseName as CourseName, 
	   ts.HW1 as HW1, ts.HW2 as HW2, ts.HW3 as HW3, ts.HW4 as HW4, ts.Midterm1 as Midterm1,
	   ts.Midterm2 as Midterm2, ts.Project1 as Project1, ts.Project2 as Project2,
	   ts.Final as Final, ts.LetterGrade as LetterGrade
from Take_S ts join Teach_I ti on ts.TeachID = ti.TeachID
     join Student s on ts.StudentID = s.StudentID
	 join Course c on ti.CourseID = c.CourseID
where ts.StudentID = @StudentID
END


-- Test
select * from Take_S
exec GradeView 56