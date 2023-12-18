--Change Customer's name
CREATE PROCEDURE ChangeCustomerName @CID int, @NewName varchar(50)
AS 
UPDATE Customer SET CustomerName = @NewName WHERE CustomerID = @CID;