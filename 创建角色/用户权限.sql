-- Rely on the StoredProcedures and Views
-- ROLE1 LineReader
CREATE ROLE LineReader;
GRANT SELECT ON Line TO LineReader;
GRANT SELECT ON Spot TO LineReader;
GRANT SELECT ON Hotel TO LineReader;
GRANT SELECT ON Visit TO LineReader;
GRANT SELECT ON Reserve TO LineReader;
DENY SELECT(TransFee) ON Line TO LineReader;  --Deny the selections of commercial secret
DENY SELECT(Price) ON Spot TO LineReader;  --Deny the selections of commercial secret
DENY SELECT(Price) ON Hotel TO LineReader;  --Deny the selections of commercial secret

-- ROLE2 TourGuide
CREATE ROLE TourGuide;
GRANT EXECUTE ON OBJECT::dbo.GetLineCustomer TO TourGuide;

-- ROLE3 Planner
CREATE ROLE Planner;
GRANT SELECT, UPDATE, INSERT, DELETE ON Line TO Planner;
GRANT SELECT, UPDATE, INSERT, DELETE ON Spot TO Planner;
GRANT SELECT, UPDATE, INSERT, DELETE ON Hotel TO Planner;
GRANT SELECT, UPDATE, INSERT, DELETE ON Visit TO Planner;
GRANT SELECT, UPDATE, INSERT, DELETE ON Reserve TO Planner;

-- ROLE4 CustomerClient
CREATE ROLE CustomerClient;
GRANT EXECUTE ON OBJECT::dbo.ChangeCustomerName TO CustomerClient;
GRANT EXECUTE ON OBJECT::dbo.CustomerOrder TO CustomerClient;

-- ROLE5 OrdersAnalysis
CREATE ROLE OrdersAnalysis;
-- select on view
GRANT SELECT ON LineProfit TO OrdersAnalysis;
GRANT SELECT ON LineStats TO OrdersAnalysis;
GRANT SELECT ON MONTH_PANNAL TO OrdersAnalysis;
-- select on all commercial data
GRANT SELECT ON Orders TO OrdersAnalysis;
GRANT SELECT ON Line TO LineReader;
GRANT SELECT ON Spot TO LineReader;
GRANT SELECT ON Hotel TO LineReader;
GRANT SELECT ON Visit TO LineReader;
GRANT SELECT ON Reserve TO LineReader;
