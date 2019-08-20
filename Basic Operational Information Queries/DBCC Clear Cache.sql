
CHECKPOINT

DBCC FREEPROCCACHE --This command allows you to clear the plan cache, a specific plan or a SQL Server resource pool.
DBCC FREEPROCCACHE WITH NO_INFOMSGS; --Flush the plan cached for an entire instance, but suppress the output messages.

/*
To flush a specific resource pool, we can use this command to see how much memory is being used for each resource pool.
SELECT name AS 'Pool Name', 
cache_memory_kb/1024.0 AS [cache_memory_MB], 
used_memory_kb/1024.0 AS [used_memory_MB] 
FROM sys.dm_resource_governor_resource_pools;
*/
--DBCC FREEPROCCACHE ('LimitedIOPool'); -- Then with the output above, we can specify the specific resource pool to flush as follow

/*
We can also flush a single query plan. To do this we need to first get the plan_handle from the plan cache as follows:
SELECT cp.plan_handle 
FROM sys.dm_exec_cached_plans AS cp 
CROSS APPLY sys.dm_exec_sql_text(plan_handle) AS st 
WHERE OBJECT_NAME (st.objectid) LIKE '%TestProcedure%'
*/
--DBCC FREEPROCCACHE (0x040011004A2CC30E204881F30200000001000000000000000000000000000000000000000000000000000000) --Then we can use the plan_handle as follows to flush that one query plan.

DBCC FLUSHPROCINDB --This allows you to clear the plan cache for a specific database.
--DBCC FLUSHPROCINDB(DatabaseID) --This allows you to clear the plan cache for a specific database.

DBCC FREESYSTEMCACHE('ALL') --Releases all unused cache entries from all caches. You can use this command to manually remove unused entries from all caches or from a specific Resource Governor pool.
--DBCC FREESYSTEMCACHE ('ALL') WITH MARK_IN_USE_FOR_REMOVAL -- The following example uses the MARK_IN_USE_FOR_REMOVAL clause to release entries from all current caches once the entries become unused.
--DBCC FREESYSTEMCACHE ('SQL Plans') -- Flush the ad hoc and prepared plan cache for the entire server instance.
--DBCC FREESYSTEMCACHE ('Temporary Tables & Table Variables') -- Clear all table variables and temp tables cached.
--DBCC FREESYSTEMCACHE ('userdatabase') -- Clear for a specific user database.
--DBCC FREESYSTEMCACHE ('tempdb') --Remove the tempdb cache.

DBCC FREESESSIONCACHE --Flushes the distributed query connection cache used by distributed queries against an instance of SQL Server.
--DBCC FREESESSIONCACHE [ WITH NO_INFOMSGS ]

DBCC DROPCLEANBUFFERS --Use DBCC DROPCLEANBUFFERS to test queries with a cold buffer cache without shutting down and restarting the server.
--DBCC DROPCLEANBUFFERS [ WITH NO_INFOMSGS ] --WITH NO_INFOMSGS - Suppresses all informational messages. Informational messages are always suppressed on SQL Data Warehouse and Parallel Data Warehouse.
--DBCC DROPCLEANBUFFERS ( COMPUTE | ALL ) [ WITH NO_INFOMSGS ] --COMPUTE - Purge the query plan cache from each Compute node. ALL - Purge the query plan cache from each Compute node and from the Control node. This is the default if you do not specify a value.











