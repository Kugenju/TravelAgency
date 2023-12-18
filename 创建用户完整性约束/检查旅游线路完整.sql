CREATE TRIGGER CheckLineIsComplete ON dbo.Line     
AFTER UPDATE    
AS BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE Status = 1) AND
	( 
	EXISTS ( SELECT number FROM master..spt_values 
			WHERE type='P' --Ñ¡ÔñÌìÊı
				AND number>=1  AND  number<=(SELECT AllDay FROM inserted) -- generate ser of numbers ranging from 1 to Line's duration
				AND number NOT IN (SELECT [Day] FROM inserted JOIN Reserve ON inserted.LineID = Reserve.LineID WHERE inserted.Status = 1) 
				)  --select all the days of the Reservations
		OR EXISTS(SELECT number FROM master..spt_values 
			WHERE type='P' 
				AND number>=1  AND  number<=(SELECT AllDay FROM inserted) 
				AND number NOT IN (SELECT [Day] FROM inserted JOIN Visit ON inserted.LineID = Visit.LineID WHERE inserted.Status = 1) 
				)  -- do the same thing on Visited Spots
				)
    BEGIN
        RAISERROR ('The travel line has not been completely planned, can not change the status', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;