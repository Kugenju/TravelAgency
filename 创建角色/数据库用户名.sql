CREATE USER CustomerAPP WITHOUT Login; -- can change for logins
exec sp_addrolemember 'LineReader','CustomerAPP';
exec sp_addrolemember 'CustomerClient','CustomerAPP';

CREATE USER TourGuide WITHOUT Login; -- can change for logins
exec sp_addrolemember 'LineReader','TourGuide';
exec sp_addrolemember 'TourGuide','TourGuide';

CREATE USER Planner WITHOUT Login; -- can change for logins
exec sp_addrolemember 'LineReader','Planner';
exec sp_addrolemember 'Planner','Planner';

CREATE USER Manager WITHOUT Login; -- can change for logins
exec sp_addrolemember 'OrdersAnalysis','Manager';
