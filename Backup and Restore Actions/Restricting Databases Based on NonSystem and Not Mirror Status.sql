select db.name, dm.mirroring_role_desc from sys.databases db
inner join sys.database_mirroring dm
on db.database_id = dm.database_id
inner join master.dbo.sysdatabases sysdb
on sysdb.name =db.name
WHERE sysdb.name NOT IN ('master','model','msdb','tempdb') and dm.mirroring_role_desc <> 'MIRROR' or sysdb.name NOT IN ('master','model','msdb','tempdb') and dm.mirroring_role_desc is null
