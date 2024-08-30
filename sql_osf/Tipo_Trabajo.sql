select ott.*, rowid
  from open.or_task_type ott
 where ott.task_type_id in (10450, 12457, 11029, 11022)
 order by ott.task_type_id;
