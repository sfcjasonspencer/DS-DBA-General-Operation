SELECT  HOST_NAME() AS 'host_name()',
@@servername AS 'ServerName\InstanceName',
SERVERPROPERTY('servername') AS 'ServerName',
SERVERPROPERTY('machinename') AS 'Windows_Name',
SERVERPROPERTY('ComputerNamePhysicalNetBIOS') AS 'NetBIOS_Name',
SERVERPROPERTY('instanceName') AS 'InstanceName',
SERVERPROPERTY('IsClustered') AS 'IsClustered'


--1.Execute below to drop the current server name
 
EXEC sp_DROPSERVER 'HXPRODB'
 
--2.Execute below to add a new server name. Make sure local is specified.

EXEC sp_ADDSERVER 'HXPRODB_DR', 'local'
 
--3.Restart SQL Services.

--4.Verify the new name using:  


SELECT @@SERVERNAME
 
 
SELECT * FROM sys.servers WHERE server_id = 0
 
 
--I must point out that you should not perform rename if you are using:
--1.SQL Server is clustered.
--2.Using replication.
--3.Reporting Service is installed.
