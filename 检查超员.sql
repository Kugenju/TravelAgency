CREATE TRIGGER ����Ƿ�Ա ON dbo.Orders     
AFTER INSERT    
AS BEGIN
    IF (SELECT COUNT(Orders.CustomerID) - Line.��·������� FROM Orders JOIN inserted ON Orders.LineID = inserted.LineID
			JOIN Line ON Line.LineID = Orders.LineID GROUP BY inserted.LineID) > 0
    BEGIN
        RAISERROR ('����·��������ѡ��������·', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

CREATE TRIGGER ����û�ѡ�����·�Ƿ����� ON dbo.Orders     
AFTER INSERT    
AS BEGIN
    IF EXISTS (SELECT * FROM inserted JOIN Line ON Line.LineID = inserted.LineID 
		WHERE Line.Status = 0)
    BEGIN
        RAISERROR ('·���в����������ܱ�ѡ�С�', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;