USE [msdb]
GO

/****** Object:  Job [DBA-Maint-Weekly-Backup-User-Databases-Do-Not-Modify]    Script Date: 2/18/2019 2:14:38 PM ******/
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA-Maint-Weekly-Backup-User-Databases-Do-Not-Modify', @delete_unused_schedule=1
GO

/****** Object:  Job [DBA-Maint-Weekly-Backup-User-Databases-Do-Not-Modify]    Script Date: 2/18/2019 2:14:38 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 2/18/2019 2:14:38 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA-Maint-Weekly-Backup-User-Databases-Do-Not-Modify', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Step One - Weekly Backup User Databases]    Script Date: 2/18/2019 2:14:38 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Step One - Weekly Backup User Databases', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'/*
    //////////////////////////////////////////////////////////////////////////////////////////////
    Purpose: To perform backups of user databases on a weekly basis and place them in a designated location.
    The script was kept broken down to allow for a lot of customization. 
    Additionally, I wanted to keep it simple to correct in the event of any issues.
    Date Added: 2019FEB01
    Version: 001
    Revision: A
    Author: Jason M. Spencer
    Title: DBA
    Scripting Tool: Visual Studio Code
  
    //////////////////////////////////////////////////////////////////////////////////////////////
    Change Log Begins -->>
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
    Change Log Ends -->>
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
*/
DECLARE @name NVARCHAR(50) -- database name  
DECLARE @dayofweekdate as NVARCHAR(10) -- day of the week
DECLARE @path NVARCHAR(256) -- path for backup files  
DECLARE @fileName NVARCHAR(256) -- filename for backup
DECLARE @filedescriptname NVARCHAR(256)  -- used as the descriptor file name
DECLARE @fileDate NVARCHAR(20) -- used for file name
DECLARE @ServerName NVARCHAR(25) -- Used to hold the Server Name
DECLARE @InstanceName NVARCHAR(25) -- Used to hold the instance name

SET @ServerName = @@servername
SET @InstanceName = @@SERVICENAME

-- gets the day of the week
Set @dayofweekdate = CONVERT(nvarchar, FORMAT(GETDATE(), ''dddd'')) 

-- specify database backup directory
SET @path = ''\\HXCNAS2\SQL-Server-Backups\'' + @ServerName + ''\'' + @InstanceName + ''\Weekly\Full-Simple\User\''
 
-- specify filename format
SELECT @fileDate = CONVERT(NVARCHAR(20),GETDATE(),112) + REPLACE(CONVERT(NVARCHAR(20),GETDATE(),108),'':'','''')

DECLARE db_cursor CURSOR READ_ONLY FOR  
SELECT name 
FROM master.dbo.sysdatabases 
WHERE name NOT IN (''master'',''model'',''msdb'',''tempdb'')  -- exclude these databases

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @name   
 
WHILE @@FETCH_STATUS = 0   
BEGIN   
   SET @fileName = @path + @name + ''_'' + @fileDate + ''.bak''  
   BACKUP DATABASE @name TO DISK = @fileName  WITH CHECKSUM, NOFORMAT, NOINIT, SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10
 
   FETCH NEXT FROM db_cursor INTO @name   
END   

CLOSE db_cursor   
DEALLOCATE db_cursor

--End of Script
-- Version: 001
-- Revision: A
--**************************
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Step Two - Weekly TRN Backu User Databases]    Script Date: 2/18/2019 2:14:38 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Step Two - Weekly TRN Backup User Databases', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'/*
    //////////////////////////////////////////////////////////////////////////////////////////////
    Purpose: To perform backups of user databases on a weekly basis and place them in a designated location.
    The script was kept broken down to allow for a lot of customization. 
    Additionally, I wanted to keep it simple to correct in the event of any issues.
    Date Added: 2019FEB01
    Version: 001
    Revision: A
    Author: Jason M. Spencer
    Title: DBA
    Scripting Tool: Visual Studio Code
  
    //////////////////////////////////////////////////////////////////////////////////////////////
    Change Log Begins -->>
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
    Change Log Ends -->>
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
*/
DECLARE @name NVARCHAR(50) -- database name  
DECLARE @dayofweekdate as NVARCHAR(10) -- day of the week
DECLARE @path NVARCHAR(256) -- path for backup files  
DECLARE @fileName NVARCHAR(256) -- filename for backup
DECLARE @filedescriptname NVARCHAR(256)  -- used as the descriptor file name
DECLARE @fileDate NVARCHAR(20) -- used for file name
DECLARE @ServerName NVARCHAR(25) -- Used to hold the Server Name
DECLARE @InstanceName NVARCHAR(25) -- Used to hold the instance name

SET @ServerName = @@servername
SET @InstanceName = @@SERVICENAME

-- gets the day of the week
Set @dayofweekdate = CONVERT(nvarchar, FORMAT(GETDATE(), ''dddd'')) 

-- specify database backup directory
SET @path = ''\\HXCNAS2\SQL-Server-Backups\'' + @ServerName + ''\'' + @InstanceName + ''\Weekly\Transactional\User\''
 
-- specify filename format
SELECT @fileDate = CONVERT(NVARCHAR(20),GETDATE(),112) + REPLACE(CONVERT(NVARCHAR(20),GETDATE(),108),'':'','''')

DECLARE db_cursor CURSOR READ_ONLY FOR  
SELECT name 
FROM sys.databases
WHERE name NOT IN (''master'',''model'',''msdb'',''tempdb'')  and recovery_model_desc =''FULL''-- exclude these databases

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @name   
 
WHILE @@FETCH_STATUS = 0   
BEGIN   
   SET @fileName = @path + @name + ''_'' + @fileDate + ''.trn''  
   BACKUP LOG @name TO DISK = @fileName  WITH CHECKSUM, NOFORMAT, NOINIT, SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10
 
   FETCH NEXT FROM db_cursor INTO @name   
END   

CLOSE db_cursor   
DEALLOCATE db_cursor

--End of Script
-- Version: 001
-- Revision: A
--**************************
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Weekly User Database Backup Schedule', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20190201, 
		@active_end_date=99991231, 
		@active_start_time=24800, 
		@active_end_time=235959, 
		@schedule_uid=N'0b484f4e-a771-4a16-b7ef-cac014ad1e81'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


