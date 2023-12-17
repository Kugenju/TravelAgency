CREATE TRIGGER 检查是否超员 ON dbo.Orders     
AFTER INSERT    
AS BEGIN
    IF (SELECT COUNT(Orders.CustomerID) - Line.线路最大人数 FROM Orders JOIN inserted ON Orders.LineID = inserted.LineID
			JOIN Line ON Line.LineID = Orders.LineID GROUP BY inserted.LineID) > 0
    BEGIN
        RAISERROR ('该线路已满，请选择其他线路', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

CREATE TRIGGER 检查用户选择的线路是否完整 ON dbo.Orders     
AFTER INSERT    
AS BEGIN
    IF EXISTS (SELECT * FROM inserted JOIN Line ON Line.LineID = inserted.LineID 
		WHERE Line.Status = 0)
    BEGIN
        RAISERROR ('路线尚不完整，不能被选中。', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;