select ott.task_type_id || ' - ' || ott.description -- ott.*, rowid
  from open.or_task_type ott
 where ott.task_type_id in
       (11022, 11029, 10444, 10795, 10723, 10833, 12460)
 order by ott.task_type_id;
