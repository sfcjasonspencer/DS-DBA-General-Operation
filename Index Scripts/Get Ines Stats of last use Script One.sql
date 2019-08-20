SELECT
      row_number() over(order by user_seeks,user_lookups,user_scans),
      [Database] = d.name,
      [Schema]= s.name,
      [Table]= o.name,
      [Index]= x.name,
      [Scans] = user_scans,
      [Seeks] = user_seeks,
      [Lookups] = user_lookups,
      [Last Scan] = last_user_scan,
      [System Scans] = system_scans
FROM  sys.dm_db_index_usage_stats u
INNER JOIN sys.sysdatabases d on u.database_id = d.dbid
INNER JOIN sys.sysindexes x on u.object_id = x.id  and u.index_id = x.indid
INNER JOIN sys.objects o on u.object_id = o.object_id
INNER JOIN sys.schemas s on s.schema_id = o.schema_id
--where  x.name is not null
where  x.name ='ix_Notifications_TypeSpecificDetail'
order by 1 desc