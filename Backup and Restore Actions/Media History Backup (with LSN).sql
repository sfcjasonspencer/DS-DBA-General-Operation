-- Get Media Backup History for required database
SELECT TOP 100000 s.database_name
	,CASE m.device_type
		WHEN 2        THEN 'Disk'
		WHEN 5        THEN 'Tape'
		WHEN 7        THEN 'Virtual Device'
		WHEN 9        THEN 'Azure Storag'
		WHEN 105    THEN 'Perm Backup Device'
		-- ELSE
	END AS Device_type
	,m.physical_device_name
	,CAST(CAST(s.backup_size/1024000 AS decimal(18)) AS VARCHAR(14))  AS 'Size (MB)'
	,s.backup_start_date
	--s.backup_finish_date
	,DATEDIFF(second, s.backup_start_date, s.backup_finish_date) as 'Duration (sec)'
	,CAST(s.first_lsn AS VARCHAR(50)) AS first_LSN
	,CAST(s.last_lsn AS VARCHAR(50))  AS last_LSN
	,CASE s.[type]
		WHEN 'D'    THEN 'Full'
		WHEN 'I'    THEN 'Differential'
		WHEN 'L'    THEN 'Transaction Log'
		Else 'Other'
	END AS BackupType
	,s.server_name
	,s.recovery_model
	FROM msdb.dbo.backupset s
		INNER JOIN msdb.dbo.backupmediafamily m 
			ON s.media_set_id = m.media_set_id
	WHERE  s.backup_start_date >= '2019-09-28 18:00:00'
	     AND s.[type] <> 'L' -- L=Log  f=Full  D=Diff
	  -- AND s.database_name = DB_NAME() -- Remove this line for all the database
	  -- AND m.physical_device_name not like '\\%'
	ORDER BY s.database_name, backup_start_date DESC, backup_finish_date
GO
