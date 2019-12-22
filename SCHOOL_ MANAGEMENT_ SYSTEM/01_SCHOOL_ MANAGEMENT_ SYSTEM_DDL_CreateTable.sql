--Department
CREATE TABLE Department(
DepartmentID int identity(1,1) PRIMARY KEY,
DepartmentName nvarchar(20) NOT NULL,
Building nvarchar(20) NOT NULL,
Budget numeric(12,2) NOT NULL,
Balance numeric(12,2) NOT NULL,
)

--Instructor
CREATE TABLE Instructor(
InstructorID int identity(1,1) PRIMARY KEY,
FirstName nvarchar(20) NOT NULL,
LastName nvarchar(20) NOT NULL,
Gender char(1) NOT NULL,
PhoneNumber char(10) NOT NULL,
EmailAddress varchar(50) NOT NULL,
OfficeNo char(4) NOT NULL,
Title nvarchar(20) NOT NULL,
EntryDate date NOT NULL,
DepartmentID int NOT NULL FOREIGN KEY REFERENCES Department(DepartmentID),
)

--Student
CREATE TABLE Student(
StudentID int identity(1,1) PRIMARY KEY,
EnrollmentNo char(9) NOT NULL,
FirstName nvarchar(20) NOT NULL,
LastName nvarchar(20) NOT NULL,
Gender char(1) NOT NULL,
EmailAddress varchar(50) NOT NULL,
EntryYear char(4) NOT NULL,
DepartmentID int NOT NULL FOREIGN KEY REFERENCES Department(DepartmentID),
)

--Course
CREATE TABLE Course(
CourseID int identity(1,1) PRIMARY KEY,
CourseName nvarchar(50) NOT NULL,
DepartmentID int NOT NULL FOREIGN KEY REFERENCES Department(DepartmentID),
Unit numeric(2,0) NOT NULL,
StudyFee numeric(7,2) NOT NULL,
TeachFee numeric(7,2) NOT NULL,
)

--Classroom
CREATE TABLE Classroom(
ClassroomID int identity(1,1) PRIMARY KEY,
Building nvarchar(20) NOT NULL,
RoomNo char(4) NOT NULL,
)

--Teach_I
CREATE TABLE Teach_I(
TeachID int identity(1,1) PRIMARY KEY, 
CourseID int NOT NULL FOREIGN KEY REFERENCES Course(CourseID),
InstructorID int NOT NULL FOREIGN KEY REFERENCES Instructor(InstructorID),
Quarters varchar(6) NOT NULL,
Years char(4) NOT NULL,
CourseTime time NOT NULL,
ClassroomID int NOT NULL FOREIGN KEY REFERENCES Classroom(ClassroomID),
Capacity int NOT NULL,
)

-- Dynamic Enrollment
CREATE TABLE DynEnroll (
DynID int identity(1,1) PRIMARY KEY,
TeachID int NOT NULL FOREIGN KEY REFERENCES Teach_I(TeachID),
Capacity int NOT NULL,
SpotsLeft int NOT NULL
);

--Take_S
CREATE TABLE Take_S(
TakeID int identity(1,1) PRIMARY KEY,
StudentID int NOT NULL FOREIGN KEY REFERENCES Student(StudentID),
TeachID int NOT NULL FOREIGN KEY REFERENCES Teach_I(TeachID),
HW1 numeric(4,2),
HW2 numeric(4,2),
HW3 numeric(4,2),
HW4 numeric(4,2),
Midterm1 numeric(4,2),
Midterm2 numeric(4,2),
Project1 numeric(4,2),
Project2 numeric(4,2),
Final numeric(4,2),
LetterGrade varchar(2) 
)

--Payment
CREATE TABLE Payment(
PaymentID int identity(1,1) PRIMARY KEY,
InstructorID int FOREIGN KEY REFERENCES Instructor(InstructorID),
Amount numeric(10,2) NOT NULL,
PaidTime datetime NOT NULL
)

-- Balance
CREATE TABLE Balance(
BalanceID int identity(1,1) PRIMARY KEY,
PaymentID int FOREIGN KEY REFERENCES Payment(PaymentID),
InstructorID int FOREIGN KEY REFERENCES Instructor(InstructorID),
Balance numeric(10,2) NOT NULL,
PaidTime datetime NOT NULL
)

--Tuition
CREATE TABLE Tuition(
TuitionID int identity(1,1) PRIMARY KEY,
StudentID int NOT NULL FOREIGN KEY REFERENCES Student(StudentID),
Amount numeric(10,2) NOT NULL,
PaidTime datetime NOT NULL
)

CREATE TABLE TuitionAudit(
TuitionAuditID int identity(1,1) PRIMARY KEY,
TuitionID int NOT NULL,
StudentID int NOT NULL,
OldAmount numeric(10,2),
NewAmount numeric(10,2),
Operation nvarchar(10) NOT NULL,
OperationTime datetime NOT NULL 
)

CREATE TABLE TuitionStatus(
TuitionStatusID int identity(1,1) PRIMARY KEY,
StudentID int NOT NULL FOREIGN KEY REFERENCES Student(StudentID),
Paid numeric(10,2),
Payable numeric(10,2),
TheStatus nvarchar(20)
)
