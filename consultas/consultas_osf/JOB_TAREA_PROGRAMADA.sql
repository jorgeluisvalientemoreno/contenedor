--Objetos de tarea programada
select * from open.ge_object g where g.object_id = 121721;
--JOB en TAREAS PROGRAMDAS OSF
select *
  from open.GE_PROCESS_SCHEDULE b
 where
--b.parameters_ like '%121721%'
 b.process_schedule_id = 536553
 ORDER BY B.Start_Date_ DESC;
--select * from dba_scheduler_job_run_details;
--JOB Corriendo
select * from dba_jobs_running a where a.JOB in (2693102) order by 1 desc;
--JOB DATA
select sysdate, a.* from dba_jobs a where a.job in (2693102);
---
select *
  from open.ge_object g
 where upper(g.name_) like upper('%ldc_fsbasignautomaticarevper%');
select gps.*, rowid
  from open.ge_process_schedule gps
 where gps.parameters_ like '%120438%';
select * from dba_jobs_running_rac k where k.JOB = 85446;
select * from dba_jobs k where k.JOB = 85446;

---Borrar Tarea programada
/*
Inicia GE_BOSchedule.DropSchedule
          INICIO [FA_BCConsfact.GetConsoleActivity]
          FIN [FA_BCConsfact.GetConsoleActivity]
Finaliza GE_BOSchedule.DropSchedule
 */
