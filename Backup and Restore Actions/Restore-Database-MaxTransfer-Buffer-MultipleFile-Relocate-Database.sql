RESTORE DATABASE [ShelleySpecialOne] FROM DISK  = N'F:\DBA\ShelleyLoad\ShelleySpecialOne-20190531-P1.bak',
DISK  = N'F:\DBA\ShelleyLoad\ShelleySpecialOne-20190531-P2.bak'  WITH 
MOVE N'ShelleySpecialOne' TO N'F:\DBA\ShelleyLoad\ShelleySpecialOne.mdf', 
MOVE N'ShelleySpecialOne_log' TO N'F:\DBA\ShelleyLoad\ShelleySpecialOne_log.ldf',
REPLACE, NOUNLOAD, STATS = 5, MAXTRANSFERSIZE = 4194302, BUFFERCOUNT = 100, BLOCKSIZE = 8192
