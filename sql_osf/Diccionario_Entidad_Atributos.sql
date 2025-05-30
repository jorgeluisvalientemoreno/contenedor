SELECT col.owner,
       col.table_name,
       col.column_name,
       col.data_type,
       col.data_length,
       col.nullable,
       col.data_default,
       com.comments
  FROM all_tab_columns col, all_col_comments com
 WHERE col.table_name = com.table_name
   AND col.column_name = com.column_name
   AND col.owner = com.owner
   AND col.owner = 'OPEN'
 ORDER BY col.table_name, col.column_id
