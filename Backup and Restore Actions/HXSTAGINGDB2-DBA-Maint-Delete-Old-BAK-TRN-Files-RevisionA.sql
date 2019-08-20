/*
 //////////////////////////////////////////////////////////////////////////////////////////////
    Purpose: To remove .bak files from a file location based on a specified amount of time
        from the results of get date. The script was kept broken down to allow for a 
        lot of customization of what to turn off and on and the ability to add easily.
        Additionally, I wanted to keep it simple to correct in the event of any issues.
    Date Added: 2019JAN23
    Version: 001
    Revision: A
    Author: Jason M. Spencer
    Title: DBA
    Scripting Tool: Visual Studio Code

    Additional Notes:
    Note 001: When using the xp_delete_file only goes one subfolder down. The items below explain each
    portion of the scripts use.
        FileTypeSelected (0 = FileBackup, 1 = FileReport)
        folder path (trailing slash)
        file extension which needs to be deleted (no dot)
        date prior which to delete
        subfolder flag (1 = include files in first subfolder level, 0 = not)
    Note 002: The line is commented out due to it not being needed at this time.  xp_delete_file only 
    goes one subfolder down.  The  folder stucture uses, for example, Full-Simple and under that folder 
    is the System and Users folder which contains the .bak files.  The level indicated here could be 
    used for **One off ** backups and this comment can be turned back on. 
      
//////////////////////////////////////////////////////////////////////////////////////////////
	Change Log Begins -->>
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
	Change Log Ends -->>
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
*/
--Declare the variables here
DECLARE @DeleteDailyDate datetime
DECLARE @DeleteWeeksDate datetime
DECLARE @DeleteMonthsDate datetime

--Set the value of the variables
SET @DeleteDailyDate = DateAdd(Day, -7, GetDate())
SET @DeleteWeeksDate = DateAdd(Week, -5, GetDate())
SET @DeleteMonthsDate = DateAdd(Month, -12, GetDate())

--See Note 002 at the top of script.
--EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Sunday\', N'BAK',@DeleteDailyDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Sunday\Differential\', N'BAK',@DeleteDailyDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Sunday\Full-Simple\', N'BAK',@DeleteDailyDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Sunday\Transactional\', N'TRN',@DeleteDailyDate, 1

--See Note 002 at the top of script.
--EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\', N'BAK',@DeleteDailyDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Monday\Differential\', N'BAK',@DeleteDailyDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Monday\Full-Simple\', N'BAK',@DeleteDailyDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Monday\Transactional\', N'TRN',@DeleteDailyDate, 1

--See Note 002 at the top of script.
--EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\', N'BAK',@DeleteDailyDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Tuesday\Differential\', N'BAK',@DeleteDailyDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Tuesday\Full-Simple\', N'BAK',@DeleteDailyDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Tuesday\Transactional\', N'TRN',@DeleteDailyDate, 1

--See Note 002 at the top of script.
--EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\', N'BAK',@DeleteDailyDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Wednesday\Differential\', N'BAK',@DeleteDailyDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Wednesday\Full-Simple\', N'BAK',@DeleteDailyDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Wednesday\Transactional\', N'TRN',@DeleteDailyDate, 1

--See Note 002 at the top of script.
--EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\', N'BAK',@DeleteDailyDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Thursday\Differential\', N'BAK',@DeleteDailyDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Thursday\Full-Simple\', N'BAK',@DeleteDailyDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Thursday\Transactional\', N'TRN',@DeleteDailyDate, 1

--See Note 002 at the top of script.
--EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\', N'BAK',@DeleteDailyDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Friday\Differential\', N'BAK',@DeleteDailyDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Friday\Full-Simple\', N'BAK',@DeleteDailyDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Friday\Transactional\', N'TRN',@DeleteDailyDate, 1

--See Note 002 at the top of script.
--EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\', N'BAK',@DeleteDailyDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Saturday\Differential\', N'BAK',@DeleteDailyDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Saturday\Full-Simple\', N'BAK',@DeleteDailyDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Daily\Saturday\Transactional\', N'TRN',@DeleteDailyDate, 1

-- Starts weekly folder search and delete
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Weekly\Differential\', N'BAK',@DeleteWeeksDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Weekly\Full-Simple\', N'BAK',@DeleteWeeksDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Weekly\Transactional\', N'TRN',@DeleteWeeksDate, 1

-- Starts monthly folder search and delete
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\January\Differential\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\January\Full-Simple\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\January\Transactional\', N'TRN',@DeleteMonthsDate, 1

EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\February\Differential\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\February\Full-Simple\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\February\Transactional\', N'TRN',@DeleteMonthsDate, 1

EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\March\Differential\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\March\Full-Simple\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\March\Transactional\', N'TRN',@DeleteMonthsDate, 1

EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\April\Differential\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\April\Full-Simple\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\April\Transactional\', N'TRN',@DeleteMonthsDate, 1

EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\May\Differential\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\May\Full-Simple\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\May\Transactional\', N'TRN',@DeleteMonthsDate, 1

EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\June\Differential\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\June\Full-Simple\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\June\Transactional\', N'TRN',@DeleteMonthsDate, 1

EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\July\Differential\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\July\Full-Simple\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\July\Transactional\', N'TRN',@DeleteMonthsDate, 1

EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\August\Differential\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\August\Full-Simple\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\August\Transactional\', N'TRN',@DeleteMonthsDate, 1

EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\September\Differential\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\September\Full-Simple\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\September\Transactional\', N'TRN',@DeleteMonthsDate, 1

EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\October\Differential\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\October\Full-Simple\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\October\Transactional\', N'TRN',@DeleteMonthsDate, 1

EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\November\Differential\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\November\Full-Simple\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\November\Transactional\', N'TRN',@DeleteMonthsDate, 1

EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\December\Differential\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\December\Full-Simple\', N'BAK',@DeleteMonthsDate, 1
EXECUTE master.sys.xp_delete_file 0, N'\\HXCNAS2\SQL-Server-Backups\HXSTAGINGDB2\MSSQLSERVER\Monthly\December\Transactional\', N'TRN',@DeleteMonthsDate, 1

--End of Script
-- Version: 001
-- Revision: A
--**************************


