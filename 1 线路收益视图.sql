CREATE VIEW LineProfit
AS
SELECT Line.LineID, AVG(Line.Price) - AVG(Line.TransFee) - SUM(Hotel.Price) - SUM(Spot.Price) AS Profit, Line.StartTime
FROM Line 
JOIN Reserve ON Line.LineID = Reserve.LineID
JOIN Hotel ON Reserve.HotelID = Hotel.HotelID
JOIN Visit ON Line.LineID = Visit.LineID
JOIN Spot ON Spot.SpotID = Visit.SpotID
WHERE Line.Status = 1
GROUP BY Line.LineID;
