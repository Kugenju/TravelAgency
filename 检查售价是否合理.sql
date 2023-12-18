CREATE TRIGGER CheckPriceProfitable ON dbo.Line     
AFTER INSERT, UPDATE    
AS BEGIN
    IF (SELECT Price - TransFee FROM inserted) < (
	(SELECT SUM(Spot.Price) FROM inserted JOIN Visit ON inserted.LineID = Visit.LineID JOIN Spot ON Visit.SpotID = Spot.SpotID) +
	(SELECT SUM(Hotel.Price) FROM inserted JOIN Reserve ON inserted.LineID = Reserve.LineID JOIN Hotel ON Reserve.HotelID = Hotel.HotelID)) * 1.1
    BEGIN
        RAISERROR ('售价低于成本的110%', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;