-- rely on the view "Free_Guide"
CREATE TRIGGER CheckValidAssignmentOfGuide ON dbo.Leadings     
AFTER INSERT, UPDATE
AS BEGIN
    IF EXISTS (SELECT * FROM inserted 
		WHERE inserted.GuideID NOT IN (
			SELECT GuideID FROM Free_Guide
		)
		)
    BEGIN
        RAISERROR ('The assigned Guide is not free now.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;