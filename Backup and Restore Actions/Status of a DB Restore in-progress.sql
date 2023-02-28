	SELECT 
		session_id as SPID, 
		command, 
		a.text AS Query, 
		start_time, 
		percent_complete, 
		dateadd(second,estimated_completion_time/1000, getdate()) as estimated_completion_time 
	FROM sys.dm_exec_requests r CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) a 
	WHERE r.command IN 
		('BACKUP DATABASE','RESTORE DATABASE','RESTORE LOG','DBCC TABLE CHECK','ALTER DATABASE','DbccFilesCompact')
	--
	SELECT  
	    d.PERCENT_COMPLETE AS [%Complete],
	    d.TOTAL_ELAPSED_TIME/60000 AS ElapsedTimeMin,
	    d.ESTIMATED_COMPLETION_TIME/60000   AS TimeRemainingMin,
	    d.TOTAL_ELAPSED_TIME*0.00000024 AS ElapsedTimeHours,
	    d.ESTIMATED_COMPLETION_TIME*0.00000024  AS TimeRemainingHours,
	    s.text AS Command
	FROM sys.dm_exec_requests d 
	CROSS APPLY sys.dm_exec_sql_text(d.sql_handle)as s
	--WHERE d.COMMAND IN 
	  --  ('BACKUP DATABASE','RESTORE DATABASE','RESTORE LOG','DBCC TABLE CHECK','ALTER DATABASE','DbccFilesCompact')
ORDER   BY 2 desc, 3 DESC
