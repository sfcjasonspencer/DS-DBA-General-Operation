USE [master]
GO
/****** 
Object:  StoredProcedure [dbo].[database_mirroring_failover]    
Script Date: 11/29/2018 3:25:18 PM 
******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:      Alejandro Cobar
-- Create date: 11/29/18
-- Description: SP to generate script for database mirroring failover execution
-- =============================================
CREATE PROCEDURE [dbo].[database_mirroring_failover] 
   @printOnly INT = 1,
   @dbStatusOnly INT = 0
AS
BEGIN
   SET NOCOUNT ON;

   DECLARE @operatingModeTSQL NVARCHAR(MAX) = '';
   DECLARE @failoverTSQL NVARCHAR(MAX) = '';
   DECLARE @messages NVARCHAR(MAX) = '';
   DECLARE @highPerformanceDBCount INT = 0;

   --Get the number of databases under HIGH PERFORMANCE mode
   SET @highPerformanceDBCount = (SELECT COUNT(*) FROM sys.database_mirroring WHERE mirroring_safety_level = 1 AND mirroring_role_desc = 'PRINCIPAL');

   --If all the databases are in HIGH SAFETY mode already, then there's no need to do anything
   IF @highPerformanceDBCount > 0 
   BEGIN
      SET @messages += '/* These databases must be changed to HIGH SAFETY MODE */'+CHAR(13);
      DECLARE @db VARCHAR(128);

      DECLARE mirroring_mode_cursor CURSOR FOR SELECT DB_NAME(database_id) FROM sys.database_mirroring WHERE mirroring_safety_level = 1;

      OPEN mirroring_mode_cursor  
      FETCH NEXT FROM mirroring_mode_cursor INTO @db
   
      WHILE @@FETCH_STATUS = 0  
      BEGIN
         SET @messages += 'ALTER DATABASE '+@db+' SET SAFETY FULL;'+CHAR(13);
         SET @operatingModeTSQL += 'ALTER DATABASE '+@db+' SET SAFETY FULL;'+CHAR(13);  
         FETCH NEXT FROM mirroring_mode_cursor INTO @db 
      END

      CLOSE mirroring_mode_cursor;   
      DEALLOCATE mirroring_mode_cursor;  
   END
   ELSE
      SET @messages += '/* All databases are either already in HIGH SAFETY mode or nothing can be done from the DR instance */'+CHAR(13);
   
   --Prepare the failover statements for all the databases
   DECLARE @primaryDatabases INT = 0;
   SET @messages += CHAR(13)+'/* Statements to failover the databases acting as PRIMARY */';
   SET @db = '';

   DECLARE failover_cursor CURSOR FOR SELECT DB_NAME(database_id) FROM sys.database_mirroring WHERE mirroring_role_desc = 'PRINCIPAL';

   OPEN failover_cursor  
   FETCH NEXT FROM failover_cursor INTO @db
   
   WHILE @@FETCH_STATUS = 0  
   BEGIN
      SET @primaryDatabases += 1;
      SET @messages += CHAR(13)+'ALTER DATABASE '+@db+' SET PARTNER FAILOVER;';
      SET @failoverTSQL += CHAR(13)+'ALTER DATABASE '+@db+' SET PARTNER FAILOVER;';  
      FETCH NEXT FROM failover_cursor INTO @db 
   END

   CLOSE failover_cursor;   
   DEALLOCATE failover_cursor;
   
   IF @primaryDatabases = 0
      SET @messages += CHAR(13)+'## There are no databases acting as the PRINCIPAL...';

   IF @dbStatusOnly = 0
   BEGIN
      IF @printOnly = 1
         PRINT @messages;
      ELSE
      BEGIN
         EXEC sp_executesql @operatingModeTSQL;
      
         --Failover only if the databases are fully SYNCHRONIZED
         DECLARE @synchronized INT = 1;
         WHILE @synchronized <> 0 
         BEGIN
            SET @synchronized = (SELECT COUNT(*) FROM sys.database_mirroring WHERE mirroring_state <> 4);
            WAITFOR DELAY '00:00:01'
         END

         EXEC sp_executesql @failoverTSQL;
      END
   END
         
   --Display the status of the databases
   SELECT 
   DB_NAME(database_id) AS 'DB',
   mirroring_role_desc  AS 'Role',
   mirroring_state_desc AS 'State',
   CASE mirroring_role_desc
      WHEN 'MIRROR'    THEN mirroring_partner_instance
      WHEN 'PRINCIPAL' THEN SERVERPROPERTY('SERVERNAME')
   END AS 'Principal Instance',
   CASE mirroring_role_desc
      WHEN 'MIRROR'    THEN SERVERPROPERTY('SERVERNAME')
      WHEN 'PRINCIPAL' THEN mirroring_partner_instance
   END AS 'DR Instance',
   CASE mirroring_safety_level
      WHEN 1 THEN 'HIGH PERFORMANCE'
      WHEN 2 THEN 'HIGH SAFETY'
   END AS 'Operating Mode'
   FROM sys.database_mirroring
   WHERE mirroring_state IS NOT NULL;
END