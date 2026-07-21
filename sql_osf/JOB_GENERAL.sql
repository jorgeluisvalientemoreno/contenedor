select *
  from dba_jobs j
 where 1 = 1
      -- and (j.WHAT) LIKE upper('%LDC_PRGAPYCAR%')
   and 1 = 1
--Job Base de Datos
  select *
          from all_scheduler_jobs a
         WHERE upper(a.JOB_ACTION) LIKE '%LDC_PRGAPYCAR%';


/*select *
  from dba_scheduler_jobs a
 WHERE upper(a.JOB_ACTION) LIKE '%LDC_PRGAPYCAR%';*/
--upper(a.JOB_ACTION) LIKE '%LDCI_PKMOVIMATERIAL%';
select *
  from dba_jobs b
 where 1 = 1
   and b.JOB in
       (select a.flags
          from dba_scheduler_jobs a
         WHERE upper(a.JOB_ACTION) LIKE '%LDC_PRGAPYCAR%');
--JOB Corriendo
select *
  from dba_jobs_running a
-- where a.JOB not in (299773, 465731, 393253,64124)
 order by 1 desc;
select *
  from dba_scheduler_job_run_details
 WHERE JOB_NAME LIKE '%LDC_PRGAPYCAR%';

select sysdate, dba_scheduler_jobs.*
  from dba_scheduler_jobs
 where job_name LIKE '%LDC_PRGAPYCAR%';
select * from ALL_SCHEDULER_JOBS where job_name = 'LDC_PRGAPYCAR';
select * from USER_SCHEDULER_JOBS where job_name = 'LDC_PRGAPYCAR';

select * from dba_jobs a where a.LOG_USER = 'OPEN';

--Job Tarea Programada
select *
  from open.ge_object g
 where upper(g.name_) like upper('%LDC_PRGAPYCAR%');

select gps.*, rowid
  from open.ge_process_schedule gps
 where gps.parameters_ like '%OBJECT_ID=120522%';
select gps.*, rowid
  from open.ge_process_schedule gps
 where gps.parameters_ like '%OBJECT_ID=120771%';
select * from dba_jobs_running_rac k where k.JOB = 85446;
select * from dba_jobs k where k.JOB = 85446;

--Objetos de tarea programada
select * from open.ge_object g where g.object_id = 121721;

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

---Borrar Tarea programada
/*
Inicia GE_BOSchedule.DropSchedule
          INICIO [FA_BCConsfact.GetConsoleActivity]
          FIN [FA_BCConsfact.GetConsoleActivity]
Finaliza GE_BOSchedule.DropSchedule
 */
