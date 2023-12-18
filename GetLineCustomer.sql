-- given the line id, select the customers' basic informations.
CREATE PROCEDURE GetLineCustomer @Lineid int
AS 
SELECT Customer.CustomerName CustomerName, Customer.Phone Phone FROM Orders 
JOIN Customer ON Orders.CustomerID = Customer.CustomerID
WHERE Orders.LineID = @Lineid;
