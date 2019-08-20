SPID 653


SELECT @@SPID
GO

select 653
GO


DECLARE @sqltext VARBINARY(128)
SELECT @sqltext = sql_handle
FROM sys.sysprocesses
WHERE spid = 653
SELECT TEXT
 FROM sys.dm_exec_sql_text(@sqltext)
GO

DECLARE @sqltext VARBINARY(128)
SELECT @sqltext = sql_handle
FROM sys.sysprocesses
WHERE spid = 102
SELECT TEXT
 FROM sys.dm_exec_sql_text(@sqltext)
GO

sp_who