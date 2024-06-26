SELECT a.column_name, b.data_type
  FROM all_tab_columns a, all_tab_columns b
 WHERE upper(a.table_name) = upper('OR_ORDER')
   and a.table_name = b.TABLE_NAME
   AND a.column_name = b.COLUMN_NAME
   
