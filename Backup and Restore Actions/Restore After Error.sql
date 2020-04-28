
Use participant_6
GO

ALTER DATABASE participant_6 SET SINGLE_USER
GO

DBCC CHECKDB('participant_6', REPAIR_REBUILD)
GO

-- to return to multi-user mode:
ALTER DATABASE [participant_6] SET MULTI_USER



USE [master]
RESTORE DATABASE [participant_6] FROM  DISK = N'E:\SQL-Server-Backups\PROD-DB-01\NCOMPASS\NCOMPASS\Daily\Thursday\Full-Simple\User\participant_6_20200227131700.bak' 
WITH  FILE = 1,  
MOVE N'participant_6' TO N'E:\Data\BUSQLServer\User\participant_6.mdf',  
MOVE N'participant_6_log' TO N'E:\Log\BUSQLServer\User\participant_6_log.ldf',  
NOUNLOAD,  REPLACE,  STATS = 5,CHECKSUM, CONTINUE_AFTER_ERROR,
MAXTRANSFERSIZE = 4194302, BUFFERCOUNT = 100, BLOCKSIZE = 8192
GO