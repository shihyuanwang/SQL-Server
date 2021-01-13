-- Create Trigger 5 "ShowUpadatedGrade": Show upadated grade after the instructor update the grade

CREATE TRIGGER ShowUpadatedGrade
ON Take_S 
AFTER UPDATE
AS 
BEGIN
SET NOCOUNT ON;

select i.TakeID as TakeID, s.StudentID as StudentID, s.FirstName +' '+ s.LastName as StudentName,
       ti.TeachID as TeachID, c.CourseName as CourseName, 
	   ts.HW1 as HW1, ts.HW2 as HW2, ts.HW3 as HW3, ts.HW4 as HW4, ts.Midterm1 as Midterm1,
	   ts.Midterm2 as Midterm2, ts.Project1 as Project1, ts.Project2 as Project2,
	   ts.Final as Final, ts.LetterGrade as LetterGrade, 'Updated' as [Status]
from inserted i join Take_S ts on i.TakeID = ts.TakeID
     join Teach_I ti on ts.TeachID = ti.TeachID
     join Student s on ts.StudentID = s.StudentID
	 join Course c on ti.CourseID = c.CourseID

END

-- Test
begin tran try1

exec updategrade_LG 1, 'A+'
select * from Take_S

rollback tran try1

