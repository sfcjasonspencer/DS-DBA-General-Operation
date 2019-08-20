select  db_name(dbid) , count(*) 'connections count'
from master..sysprocesses
where spid > 50 and spid != @@spid
group by  db_name(dbid)
order by count(*) desc

select  loginame , nt_username, count(*) 'Connections count'
from master..sysprocesses
where spid > 50 and spid != @@spid
group by  loginame , nt_username
order by count(*) desc
