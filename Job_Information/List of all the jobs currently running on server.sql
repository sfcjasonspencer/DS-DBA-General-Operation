-- List of all the jobs currently running on server
SELECT distinct name,
     job.job_id,
     notify_level_email,    
     enabled,
     description,
     step_name,
     command,
     server,
     database_name
FROM
    msdb.dbo.sysjobs job
INNER JOIN 
    msdb.dbo.sysjobsteps steps        
ON
    job.job_id = steps.job_id
	where description like 'No description available.'
	Order by name asc
