SELECT * --job_name, owner, enabled 
  FROM dba_scheduler_jobs;

select *
  from open.ge_object g
 where upper(g.name_) like upper('%LDC_BOASIGAUTO.PRASIGNACION%');

select gps.*
  from open.ge_process_schedule gps,
       (select g.object_id
          from open.ge_object g
         where upper(g.name_) like upper('%LDC_BOASIGAUTO.PRASIGNACION%')) gobject
 where gps.parameters_ like '%OBJECT_ID=' || gobject.object_id || '%'
   and gps.job != -1;

select sysdate, dj.* from dba_jobs dj where dj.JOB = 3414753;

select gps.*
  from open.ge_process_schedule gps
 order by gps.process_schedule_id desc;

