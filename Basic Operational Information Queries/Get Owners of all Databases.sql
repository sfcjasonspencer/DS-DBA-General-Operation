DECLARE @TblDatabase TABLE(DatabaseName VARCHAR(100), Size INT, Remarks VARCHAR(100))
INSERT INTO @TblDatabase
EXEC sp_databases
SELECT DatabaseName,suser_sname(owner_sid)
FROM @TblDatabase tblDb
INNER JOIN sys.databases db ON tblDb.DatabaseName = db.name