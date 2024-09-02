SELECT
    'ALTER TABLE ' + s.name + '.' + OBJECT_NAME(fk.parent_object_id)
        + ' DROP CONSTRAINT ' + fk.NAME + ' ;' AS DropStatement,
    'ALTER TABLE ' + s.name + '.' + OBJECT_NAME(fk.parent_object_id)
    + ' WITH NOCHECK ADD CONSTRAINT ' + fk.NAME + ' FOREIGN KEY (' + COL_NAME(fk.parent_object_id, fkc.parent_column_id) 
        + ') REFERENCES ' + ss.name + '.' + OBJECT_NAME(fk.referenced_object_id) 
        + '(' + COL_NAME(fk.referenced_object_id, fkc.referenced_column_id) + ');' AS CreateStatement,
    OBJECT_NAME(fk.parent_object_id) AS TableName,
    COL_NAME(fk.parent_object_id, fkc.parent_column_id) AS ColumnName
FROM
    sys.foreign_keys fk
INNER JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
INNER JOIN sys.schemas s ON fk.schema_id = s.schema_id
INNER JOIN sys.tables t ON fkc.referenced_object_id = t.object_id
INNER JOIN sys.schemas ss ON t.schema_id = ss.schema_id
WHERE
    OBJECT_NAME(fk.referenced_object_id) = 'NAMETABLE'
    AND ss.name = 'dbo';
