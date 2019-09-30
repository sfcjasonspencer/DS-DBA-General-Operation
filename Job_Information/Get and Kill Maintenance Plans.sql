--> try below as a workaround,

exec msdb.dbo.sp_maintplan_delete_plan @plan_id=N'{PLAN_ID_OF_MAINT_PLAN}'

--dont forgot to place you plan_id betweeen {} .

-- You can get the maint plan id from below query,

select s.name,s.id as [plan_id] from msdb.dbo.sysmaintplan_plans as s

exec msdb.dbo.sp_maintplan_delete_plan @plan_id=N'{F97C3537-00C6-4F0E-8947-0625E1F5FB4A}'

exec msdb.dbo.sp_maintplan_delete_plan @plan_id=N'{702412CB-0E88-42ED-A5E4-FBFAB925ACC9}'