-- Logging/Auditing mechanism: TuitionAudit table

-- Create Trigger 6: insert into TuitionAudit table after every tuition transaction 
-- "TuitionAudit_insert": after inserting into Tuition table (new tuition payable)
-- "TuitionAudit_delete": after deleting from Tuition table (cancel tuition transaction)
-- "TuitionAudit_update": after updating Tuition table (update tuition payable)

CREATE TRIGGER TuitionAudit_insert
	ON dbo.Tuition
	AFTER INSERT
AS
BEGIN
	insert into TuitionAudit
	select i.TuitionID, i.StudentID, null, i.Amount, 'insert', GETDATE() 
	from inserted i join Tuition t on i.TuitionID = t.TuitionID
END

-----------
CREATE TRIGGER TuitionAudit_delete
	ON dbo.Tuition
	AFTER DELETE
AS
BEGIN
	insert into TuitionAudit
	select d.TuitionID, d.StudentID, d.Amount, null, 'delete', GETDATE() 
	from deleted d
END

-----------
CREATE TRIGGER TuitionAudit_update
	ON dbo.Tuition
	AFTER UPDATE
AS
BEGIN
	insert into TuitionAudit
	select i.TuitionID, i.StudentID, d.Amount, i.Amount, 'update', GETDATE() 
	from inserted i join Tuition t on i.TuitionID = t.TuitionID join deleted d 
	on d.TuitionID = t.TuitionID
END

-- select * from TuitionAudit