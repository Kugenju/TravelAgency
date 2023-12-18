-- rely on view LineProfit
CREATE VIEW LineStats
AS 
SELECT LineProfit.LineID, AVG(LineProfit.Profit), COUNT(Orders.CustomerID) menbers, COUNT(Orders.CustomerID)*LineProfit.Profit TotalProfit, 
FROM LineProfit JOIN Orders ON Line.LineID = Orders.LineID
GROUP BY LineProfit.LineID;