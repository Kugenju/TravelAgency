--视图
--1.查询空闲员工
CREATE VIEW Free_Guide
AS
SELECT GuideID,GuideName,Contact FROM Guide
WHERE Guide.GuideID NOT IN (SELECT GuideID FROM Leadings)--不在带队表里面的
OR 
Guide.GuideID IN 
(SELECT GuideID FROM Leadings WHERE Leadings.LineID IN 
(SELECT Line.LineID FROM Line WHERE GETDATE()>EndTime))--可能还在Leading表里面没有及时删除，但是查询的时候没有带队，可以指派的