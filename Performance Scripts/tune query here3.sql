DECLARE @checknums as nvarchar(15)
DECLARE @payororgid as nvarchar(75) = '97BB87B5-4933-4942-A8CF-884D4E3E6741'
DECLARE @excludeRClaims as nvarchar(15)
DECLARE @@orgproviderid as nvarchar(15) = '111631788'
DECLARE @pcpname as nvarchar(15) ='SUDHEER S CHAUHAN'
DECLARE @searchnpi as nvarchar(15) = '1245370717'
DECLARE @tins as nvarchar(15) = '111631788'
DECLARE @npis as nvarchar(15)
DECLARE 


with claims as (select *, count(*) OVER() TotalRecordCount, ROW_NUMBER() OVER (order by  ClaimNum ASC) RowNum      
from (select distinct ch.*,dbo.FullNameToLastFirst(ch.PTName) as PTNameLastFirst,              
dbo.FullNameToLastFirst(ch.EmployeeName) as EmployeeNameLastFirst          
from  (select ch.* from claimheaders ch with(index(i_claimheaders_PayorOrgID_CheckNum), nolock)              
inner join 
split_string(@checknums, ',', -1) on (ch.checknum like item + '%') 
where ch.payororgid = @payororgid                  
and (@excludeRClaims = 0 or ch.RestrictClaim <> 'R' 
or ch.RestrictClaim is null)                 
 and (ch.orgproviderid = '111631788')                  
 and (ch.PCP = @pcpname)                  
 and (ch.npin = @searchnpi)
 union              
 select ch.* from claimheaders ch (nolock)              
 inner join 
 claimlines cl with(index(IX_PayororgidChecknum), nolock) 
 on (ch.claimhdrid = cl.claimhdrid)              
 inner join split_string(@checknums, ',', -1) 
 on (cl.checknum like item + '%')             
 where cl.payororgid = @payororgid                  
 and (@excludeRClaims = 0 
 or ch.RestrictClaim <> 'R' 
 or ch.RestrictClaim is null)                  
 and (ch.orgproviderid ='111631788')) ch          
 left outer join              
 (select groupnum, begindate, enddate from hx_orggroups_providerfilter (nolock)              
 where payororgid = @payororgid) ogp                  
 on (ch.employergroupnum = ogp.groupnum)          
 left outer join (select item as tin from split_string(@tins, ',', -1)) hut 
 on (ch.provtin = hut.tin or ch.mastertin = hut.tin)          
 left outer join (select item as npi from split_string(@npis, ',', -1)) hun 
 on (ch.npin = hun.npi)          
 where ((ogp.groupnum is null)                  
 or (ch.dosstart is null)                  
 or (((ogp.begindate is null)                      
 or (ch.dosstart >= ogp.begindate))                      
 and ((ogp.enddate is null)                          
 or (ch.dosstart < ogp.enddate))))             
 and (hut.tin is not null or hun.npi is not null)      ) namedcols  )  
 select *  from claims  where RowNum between @startindex and @endindex