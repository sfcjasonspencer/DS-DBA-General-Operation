select session_id as SPID , command, a.text as query, start_time, percent_complete, dateadd(second, estimated_completion_time/10000, getdate()) as estimated_completion_time
FROM sys.dm_exec_requests r cross apply sys.dm_exec_sql_text(r.sql_handle) a
WHERE r.command in ('BACKUP DATABASE', 'RESTORE DATABASE','RESTORE LOG','BACKUP LOG')
