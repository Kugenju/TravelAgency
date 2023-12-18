-- INSERT one Order, performed by the user's client.
CREATE PROCEDURE CustomerOrder @CID int, @line int  
AS 
INSERT INTO Orders (CustomerID, LineID) VALUES (@CID, @line);