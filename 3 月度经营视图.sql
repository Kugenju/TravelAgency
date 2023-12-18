-- rely on LineStats
CREATE VIEW MONTH_PANNAL
AS
SELECT datepart(mm, LineStats.StartTime) [month], SUM(LineStats.TotalProfit)
FROM LineStats
GROUP BY datepart(mm, LineStats.StartTime)
ORDER BY [month]
DESC;
