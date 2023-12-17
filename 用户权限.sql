CREATE ROLE LineReader;
GRANT SELECT ON Line TO LineReader;
GRANT SELECT ON Spot TO LineReader;
GRANT SELECT ON Hotel TO LineReader;
GRANT SELECT ON Visit TO LineReader;
GRANT SELECT ON Reserve TO LineReader;
DENY SELECT(TransFee) ON Line TO LineReader;  --�ܾ���ȡ�ǹ�����Ϣ
DENY SELECT(Price) ON Spot TO LineReader;  --�ܾ���ȡ�ǹ�����Ϣ
DENY SELECT(Price) ON Hotel TO LineReader;  --�ܾ���ȡ�ǹ�����Ϣ

CREATE PROCEDURE GetLineCustomer @Lineid int
AS 
SELECT Customer.CustomerName CustomerName, Customer.Phone Phone  FROM Orders 
JOIN Customer ON Orders.CustomerID = Customer.CustomerID
WHERE Orders.LineID = @Lineid;
CREATE ROLE TourGuide;
GRANT EXECUTE ON OBJECT::dbo.GetLineCustomer TO TourGuide;

CREATE ROLE Planner;
GRANT SELECT, UPDATE, INSERT, DELETE ON Line TO Planner;
GRANT SELECT, UPDATE, INSERT, DELETE ON Spot TO Planner;
GRANT SELECT, UPDATE, INSERT, DELETE ON Hotel TO Planner;
GRANT SELECT, UPDATE, INSERT, DELETE ON Visit TO Planner;
GRANT SELECT, UPDATE, INSERT, DELETE ON Reserve TO Planner;

CREATE PROCEDURE ChangeCustomerName @CID int, @NewName varchar(50)  --�޸��û�����
AS 
UPDATE Customer SET CustomerName = @NewName WHERE CustomerID = @CID;

CREATE PROCEDURE CustomerOrder @CID int, @line int  --�û��µ�
AS 
INSERT INTO Orders (CustomerID, LineID) VALUES (@CID, @line);
CREATE ROLE CustomerClient;
GRANT EXECUTE ON OBJECT::dbo.ChangeCustomerName TO CustomerClient;

GRANT EXECUTE ON OBJECT::dbo.CustomerOrder TO CustomerClient;