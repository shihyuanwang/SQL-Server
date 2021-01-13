-- Create Store Procedure 1 "Enrollment": insert into Take_S table if the student takes the class,
--                                        delete data from Take_S table if the student drops the class

CREATE PROCEDURE Enrollment @StudentID int, @TeachID int, @select nvarchar(10)
AS
BEGIN

if(@select = 'take')
insert into Take_S(StudentID, TeachID, LetterGrade) values(@StudentID, @TeachID, 'NA')

if(@select = 'drop')
delete from Take_S
where StudentID = @StudentID and TeachID = @TeachID

-- Show class information after enrollment or drop
select StudentID, ts.TeachID as TeachID, Course, Units, Department, 
       Instructor, Locations, Term, CourseTime
from Take_S ts join ListOfClasses2019 lc on ts.TeachID = lc.TeachID 
where StudentID = @StudentID

END


