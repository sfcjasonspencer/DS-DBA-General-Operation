--Dont Execute this it will fail it over!
--EXEC database_mirroring_failover @printOnly = 0

--EXEC database_mirroring_failover @dbStatusOnly = 1

/*Change the Operating Mode of the databases */
/*Must be performed on pricipal server only */
--ALTER DATABASE [ARCHIVE] SET SAFETY FULL;
--ALTER DATABASE [FRODO_BETA] SET SAFETY FULL;
--ALTER DATABASE [HEALTHXSECURITY] SET SAFETY FULL;
--ALTER DATABASE [HXLOG] SET SAFETY FULL;

/* Failover Databases that are acting as PRIMARY */
/*Must be performed on pricipal server only to turn on syncronous*/
--ALTER DATABASE [ARCHIVE] SET PARTNER FAILOVER;
--ALTER DATABASE [FRODO_BETA] SET PARTNER FAILOVER;
--ALTER DATABASE [HEALTHXSECURITY] SET PARTNER FAILOVER;
--ALTER DATABASE [HXLOG] SET PARTNER FAILOVER;

/*Change the Operating Mode of the databases */
/*Must be performed on pricipal server only after failover and resync to go back to async */
--ALTER DATABASE [ARCHIVE] SET SAFETY OFF;
--ALTER DATABASE [FRODO_BETA] SET SAFETY OFF;
--ALTER DATABASE [HEALTHXSECURITY] SET SAFETY OFF;
--ALTER DATABASE [HXLOG] SET SAFETY OFF;