/*
    //////////////////////////////////////////////////////////////////////////////////////////////
    Purpose: To perform backups of system databases on a weekly basis and place them in a designated location.
    The script was kept broken down to allow for a lot of customization.  
    Additionally, I wanted to keep it simple to correct in the event of any issues. event of any issues.
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
Set @dayofweekdate = CONVERT(nvarchar, FORMAT(GETDATE(), 'dddd')) 

-- specify database backup directory
SET @path = '\\HXCNAS2\SQL-Server-Backups\' + @ServerName + '\' + @InstanceName + '\Weekly\Full-Simple\System\'
 
-- specify filename format
SELECT @fileDate = CONVERT(NVARCHAR(20),GETDATE(),112) + REPLACE(CONVERT(NVARCHAR(20),GETDATE(),108),':','')

DECLARE db_cursor CURSOR READ_ONLY FOR  
SELECT name 
FROM master.dbo.sysdatabases 
WHERE name = 'master' or name = 'model' or name = 'msdb'  -- include these databases

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @name   
 
WHILE @@FETCH_STATUS = 0   
BEGIN   
   SET @fileName = @path + @name + '_' + @fileDate + '.bak'  
   BACKUP DATABASE @name TO DISK = @fileName  WITH COPY_ONLY, NOFORMAT, NOINIT, SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10
 
   FETCH NEXT FROM db_cursor INTO @name   
END   

CLOSE db_cursor   
DEALLOCATE db_cursor

--End of Script
-- Version: 001
-- Revision: A
--**************************