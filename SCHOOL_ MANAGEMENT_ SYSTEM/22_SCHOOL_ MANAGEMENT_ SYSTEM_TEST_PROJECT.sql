-- Test of the project 

-- Add a new instructor to the "Instructor" table
begin tran try1

insert into Instructor values('A', 'B', 'M', '1234567890', '22@mail.com', '1234', 'Professor',
GETDATE(), 1)

select * from Instructor
select * from Payment
exec InstructorPaymentReport A, B

rollback tran try1

-- Classes enrollment (SpotsLeft / EnrollCheck / show class information after enrollment or drop)
begin tran try2

select * from ListOfClasses2019
Enrollment 1, 4, 'Take'
Enrollment 1, 5, 'Take'
select * from ListOfClasses2019
Enrollment 1, 5, 'Take'
Enrollment 1, 6, 'Take'

rollback tran try2

-- (Instructors) update grade & (Students) view grade
begin tran try3
exec InstructorCoursesInfo @InstructorID = 7,  @Years = '2019', @Quarters = 'Fall'
exec UpdateGrade_LG 3, 'A-'
exec RollBook @TeachID = 10
exec GradeView 10

rollback tran try3

-- Record the Tuition payment (TuitionAudit)
begin tran try4

insert into Tuition values(1, 2000, getdate())
insert into Tuition values(2, 3000, getdate())
delete from Tuition where TuitionID = 2
update Tuition set Amount = 3500 where TuitionID = 1
select * from Tuition
select * from TuitionAudit

rollback tran try4

-- Check tuition status 
exec TuitionCheckAll
select * from TuitionStatus

begin tran try5

insert into Tuition values(4, -3000, getdate())
exec TuitionCheckAll
insert into Tuition values(4, 500, getdate())
exec TuitionCheckAll

rollback tran try5

-- Drop Enrolled students in deficit status
begin tran try6

select * from Take_S tks join TuitionStatus tus on tks.StudentID = tus.StudentID 
where tus.TheStatus = 'Deficit'

exec DropStudentsinDeficit
select * from Take_S

rollback tran try6

-- Instructor's salary payment- 1 person
begin tran try7
exec SalaryPayment1 17, 'Spring', '2019'
select * from Payment
exec InstructorPaymentReport 'Karisa', 'Althrope'
select * from Department
rollback tran try7


-- Instructors' salary payment- All
begin tran try8
exec SalaryPaymentAll 'Spring', '2019'
select * from Payment
select * from Balance
select * from Department
rollback tran try8