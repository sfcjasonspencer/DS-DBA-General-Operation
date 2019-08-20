USE [frodo_production]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [ci_DI2_filetype_fields_filetype]    Script Date: 5/28/2019 9:54:18 AM ******/
CREATE CLUSTERED INDEX [ci_DI2_filetype_fields_filetype] ON [dbo].[DI2_filetype_fields]
(
	[filetype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO


