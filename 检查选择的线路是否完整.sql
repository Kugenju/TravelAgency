CREATE TRIGGER CheckChooseValidLine ON dbo.Orders     
AFTER INSERT, UPDATE
AS BEGIN
    IF EXISTS (SELECT * FROM inserted JOIN Line ON Line.LineID = inserted.LineID 
		WHERE Line.Status = 0)
    BEGIN
        RAISERROR ('The travel line has not been completely planned, can not be chosen yet.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;