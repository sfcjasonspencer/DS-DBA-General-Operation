SELECT 
SPECIFIC_SCHEMA,ROUTINE_NAME,ROUTINE_TYPE,'master' FROM master.INFORMATION_SCHEMA.ROUTINES 
WHERE (ROUTINE_TYPE = 'function' OR ROUTINE_TYPE = 'procedure')
Order by ROUTINE_NAME asc

SELECT 
SPECIFIC_SCHEMA,ROUTINE_NAME,ROUTINE_TYPE,'model' FROM model.INFORMATION_SCHEMA.ROUTINES 
WHERE (ROUTINE_TYPE = 'function' OR ROUTINE_TYPE = 'procedure')
Order by ROUTINE_NAME asc

SELECT 
SPECIFIC_SCHEMA,ROUTINE_NAME,ROUTINE_TYPE,'msdb' FROM msdb.INFORMATION_SCHEMA.ROUTINES 
WHERE (ROUTINE_TYPE = 'function' OR ROUTINE_TYPE = 'procedure')
Order by ROUTINE_NAME asc

SELECT 
SPECIFIC_SCHEMA,ROUTINE_NAME,ROUTINE_TYPE,'archive' FROM archive.INFORMATION_SCHEMA.ROUTINES 
WHERE (ROUTINE_TYPE = 'function' OR ROUTINE_TYPE = 'procedure')
Order by ROUTINE_NAME asc

SELECT 
SPECIFIC_SCHEMA,ROUTINE_NAME,ROUTINE_TYPE,'DI_Process' FROM DI_Process.INFORMATION_SCHEMA.ROUTINES 
WHERE (ROUTINE_TYPE = 'function' OR ROUTINE_TYPE = 'procedure')
Order by ROUTINE_NAME asc

SELECT 
SPECIFIC_SCHEMA,ROUTINE_NAME,ROUTINE_TYPE,'di_sandbox' FROM di_sandbox.INFORMATION_SCHEMA.ROUTINES 
WHERE (ROUTINE_TYPE = 'function' OR ROUTINE_TYPE = 'procedure')
Order by ROUTINE_NAME asc

SELECT 
SPECIFIC_SCHEMA,ROUTINE_NAME,ROUTINE_TYPE,'HealthxSecurity' FROM HealthxSecurity.INFORMATION_SCHEMA.ROUTINES 
WHERE (ROUTINE_TYPE = 'function' OR ROUTINE_TYPE = 'procedure')
Order by ROUTINE_NAME asc

SELECT 
SPECIFIC_SCHEMA,ROUTINE_NAME,ROUTINE_TYPE,'frodo_production' FROM FRODO_PRODUCTION.INFORMATION_SCHEMA.ROUTINES 
WHERE (ROUTINE_TYPE = 'function' OR ROUTINE_TYPE = 'procedure')
Order by ROUTINE_NAME asc

SELECT 
SPECIFIC_SCHEMA,ROUTINE_NAME,ROUTINE_TYPE,'hxlog' FROM FRODO_PRODUCTION.INFORMATION_SCHEMA.ROUTINES 
WHERE (ROUTINE_TYPE = 'function' OR ROUTINE_TYPE = 'procedure')
Order by ROUTINE_NAME asc

SELECT 
SPECIFIC_SCHEMA,ROUTINE_NAME,ROUTINE_TYPE,'philog' FROM FRODO_PRODUCTION.INFORMATION_SCHEMA.ROUTINES 
WHERE (ROUTINE_TYPE = 'function' OR ROUTINE_TYPE = 'procedure')
Order by ROUTINE_NAME asc

