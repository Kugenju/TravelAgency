CREATE TRIGGER 检查旅游线路完整性 ON dbo.Line     
AFTER INSERT, UPDATE    
AS BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE Status = 1) AND
	( 
	EXISTS ( SELECT number FROM master..spt_values 
			WHERE type='P' --选择天数
				AND number>=1  AND  number<=(SELECT AllDay FROM inserted) -- 如果修改的是7天的旅游计划，这行代码可以生成1 2 3 4 5 6 7 的数字集合
				AND number NOT IN (SELECT [Day] FROM inserted JOIN Reserve ON inserted.LineID = Reserve.LineID WHERE inserted.Status = 1) --这行代码取出所有和这条旅游线路相关的酒店安排的天数
				)
		OR EXISTS(SELECT number FROM master..spt_values 
			WHERE type='P' 
				AND number>=1  AND  number<=(SELECT AllDay FROM inserted) 
				AND number NOT IN (SELECT [Day] FROM inserted JOIN Visit ON inserted.LineID = Visit.LineID WHERE inserted.Status = 1) --这行代码取出所有和这条旅游线路相关的景点安排的天数
				)
				)
    BEGIN
        RAISERROR ('路线尚不完整，不能修改状态。', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;