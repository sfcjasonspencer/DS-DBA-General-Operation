SELECT  sysjobs.name 'Job Name',
        syscategories.name 'Category',
        CASE [description]
          WHEN 'No Description available.' THEN ''
          ELSE [description]
        END AS 'Description'
FROM    msdb.dbo.sysjobs
        INNER JOIN msdb.dbo.syscategories ON msdb.dbo.sysjobs.category_id = msdb.dbo.syscategories.category_id
WHERE   syscategories.name <> 'Report Server'
ORDER BY sysjobs.name 
