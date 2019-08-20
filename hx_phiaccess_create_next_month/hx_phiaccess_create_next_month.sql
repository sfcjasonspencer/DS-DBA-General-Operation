USE [PHILOG]
GO

/****** Object:  StoredProcedure [dbo].[hx_phiaccesslog_create_next_month]    Script Date: 5/10/2019 3:27:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[hx_phiaccesslog_create_next_month]  
    @date datetime  
as  
begin  

declare @tableName varchar(50)  

/*
Only used for testing
declare @date datetime
set @date = getdate()
*/

-- Formats a table name like "PHIAccessLog201701" based on @date  
set @date = dateadd(month, 1, @date)  
set @tableName = 'PHIAccessLog' + convert(Varchar(4), Year(@date)) + right('0' + rtrim(month(@date)),2)  
  
declare @stmt nvarchar(max)  
set @stmt = '
IF NOT EXISTS (SELECT 1 FROM sysobjects (NOLOCK) WHERE name = ''' + @tableName + ''' and type = ''u'')  
BEGIN 
	CREATE TABLE [dbo].' + @tableName + '(
		[PHIAccessID] [uniqueidentifier] NOT NULL,
		[AccessingUserID] [uniqueidentifier] NOT NULL,
		[AddDateTimeUTC] [datetime] NOT NULL,
		[PayorID] [uniqueidentifier] NULL,
		[AppLogID] [uniqueidentifier] NOT NULL,
		[EventType] [tinyint] NOT NULL,
		[PHIRecordData] [xml] NOT NULL,
		[ImitateUserId] [uniqueidentifier] NULL);
	ALTER TABLE [dbo].' + @tableName + ' ADD  CONSTRAINT [DF_' + @tableName + '_PHIAccessID]  DEFAULT (newid()) FOR [PHIAccessID]
	ALTER TABLE [dbo].' + @tableName + ' ADD  CONSTRAINT [DF_' + @tableName + '_AddDateTimeUTC]  DEFAULT (getutcdate()) FOR [AddDateTimeUTC]
	EXEC sys.sp_addextendedproperty @name=N''MS_Description'', @value=N''0=Summary View, 1=Detail View, 2=API'' , @level0type=N''SCHEMA'',@level0name=N''dbo'', @level1type=N''TABLE'',@level1name=N''' + @tableName + ''', @level2type=N''COLUMN'',@level2name=N''EventType''
	
	CREATE CLUSTERED INDEX CIX_' + @tableName + '_AddDateTimeUTC ON ' + @tableName + ' (AddDateTimeUTC ASC) WITH (FILLFACTOR = 100);
	CREATE NONCLUSTERED INDEX IX_' + @tableName + '_AccessingUserID ON ' + @tableName + '(AccessingUserID ASC) WITH (FILLFACTOR = 100);

    PRINT ''' + @tableName + ' created'';  
END  
ELSE  
BEGIN  
    PRINT ''' + @tableName + ' already exists'';  
END'  
  
exec sp_executesql @stmt,  
N'@date datetime',  
@date  
 
end 

--print @stmt


GO


