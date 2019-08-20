--Name of Step
Step One - Check DB Mirror - Principal


--Execution script of text to run in master.   Change the db.name to the correct database name to check if NOT in principle.
If (select dm.mirroring_role_desc from sys.databases db
inner join sys.database_mirroring dm
on db.database_id = dm.database_id
where db.name = 'frodo_beta') <> 'PRINCIPAL'
BEGIN
        RAISERROR ('Not the Principal node of the database! Failing job to stop process.', 2, 1) WITH LOG
END