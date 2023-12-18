CREATE TRIGGER CheckLineIsFull ON dbo.Orders      -- when inserting an order
AFTER INSERT    
AS BEGIN
    IF (SELECT COUNT(Orders.CustomerID) - Line.Capacity FROM Orders JOIN inserted ON Orders.LineID = inserted.LineID  
		JOIN Line ON Line.LineID = Orders.LineID GROUP BY inserted.LineID) > 0
		-- check whether the count of customers is larger than the line's capacity
    BEGIN
        RAISERROR ('The travel line is full, can not be chosen.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

