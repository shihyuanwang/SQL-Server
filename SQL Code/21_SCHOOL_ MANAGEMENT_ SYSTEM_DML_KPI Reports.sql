-- Key Performance Indicators

-- Gets Top5 highest average final exam score class
Select top(5) ti.TeachID, ti.CourseID, c.CourseName, avg(ts.Final) as [Average Final]
from Teach_I as ti 
join Course as c on ti.CourseID = c.CourseID
join Take_S as ts on ti.TeachID = ts.TeachID
group by ti.TeachID, ti.CourseID, c.CourseName
order by avg(ts.Final) desc;


-- Get Top5 popular courses in 2018 and 2019
Select top(5) ti.CourseID, c.CourseName, count(StudentID) as [Number of Enrolled Students]
from Teach_I as ti 
inner join Course as c on ti.CourseID = c.CourseID
left join Take_S as ts on ti.TeachID = ts.TeachID
group by ti.CourseID, c.CourseName
order by count(StudentID) desc;


-- Get instructors' latest account info in the order of account balance (max -> min)
select a.InstructorID , b.balance, a.[Latest PaidTime]
from (select InstructorID, MAX(PaidTime) as [Latest PaidTime] 
      from Balance group by InstructorID) a              
join balance b on  a.InstructorID = b.InstructorID
where a.[Latest PaidTime] = b.PaidTime
order by b.balance desc;  