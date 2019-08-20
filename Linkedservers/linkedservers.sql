USE [master]
GO

/****** Object:  LinkedServer [HXB-PRODB-1]    Script Date: 3/20/2019 3:45:30 PM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'HXB-PRODB-1', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'HXB-PRODB-1',@useself=N'False',@locallogin=NULL,@rmtuser=N'srmlogship',@rmtpassword='########'
GO

EXEC master.dbo.sp_serveroption @server=N'HXB-PRODB-1', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXB-PRODB-1', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'HXB-PRODB-1', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXB-PRODB-1', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXB-PRODB-1', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXB-PRODB-1', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXB-PRODB-1', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXB-PRODB-1', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'HXB-PRODB-1', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'HXB-PRODB-1', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXB-PRODB-1', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'HXB-PRODB-1', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'HXB-PRODB-1', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [HXCMIRDB1]    Script Date: 3/20/2019 3:45:30 PM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'HXCMIRDB1', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'HXCMIRDB1',@useself=N'False',@locallogin=NULL,@rmtuser=N'srmlogship',@rmtpassword='########'
GO

EXEC master.dbo.sp_serveroption @server=N'HXCMIRDB1', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXCMIRDB1', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'HXCMIRDB1', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXCMIRDB1', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXCMIRDB1', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXCMIRDB1', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXCMIRDB1', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXCMIRDB1', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'HXCMIRDB1', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'HXCMIRDB1', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXCMIRDB1', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'HXCMIRDB1', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'HXCMIRDB1', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [HXLOG]    Script Date: 3/20/2019 3:45:30 PM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'HXLOG', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'HXLOG',@useself=N'False',@locallogin=NULL,@rmtuser=N'srmlogship',@rmtpassword='########'
GO

EXEC master.dbo.sp_serveroption @server=N'HXLOG', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXLOG', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'HXLOG', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXLOG', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXLOG', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXLOG', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXLOG', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXLOG', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'HXLOG', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'HXLOG', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXLOG', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'HXLOG', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'HXLOG', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [HXMIRDB]    Script Date: 3/20/2019 3:45:30 PM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'HXMIRDB', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'HXMIRDB',@useself=N'False',@locallogin=NULL,@rmtuser=N'srmlogship',@rmtpassword='########'
GO

EXEC master.dbo.sp_serveroption @server=N'HXMIRDB', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXMIRDB', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'HXMIRDB', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXMIRDB', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXMIRDB', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXMIRDB', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXMIRDB', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXMIRDB', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'HXMIRDB', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'HXMIRDB', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXMIRDB', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'HXMIRDB', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'HXMIRDB', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [hxprodbold]    Script Date: 3/20/2019 3:45:30 PM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'hxprodbold', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'hxprodbold',@useself=N'False',@locallogin=NULL,@rmtuser=N'srmlogship',@rmtpassword='########'
GO

EXEC master.dbo.sp_serveroption @server=N'hxprodbold', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'hxprodbold', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'hxprodbold', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'hxprodbold', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'hxprodbold', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'hxprodbold', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'hxprodbold', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'hxprodbold', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'hxprodbold', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'hxprodbold', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'hxprodbold', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'hxprodbold', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'hxprodbold', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [hxstagingdb1]    Script Date: 3/20/2019 3:45:30 PM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'hxstagingdb1', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'hxstagingdb1',@useself=N'True',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL
GO

EXEC master.dbo.sp_serveroption @server=N'hxstagingdb1', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'hxstagingdb1', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'hxstagingdb1', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'hxstagingdb1', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'hxstagingdb1', @optname=N'rpc', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'hxstagingdb1', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'hxstagingdb1', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'hxstagingdb1', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'hxstagingdb1', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'hxstagingdb1', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'hxstagingdb1', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'hxstagingdb1', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'hxstagingdb1', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [HXUTIL00]    Script Date: 3/20/2019 3:45:31 PM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'HXUTIL00', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'HXUTIL00',@useself=N'True',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'HXUTIL00',@useself=N'True',@locallogin=N'HEALTHX\sqlservice',@rmtuser=NULL,@rmtpassword=NULL
GO

EXEC master.dbo.sp_serveroption @server=N'HXUTIL00', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXUTIL00', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'HXUTIL00', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXUTIL00', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXUTIL00', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXUTIL00', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXUTIL00', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXUTIL00', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'HXUTIL00', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'HXUTIL00', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'HXUTIL00', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'HXUTIL00', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'HXUTIL00', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


