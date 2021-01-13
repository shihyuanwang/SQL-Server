-- Create Store Procedure 2 "UpdateGrade_XXX": For instructors to update grades in Take_S table

-- HW1
CREATE PROCEDURE UpdateGrade_HW1 @TakeID int, @HW1 numeric(4,2)
AS
BEGIN
update Take_S set HW1 = @HW1 where TakeID = @TakeID
END

-- HW2
CREATE PROCEDURE UpdateGrade_HW2 @TakeID int, @HW2 numeric(4,2)
AS
BEGIN
update Take_S set HW2 = @HW2 where TakeID = @TakeID
END

-- HW3
CREATE PROCEDURE UpdateGrade_HW3 @TakeID int, @HW3 numeric(4,2)
AS
BEGIN
update Take_S set HW3 = @HW3 where TakeID = @TakeID
END

-- HW4
CREATE PROCEDURE UpdateGrade_HW4 @TakeID int, @HW4 numeric(4,2)
AS
BEGIN
update Take_S set HW4 = @HW4 where TakeID = @TakeID
END

-- Midterm 1
CREATE PROCEDURE UpdateGrade_MT1 @TakeID int, @MT1 numeric(4,2)
AS
BEGIN
update Take_S set Midterm1 = @MT1 where TakeID = @TakeID
END

-- Midterm 2
CREATE PROCEDURE UpdateGrade_MT2 @TakeID int, @MT2 numeric(4,2)
AS
BEGIN
update Take_S set Midterm2 = @MT2 where TakeID = @TakeID
END

-- Project 1
CREATE PROCEDURE UpdateGrade_PJ1 @TakeID int, @PJ1 numeric(4,2)
AS
BEGIN
update Take_S set Project1 = @PJ1 where TakeID = @TakeID
END

-- Project 2
CREATE PROCEDURE UpdateGrade_PJ2 @TakeID int, @PJ2 numeric(4,2)
AS
BEGIN
update Take_S set Project2 = @PJ2 where TakeID = @TakeID
END

-- Final exam
CREATE PROCEDURE UpdateGrade_FL @TakeID int, @FL numeric(4,2)
AS
BEGIN
update Take_S set Final = @FL where TakeID = @TakeID
END

-- Letter Grade
CREATE PROCEDURE UpdateGrade_LG @TakeID int, @LG varchar(2)
AS
BEGIN
update Take_S set LetterGrade = @LG where TakeID = @TakeID
END

