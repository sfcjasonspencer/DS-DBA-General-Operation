/*
 //////////////////////////////////////////////////////////////////////////////////////////////
    Purpose: Basic script used for compression.  **THIS IS A BASELINE SCRIPT THAT WILL NEED
    CHANGED PER USE**
    Object Type: View
    Date Added: 2019APR26
    Version: 001
    Revision: A
    Author: Jason M. Spencer
    Title: DBA
    Scripting Tool: Visual Studio Code
    Custom: Yes
    Tags: BasicViewTemplate, Standards, Compression
    KeyParameters: None

    Additional Notes:
    Note 001: When adding a note ensure the note explains why the note was added. Be informative.
    Note 002: Notes lines can also be used in the code comments to indicate See Note 002 at the top of script.
        */
-- //////////////////////////////////////////////////////////////////////////////////////////////
-- Change Log Begins -->>
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/*  Change Date: 2019APR26
    Version: 001
    Revision: A
    Author: Jason M. Spencer
    Title: DBA
    Scripting Tool: Visual Studio Code
    Changes:
    Change 001: Added Change Log.
    */
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
-- Change Log Ends -->>
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

--Ensure you change the script below
--Creates the ALTER TABLE Statements

SET NOCOUNT ON
SELECT 'ALTER TABLE ' + '[' + s.[name] + ']'+'.' + '[' + o.[name] + ']' + ' REBUILD WITH (DATA_COMPRESSION=PAGE);'
FROM sys.objects AS o WITH (NOLOCK)
INNER JOIN sys.indexes AS i WITH (NOLOCK)
ON o.[object_id] = i.[object_id]
INNER JOIN sys.schemas AS s WITH (NOLOCK)
ON o.[schema_id] = s.[schema_id]
INNER JOIN sys.dm_db_partition_stats AS ps WITH (NOLOCK)
ON i.[object_id] = ps.[object_id]
AND ps.[index_id] = i.[index_id]
WHERE o.[type] = 'U' and o.name = 'ClaimHeaders'--and where frodo_production.INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'ClaimHeaders'
ORDER BY ps.[reserved_page_count]




--Creates the ALTER INDEX Statements

SET NOCOUNT ON
SELECT 'ALTER INDEX '+ '[' + i.[name] + ']' + ' ON ' + '[' + s.[name] + ']' + '.' + '[' + o.[name] + ']' + ' REBUILD WITH (DATA_COMPRESSION=PAGE);'
FROM sys.objects AS o WITH (NOLOCK)
INNER JOIN sys.indexes AS i WITH (NOLOCK)
ON o.[object_id] = i.[object_id]
INNER JOIN sys.schemas s WITH (NOLOCK)
ON o.[schema_id] = s.[schema_id]
INNER JOIN sys.dm_db_partition_stats AS ps WITH (NOLOCK)
ON i.[object_id] = ps.[object_id]
AND ps.[index_id] = i.[index_id]
WHERE o.type = 'U' AND i.[index_id] >0 and o.name = 'ClaimHeaders'
ORDER BY ps.[reserved_page_count]
