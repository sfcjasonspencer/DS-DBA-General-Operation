--use msdb
--go

exec msdb.dbo.sp_start_job N'DBMaintenance-Full-Backup-Cursor-System-BAK'

exec msdb.dbo.sp_start_job N'DBMaintenance-Full-Backup-Cursor-Users-BAK'

exec msdb.dbo.sp_start_job N'DBMaintenance-Transactional-Backup-Cursor-Users-TRN'