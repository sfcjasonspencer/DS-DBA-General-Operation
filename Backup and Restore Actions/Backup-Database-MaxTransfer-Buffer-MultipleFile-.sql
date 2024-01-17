BACKUP DATABASE [ShelleySpecialOne]
TO DISK = N'D:\SQL-Server-Backups\HXCNAS2\MSSQLSERVER\On-Demand\ShelleySpecialOne-20190531-P1.bak',
DISK = N'D:\SQL-Server-Backups\HXCNAS2\MSSQLSERVER\On-Demand\ShelleySpecialOne-20190531-P2.bak'
WITH NOFORMAT, INIT, SKIP, NOREWIND, NOUNLOAD, COMPRESSION, MAXTRANSFERSIZE = 2097152, STATS = 5, BUFFERCOUNT = 100, BLOCKSIZE = 8192, STATS=10


https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/sql-server-backup-to-url-best-practices-and-troubleshooting?view=sql-server-ver16
BACKUP DATABASE mydb
TO URL = 'https://mystorage.blob.core.windows.net/mycontainer/mydbBackupSetNumber2_0.bak',
URL = 'https://mystorage.blob.core.windows.net/mycontainer/mydbBackupSetNumber2_1.bak',
URL = 'https://mystorage.blob.core.windows.net/mycontainer/mydbBackupSetNumber2_2.bak'
WITH COMPRESSION, MAXTRANSFERSIZE = 4194304, BLOCKSIZE = 65536;  

 'https://devitiblob2.blob.core.windows.net/sqlbackups/FTWSTSSQRP01/Daily/Thursday/Full-Simple/User/FL_WTS_Data_Prod_20231012152906_1.bak', URL = 'https://devitiblob2.blob.core.windows.net/sqlbackups/FTWSTSSQRP01/Daily/Thursday/Full-Simple/User/FL_WTS_Data_Prod_20231012152906_2.bak', URL = 'https://devitiblob2.blob.core.windows.net/sqlbackups/FTWSTSSQRP01/Daily/Thursday/Full-Simple/User/FL_WTS_Data_Prod_20231012152906_3.bak', URL = 'https://devitiblob2.blob.core.windows.net/sqlbackups/FTWSTSSQRP01/Daily/Thursday/Full-Simple/User/FL_WTS_Data_Prod_20231012152906_4.bak', URL = 'https://devitiblob2.blob.core.windows.net/sqlbackups/FTWSTSSQRP01/Daily/Thursday/Full-Simple/User/FL_WTS_Data_Prod_20231012152906_5.bak', URL = 'https://devitiblob2.blob.core.windows.net/sqlbackups/FTWSTSSQRP01/Daily/Thursday/Full-Simple/User/FL_WTS_Data_Prod_20231012152906_6.bak', URL = 'https://devitiblob2.blob.core.windows.net/sqlbackups/FTWSTSSQRP01/Daily/Thursday/Full-Simple/User/FL_WTS_Data_Prod_20231012152906_7.bak', URL = 'https://devitiblob2.blob.core.windows.net/sqlbackups/FTWSTSSQRP01/Daily/Thursday/Full-Simple/User/FL_WTS_Data_Prod_20231012152906_8.bak' 


https://devitiblob2.blob.core.windows.net/sqlbackups/LZ1/FL_WTS_Data_Prod_20231012155145_1.bak, URL = https://devitiblob2.blob.core.windows.net/sqlbackups/LZ1/FL_WTS_Data_Prod_20231012155145_2.bak