--Child –> Parent
select child.owner || '.' || child.table_name "Child table",
       'is child of' " ",
       parent.owner || '.' || parent.table_name "Parent table"
  from dba_constraints child
  join dba_constraints parent
    on child.r_constraint_name = parent.constraint_name
   and child.r_owner = parent.owner
 where parent.TABLE_NAME = upper('gr_config_expression');

--Parent -> Childs
select parent.owner || '.' || parent.table_name "Parent table",
       'is parent of' " ",
       child.owner || '.' || child.table_name "Child table"
  from dba_constraints child
  join dba_constraints parent
    on child.r_constraint_name = parent.constraint_name
   and child.r_owner = parent.owner
 where child.table_name = 'gr_config_expression';

select 'select ''' || hija.table_name || ''' as tabla,' || u.column_name ||
       ' from open.' || u.TABLE_NAME || ' where ' || u.column_name ||
       ' is not null union all'
  from dba_cons_columns u
 inner join dba_constraints hija
    on u.CONSTRAINT_NAME = hija.constraint_name
   and hija.constraint_type = 'R'
 inner join dba_constraints padre
    on hija.r_constraint_name = padre.constraint_name
   and hija.r_owner = padre.owner
   and padre.TABLE_NAME = upper('gr_config_expression');

select 'select ''' || tc.table_name || ''' as tabla,' || tc.COLUMN_NAME ||
       ' from open.' || tc.table_name || ' where ' || tc.COLUMN_NAME ||
       ' is not null union all'
  from dba_tab_columns TC
 where owner = 'OPEN'
   AND COLUMN_NAME LIKE '%REGL%'
   AND DATA_TYPE = 'NUMBER'
   AND NOT EXISTS
 (select NULL
          from dba_cons_columns u
         inner join dba_constraints hija
            on u.CONSTRAINT_NAME = hija.constraint_name
           and hija.constraint_type = 'R'
         inner join dba_constraints padre
            on hija.r_constraint_name = padre.constraint_name
           and hija.r_owner = padre.owner
         WHERE u.column_name = TC.COLUMN_NAME
           AND hija.table_name = TC.TABLE_NAME)
