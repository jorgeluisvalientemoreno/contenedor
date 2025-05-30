select distinct p.owner --p.table_name,h.table_name
  from all_constraints p, all_constraints h
 where p.constraint_type = 'P'
   and h.r_constraint_name = p.constraint_name
 order by 1 desc
