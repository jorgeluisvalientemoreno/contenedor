--SELECT * FROM dba_scheduler_chains
select * from DBA_scheduler_chains where chain_name like '%GOPCVNEL%';

select *
  from DBA_scheduler_programs
 WHERE PROGRAM_NAME in
       (select program_name
          from DBA_scheduler_chain_steps
         where chain_name like '%GOPCVNEL%');

select *
  from DBA_scheduler_program_args
 WHERE PROGRAM_NAME LIKE '%GOPCVNEL%' --ESCAPE '\'
 order by DBA_scheduler_program_args.PROGRAM_NAME,
          DBA_scheduler_program_args.ARGUMENT_POSITION;

select * --program_name
  from DBA_scheduler_chain_steps
 where chain_name like '%GOPCVNEL%';

select *
  from DBA_scheduler_chain_rules
 where chain_name like '%GOPCVNEL%'
 order by rule_name;

SELECT *
  FROM DBA_SCHEDULER_RUNNING_CHAINS a
 where a.CHAIN_NAME like '%GOPCVNEL%'
 order by start_date desc;

select *
  from DBA_scheduler_job_log
 where log_id in (SELECT step_job_log_id FROM DBA_SCHEDULER_RUNNING_CHAINS);

/*
select *
  from DBA_scheduler_job_run_details a
 where a.JOB_NAME like '%CADENA_JOBS_GOPCVNEL%'
   and a.REQ_START_DATE >
       to_date('20/06/2024 10:00:02', 'DD/MM/YYYY HH24:MI:SS'); -- trunc(sysdate);
       */

select a.*, rowid
  from PERSONALIZACIONES.ESTAPROC a
 where a.proceso like '%GOPCVNEL%'
   and a.fecha_inicial_ejec >
       to_date('20/06/2024 10:30:02', 'DD/MM/YYYY HH24:MI:SS') --trunc(sysdate)
--and a.proceso like '%JOBGOPCVNEL%_5'
 order by a.fecha_inicial_ejec desc;

select sysdate, b.*
  from open.GE_PROCESS_SCHEDULE b
 where b.executable_id = 500000000013035
   and b.start_date_ > trunc(sysdate)
 ORDER BY B.Start_Date_ DESC;

select *
  from dba_jobs a
 where a.JOB in (select b.job
                   from open.GE_PROCESS_SCHEDULE b
                  where b.executable_id = 500000000013035
                    and b.start_date_ > trunc(sysdate)
                    and b.job <> -1);

/*select *
  from dba_jobs_running a
 where a.JOB in (select b.job
                   from open.GE_PROCESS_SCHEDULE b
                  where b.executable_id = 500000000013035
                    and b.start_date_ > trunc(sysdate)
                    and b.job <> -1);*/

select *
  from dba_jobs_running a
 where a.JOB in (select b.job
                   from open.GE_PROCESS_SCHEDULE b
                  where b.executable_id = 500000000013035
                    and b.start_date_ > trunc(sysdate)
                    and b.job <> -1);

/*select a.*, rowid
  from OPEN.GE_LOG_PROCESS a
 where a.process_schedule_id in
       (select b.process_schedule_id
          from open.GE_PROCESS_SCHEDULE b
         where b.executable_id = 500000000013035
           and b.start_date_ > trunc(sysdate))
 ORDER BY a.date_ DESC*/
