select * from gasgg.ldc_cuentacontable;

select
  child.owner        || '.' ||
  child.table_name   "Child table",
  'is child of'      " ",
  parent.owner       || '.' ||
  parent.table_name  "Parent table"
from
  dba_constraints child join dba_constraints parent on
    child.r_constraint_name = parent.constraint_name and
    child.r_owner           = parent.owner
where
  child.TABLE_NAME = upper('tiajpago')

select * from dba_tab_columns where owner ='GASGG'
