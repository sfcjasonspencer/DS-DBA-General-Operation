SELECT
    [sJOB].[job_id] AS [JobID]
    , [sJOB].[name] AS [JobName]
	, [sDBP].[name] AS [JobOwner]
    , [sCAT].[name] AS [JobCategory]
    , [sJOB].[description] AS [JobDescription]
    , CASE [sJOB].[enabled]
        WHEN 1 THEN 'Yes'
        WHEN 0 THEN 'No'
      END AS [IsEnabled]
    , [sJOB].[date_created] AS [JobCreatedOn]
    , [sJOB].[date_modified] AS [JobLastModifiedOn]
    , [sJSTP].[step_uid] AS [StepID]
    , [sJSTP].[step_id] AS [StepNo]
    , [sJSTP].[step_name] AS [StepName]
    , CASE [sJSTP].[last_run_outcome]
        WHEN 0 THEN 'Failed'
        WHEN 1 THEN 'Succeeded'
        WHEN 2 THEN 'Retry'
        WHEN 3 THEN 'Canceled'
        WHEN 5 THEN 'Unknown'
      END AS [LastRunStatus]
    , STUFF(
            STUFF(RIGHT('000000' + CAST([sJSTP].[last_run_duration] AS VARCHAR(6)),  6)
                , 3, 0, ':')
            , 6, 0, ':')
      AS [LastRunDuration (HH:MM:SS)]
    , [sJSTP].[last_run_retries] AS [LastRunRetryAttempts]
    , CASE [sJSTP].[last_run_date]
        WHEN 0 THEN NULL
        ELSE 
            CAST(
                CAST([sJSTP].[last_run_date] AS CHAR(8))
                + ' ' 
                + STUFF(
                    STUFF(RIGHT('000000' + CAST([sJSTP].[last_run_time] AS VARCHAR(6)),  6)
                        , 3, 0, ':')
                    , 6, 0, ':')
                AS DATETIME)
      END AS [LastRunDateTime]
FROM
    [msdb].[dbo].[sysjobsteps] AS [sJSTP]
    INNER JOIN [msdb].[dbo].[sysjobs] AS [sJOB]
        ON [sJSTP].[job_id] = [sJOB].[job_id]
		LEFT JOIN [msdb].[sys].[servers] AS [sSVR]
        ON [sJOB].[originating_server_id] = [sSVR].[server_id]
    LEFT JOIN [msdb].[dbo].[syscategories] AS [sCAT]
        ON [sJOB].[category_id] = [sCAT].[category_id]
        LEFT JOIN [msdb].[sys].[database_principals] AS [sDBP]
        ON [sJOB].[owner_sid] = [sDBP].[sid]
    LEFT JOIN [msdb].[dbo].[sysjobschedules] AS [sJOBSCH]
        ON [sJOB].[job_id] = [sJOBSCH].[job_id]
    LEFT JOIN [msdb].[dbo].[sysschedules] AS [sSCH]
        ON [sJOBSCH].[schedule_id] = [sSCH].[schedule_id]
		WHERE sCAT.name NOT LIKE 'Database Maintenance'
ORDER BY [JobName], [StepNo]

