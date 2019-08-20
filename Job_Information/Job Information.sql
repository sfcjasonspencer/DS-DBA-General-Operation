SELECT  sysjobs.name 'Job Name',
        syscategories.name 'Category',[description]
		--,
        --CASE [description]
        --  WHEN 'No Description available.' THEN ''
        --  ELSE [description]
        --END AS 'Description'
FROM    msdb.dbo.sysjobs
        INNER JOIN msdb.dbo.syscategories ON msdb.dbo.sysjobs.category_id = msdb.dbo.syscategories.category_id
WHERE   syscategories.name <> 'Report Server' and syscategories.name <> 'Index Rebuilds' and syscategories.name <> 'Database Maintenance' 
and syscategories.name like '[Uncategorized (Local)]' or sysjobs.description like 'No description available.'
ORDER BY sysjobs.name 


select name from msdb.dbo.syscategories