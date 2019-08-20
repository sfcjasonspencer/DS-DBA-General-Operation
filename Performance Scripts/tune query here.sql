USE [frodo_production]
GO

/****** Object:  StoredProcedure [dbo].[hx_claimsystem_providerdatesearch_dba]    Script Date: 3/5/2019 2:09:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[hx_claimsystem_providerdatesearch_dba]
	@pageNum int = 1,
	@pageSize int = 0,
	@pageStart int,
    @pageEnd int,
	@payororgid uniqueidentifier,
	@orgproviderid varchar(100),
	@pcpname varchar(100) = null,
	@searchnpi varchar(100) = null,
	@dob datetime,
	@begindate datetime,
	@enddate datetime,
	@tinfilter int,
	@tins varchar(8000),
	@npis varchar(8000),
	@filterorgproviderids varchar(8000),
	@claimstatus varchar(100),
	@firstname varchar(100),  
	@startindex int,
	@count int,
	@sortfield varchar(100),
	@sortdirection varchar(4),
	@groupRestriction varchar(200),
	@groupRevoke bit,
	@locationRestriction varchar(200),
	@locationRevoke bit,
    @excludeRClaims bit
as
begin
SELECT
    @pageStart = @pageSize * @pageNum - (@pageSize - 1),
    @pageEnd = @pageSize * @pageNum;

declare @endindex int
set @endindex = (@startindex + @count - 1)
declare @orderby varchar(200)
set @orderby = dbo.GetClaimOrderByClause(@sortfield, @sortdirection)

declare @groupClause varchar(max)
declare @locationClause varchar(max)
set @groupClause = dbo.GetColumnRestrictionClause(@groupRestriction, @groupRevoke, 'EmployerGroupNum', NULL, 1)
set @locationClause = dbo.GetColumnRestrictionClause(@locationRestriction, @locationRevoke, 'Location', NULL, 1)

declare @stmt nvarchar(max)
set @stmt = '
with claims as (
    select *, (Select count(*) from claims) as TotalRecordCount (order by  ' + @orderby + ') RowNum
    from (
		select distinct ch.*,
			dbo.FullNameToLastFirst(PTName) as PTNameLastFirst,
			dbo.FullNameToLastFirst(EmployeeName) as EmployeeNameLastFirst
		from claimheaders ch (nolock)
		left outer join
			(select groupnum, begindate, enddate
			from hx_orggroups_providerfilter (nolock)
			where payororgid = @payororgid) ogp
			on (ch.employergroupnum = ogp.groupnum)'

-- @tinfilter
-- 0 = None  -- not allowed
-- 1 = TIN only
-- 2 = NPI only
-- 3 = TIN or NPI
-- 4 = TIN and NPI
-- 5 = OrgProviderID only
-- 6 = TIN or NPI or OrgProviderID
declare @join varchar(100)
if (@tinfilter = 3 or @tinfilter = 6)
	set @join = 'left outer join'
else
	set @join = 'inner join'

if (@tinfilter <> 2 and @tinfilter <> 5)
    set @stmt = @stmt + '
		' + @join + ' (select item as tin from split_string(@tins, '','', -1)) hut on (ch.provtin = hut.tin or ch.mastertin = hut.tin)'

if (@tinfilter = 2 or @tinfilter = 3 or @tinfilter = 4 or @tinfilter = 6)
    set @stmt = @stmt + '
		' + @join + ' (select item as npi from split_string(@npis, '','', -1)) hun on (ch.npin = hun.npi)'

if (@tinfilter = 5 or @tinfilter = 6)
    set @stmt = @stmt + '
		' + @join + ' (select item from split_string(@filterorgproviderids, '','', -1)) huo on (ch.orgproviderid = huo.item)'

set @stmt = @stmt + '
		where ch.payororgid = @payororgid
			and (@excludeRClaims = 0 or RestrictClaim <> ''R'' or RestrictClaim is null)
			and (orgproviderid = @orgproviderid)
			and ((len(isnull(@pcpname, '''')) <= 0) or (ch.PCP = @pcpname))
			and ((len(isnull(@searchnpi, '''')) <= 0) or (ch.npin = @searchnpi))
			and ((@begindate is null or (dosstart >= @begindate))
				and (@enddate is null or (dosstart <= @enddate))
				)
			and ((@dob is null) or (ptdob = @dob))
			and ((ogp.groupnum is null)
				or (ch.dosstart is null)
				or (((ogp.begindate is null)
						or (ch.dosstart >= ogp.begindate))
					and ((ogp.enddate is null)
						or (ch.dosstart < ogp.enddate))
					)
				)'
			+ @groupClause + @locationClause

if (ISNULL(@claimstatus,'') <> '')
	set @stmt = @stmt + '
		and (ch.SystemClaimStatus = @claimstatus)'



if (ISNULL(@firstname,'') <> '')
begin
	set @firstname = @firstname + '%'  
	set @stmt = @stmt + '
		and (ch.PTName like @firstname)'
end


if (@tinfilter = 3)
	set @stmt = @stmt + '
			and (hut.tin is not null or hun.npi is not null)'

if (@tinfilter = 6)
	set @stmt = @stmt + '
			and (hut.tin is not null or hun.npi is not null or huo.item is not null)'

set @stmt = @stmt + '
	) namedcols
)
select *
from claims
where RowNum between @startindex and @endindex'

exec sp_executesql @stmt,
N'@payororgid uniqueidentifier,
@orgproviderid varchar(100),
@pcpname varchar(100),
@searchnpi varchar(100),
@dob datetime,
@begindate datetime,
@enddate datetime,
@tins varchar(8000),
@npis varchar(8000),
@filterorgproviderids varchar(8000),
@claimstatus varchar(100),
@firstname varchar(100),
@startindex int,
@endindex int,
@excludeRClaims bit',
@payororgid,
@orgproviderid,
@pcpname,
@searchnpi,
@dob,
@begindate,
@enddate,
@tins,
@npis,
@filterorgproviderids,
@claimstatus,
@firstname,
@startindex,
@endindex,
@excludeRClaims

end

GO


