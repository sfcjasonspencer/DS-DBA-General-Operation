
USE logarchive2012
GO

SELECT      T.name TableName,i.Rows NumberOfRows
FROM        sys.tables T
JOIN        sys.sysindexes I ON T.OBJECT_ID = I.ID
WHERE       indid IN (0,1)
ORDER BY    i.Rows DESC,T.name 


SELECT      i.Rows NumberOfRows
FROM        sys.tables T
JOIN        sys.sysindexes I ON T.OBJECT_ID = I.ID
WHERE       t.name = 'ExtendedSearch_LOG'
