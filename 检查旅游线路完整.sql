CREATE TRIGGER ���������·������ ON dbo.Line     
AFTER INSERT, UPDATE    
AS BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE Status = 1) AND
	( 
	EXISTS ( SELECT number FROM master..spt_values 
			WHERE type='P' --ѡ������
				AND number>=1  AND  number<=(SELECT AllDay FROM inserted) -- ����޸ĵ���7������μƻ������д����������1 2 3 4 5 6 7 �����ּ���
				AND number NOT IN (SELECT [Day] FROM inserted JOIN Reserve ON inserted.LineID = Reserve.LineID WHERE inserted.Status = 1) --���д���ȡ�����к�����������·��صľƵ갲�ŵ�����
				)
		OR EXISTS(SELECT number FROM master..spt_values 
			WHERE type='P' 
				AND number>=1  AND  number<=(SELECT AllDay FROM inserted) 
				AND number NOT IN (SELECT [Day] FROM inserted JOIN Visit ON inserted.LineID = Visit.LineID WHERE inserted.Status = 1) --���д���ȡ�����к�����������·��صľ��㰲�ŵ�����
				)
				)
    BEGIN
        RAISERROR ('·���в������������޸�״̬��', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;