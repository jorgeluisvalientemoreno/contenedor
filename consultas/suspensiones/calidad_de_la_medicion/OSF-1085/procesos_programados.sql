select o.object_id,
       o.name_,
       o.description,
       s.status,
       s.job,
       s.log_user,
       s.start_date_,
       s.process_schedule_id
  from open.ge_process_schedule s
  inner join open.ge_object o on parameters_ like 'OBJECT_ID='||o.object_id
 where o.object_id = 121663
 order by s.start_date_ desc

-- 121646 - job de suspension
-- 121663 - job de gestión
