select [name], DATABASEPROPERTYEX([name],'recovery')

from sysdatabases

where name not in ('master','model','tempdb','msdb')