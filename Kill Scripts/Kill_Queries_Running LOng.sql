SELECT sqltext.TEXT,
req.session_id,
req.status,
req.command,
req.cpu_time,
req.total_elapsed_time
FROM sys.dm_exec_requests req
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS sqltext 

KILL 80
KILL 80 WITH STATUSONLY

SELECT sqltext.TEXT,  req.session_id,  req.status,  req.command,  req.cpu_time,  req.total_elapsed_time  FROM sys.dm_exec_requests req  CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS sqltext
declare @backupSetId as int  select @backupSetId = position from msdb..backupset where database_name=N'Army_FBwT' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N'Army_FBwT' )  if @backupSetId is null begin raiserror(N'Verify failed. Backup information for database ''Army_FBwT'' not found.', 16, 1) end  RESTORE VERIFYONLY FROM  DISK = N'\\cin-fs-u-3\cin_sql_backups\cin-sq8c-vw-15\FBWTTEST\user\Army_FBwT\Army_FBwT_backup_2013_12_16_173006_7913438.bak' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND  

exec sp_who2
go

sp_who2