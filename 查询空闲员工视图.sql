--��ͼ
--1.��ѯ����Ա��
CREATE VIEW Free_Guide
AS
SELECT GuideID,GuideName,Contact FROM Guide
WHERE Guide.GuideID NOT IN (SELECT GuideID FROM Leadings)--���ڴ��ӱ������
OR 
Guide.GuideID IN 
(SELECT GuideID FROM Leadings WHERE Leadings.LineID IN 
(SELECT Line.LineID FROM Line WHERE GETDATE()>EndTime))--���ܻ���Leading������û�м�ʱɾ�������ǲ�ѯ��ʱ��û�д��ӣ�����ָ�ɵ�