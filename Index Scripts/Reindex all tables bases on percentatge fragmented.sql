USE frodo_beta
GO
EXEC sp_MSforeachtable @command1="print '?' DBCC DBREINDEX ('?', ' ', 70)"
GO
EXEC sp_updatestats
GO