SELECT j.[job_id], j.[name] [job_name], j.[category_id], c.name [category_name]
FROM [msdb].[dbo].[sysjobs] j
JOIN [msdb].[dbo].[syscategories] c
ON j.category_id = c.category_id
Where j.category_id = 3 and j.name not like 'auto dataset%'
ORDER BY 2