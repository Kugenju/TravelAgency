
CREATE TRIGGER CheckValidChoiceOfLine ON dbo.Orders     
AFTER INSERT, UPDATE
AS BEGIN
    IF EXISTS (SELECT CustomerID FROM inserted JOIN Orders ON inserted.CustomerID = Orders.CustomerID  --joint table of Inserted order and the Customer's prior orders
			WHERE EXISTS ( 
				SELECT EndTime FROM Line 
					WHERE Line.LineID = Orders.LineID  -- select the priors orders whose endtime > now (i.e. has not finished yet)
					AND EndTime > GETDATE()
			)
		)
    BEGIN
        RAISERROR ('The Customers orders conflic in terms of time.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;