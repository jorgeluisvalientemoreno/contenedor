select *
  from dba_jobs
 where upper(what) like
       upper('%PRC_FINANCIA_DUPLICADO%')
 order by 1 desc;

select *
  from dba_scheduler_jobs
 where upper(job_action) like
       upper('%PRC_FINANCIA_DUPLICADO%');

select gps.*
  from open.ge_process_schedule gps,
       (select g.object_id
          from open.ge_object g
         where upper(g.name_) like
               upper('%PRC_FINANCIA_DUPLICADO%')) gobject
 where gps.parameters_ like '%OBJECT_ID=' || gobject.object_id || '%'
--and gps.job != -1
;
