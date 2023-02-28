--Store Proc to create SnapShot database.    
	 
	USE [AdminITI]
	GO
	 
	/****** Object:  StoredProcedure [dbo].[Create_Database_Snapshot]    Script Date: 5/7/2020 4:32:46 AM ******/
	SET ANSI_NULLS ON
	GO
	 
	SET QUOTED_IDENTIFIER ON
	GO
	 
	 
	 
	/*
	** Title:     Create_Database_Snapshot
	** Date:             2020-05-07
	** Author:    Matt Atkinson
	**
	** Desc:      This script will generate SQL based on the source database and target appended name in order to generate a database snapshot.
	**                   Please read comments at the end of variables. Debug is on by default.
	**
	*/
	CREATE PROCEDURE [dbo].[Create_Database_Snapshot] 
	 @SourceDatabase   varchar(128)         -- Name of database you want to snapshot.
	,@SnapshotAppend   varchar(128) = NULL  -- What you want to append to the snapshot database name. The default is "Snapshot_YYYMMDD" (Eg: Snapshot_20200507_093000)
	,@FilePath         varchar(200) = NULL  -- Edit if you want the snapshot "SS" file to reside somewhere else. (Eg: 'D:\Override\Path\')
	,@Debug            bit = 0
	 
	AS
	BEGIN
	 
	   SET NOCOUNT ON;
	   
	   DECLARE @FileSql   varchar(1500),
	              @SnapSql      nvarchar(1500);
	   
	   IF DB_ID(@SourceDatabase) IS NULL
	       RAISERROR('Database doesn''t exist. Please check spelling and instance you are connected to.',1,1)
	   
	   IF (@SnapshotAppend IS NULL)
	       SET @SnapshotAppend = 'Snapshot_' + FORMAT(getdate(), 'yyyyMMdd')
	   
	   --==================================
	   -- Dynamically build up a list of files for the database to snapshot.
	   --==================================
	   SELECT @FileSql =
	       CASE -- Case statement used to wrap a comma in the right place.
	              WHEN @FileSql <> '' 
	              THEN + ','
	              ELSE ''
	       END + '       
	              ( NAME = ' + mf.name + ', FILENAME = ''' + ISNULL(@FilePath, LEFT(mf.physical_name,LEN(mf.physical_name)- 4 ) ) + '_' + @SnapshotAppend + '.ss'')'
	              -- Remove file extension .mdf, .ndf, and add .ss
	       FROM sys.master_files AS mf
	              INNER JOIN sys.databases AS db ON db.database_id = mf.database_id
	       WHERE db.state = 0 -- Only include database online.
	              AND mf.type = 0 -- Only include data files.
	              AND db.[name] = @SourceDatabase
	   
	   --==================================    
	   -- Build the create snapshot syntax.
	   --==================================
	   SET @SnapSql =
	   'CREATE DATABASE ' + @SourceDatabase + '_' + @SnapshotAppend 
	              + ' ON ' + @FileSql 
	              + ' AS SNAPSHOT OF '+ @SourceDatabase + ';'
	   
	   --==================================
	   -- Print or execute the dynamic sql.
	   --==================================
	   IF (@Debug = 1)
	        PRINT @SnapSql
	   ELSE
	        EXEC sp_executesql @stmt = @SnapSql
	   
	END
	 
	GO
