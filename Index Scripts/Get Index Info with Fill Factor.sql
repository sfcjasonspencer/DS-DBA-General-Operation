select object_id, NAME, fill_factor, TableName, (SELECT TOP 1 rows FROM sysindexes where id=OBJECT_ID(TableName))RowCountTotal  from [vw_index-80-or-less-fill-dba-use-only] (nolock)
order by tablename asc







