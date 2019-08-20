USE [msdb]
GO

/****** Object:  Job [DBA-Maint-Daily-Backup-System-Databases-Do-Not-Modify]    Script Date: 2/18/2019 11:44:00 AM ******/
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA-Maint-Daily-Backup-System-Databases-Do-Not-Modify', @delete_unused_schedule=1
GO

/****** Object:  Job [DBA-Maint-Daily-Backup-System-Databases-Do-Not-Modify]    Script Date: 2/18/2019 11:44:00 AM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 2/18/2019 11:44:00 AM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA-Maint-Daily-Backup-System-Databases-Do-Not-Modify', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Step One - Daily Backup System Databases]    Script Date: 2/18/2019 11:44:00 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Step One - Daily Backup System Databases', 
		@step_id=1, 
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
    Purpose: To perform backups of system databases and place them in a designated location.
    script was kept broken down to allow for a lot of customization.  Additionally, I 
    wanted to keep it simple to correct in the event of any issues. event of any issues.
    Date Added: 2019JAN23
    Version: 001
    Revision: B
    Author: Jason M. Spencer
    Title: DBA
    Scripting Tool: Visual Studio Code
  
    //////////////////////////////////////////////////////////////////////////////////////////////
    Change Log Begins -->>
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    Change Date: 2019JAN23
    Version: 001
    Revision: B
    Author: Jason M. Spencer
    Title: DBA
    Scripting Tool: Visual Studio Code
    Changes - Added @InstanceName Variable.  Added Set values. Redeveloped folder structure on 
    HXCNAS2 to remove breaking down servers by category and created just SQL-Server-Backups. 
    The one folder will allow reuse of code.  Included breaking down into instance name then 
    on to level and type.   The changes should allow for automation and multiple instances.
    
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
SET @path = ''\\HXCNAS2\SQL-Server-Backups\'' + @ServerName + ''\'' + @InstanceName + ''\Daily\'' + @dayofweekdate  + ''\Full-Simple\System\''
 
-- specify filename format
SELECT @fileDate = CONVERT(NVARCHAR(20),GETDATE(),112) + REPLACE(CONVERT(NVARCHAR(20),GETDATE(),108),'':'','''')

DECLARE db_cursor CURSOR READ_ONLY FOR  
SELECT name 
FROM master.dbo.sysdatabases 
WHERE name = ''master'' or name = ''model'' or name = ''msdb''  -- include these databases

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
-- Revision: B
--**************************', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily User Database Backup Schedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=6, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190201, 
		@active_end_date=99991231, 
		@active_start_time=41400, 
		@active_end_time=235959, 
		@schedule_uid=N'c439422d-f1a0-42d1-a790-6fdbecc4e667'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


