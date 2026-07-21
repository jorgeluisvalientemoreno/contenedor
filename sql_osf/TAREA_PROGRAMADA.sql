select *
  from open.GE_PROCESS_SCHEDULE b
 inner join open.sa_executable se
    on se.executable_id = b.executable_id
   and se.executable_id = 500000000010100
--and se.name = 'PBSUI'
 where 1 = 1
      --and b.executable_id = 5049
      --and b.job = -1
   and trunc(b.start_date_) >= '01/03/2026'
 ORDER BY B.PROCESS_SCHEDULE_ID DESC;

--
select *
  from dba_jobs
 where upper(what) like upper('%prc_ejecasiglegasuspcdmacom%')
 order by 1 desc;

select sysdate, dba_jobs.*
  from dba_jobs
 where job in (select b.job
                 from open.GE_PROCESS_SCHEDULE b
                where b.executable_id = 500000000010100
                  and b.job <> -1);
--CICOANO=2023|CICOMES=9|ADDRESS=3654|
select *
  from dba_jobs_running
 where job in (select b.job
                 from open.GE_PROCESS_SCHEDULE b
                where b.executable_id = 500000000010100
                  and b.job <> -1);

--/*--
select *
  from open.ge_object a
 where 1 = 1
      -- and upper(a.description) like '%CALIAD%'
   and upper(a.name_) like '%PRC_ASIGLEGASUSPCDMACOM%';

--*/
select *
  from open.GE_PROCESS_SCHEDULE b
 inner join open.ge_object a
    on upper(a.name_) like '%PRC_ASIGLEGASUSPCDMACOM%'
 where 1 = 1
   and b.parameters_ like '%=' || a.object_id || '%'
--and b.executable_id = 5049
--and b.job = -1
--and trunc(b.start_date_) >= '28/01/2026'
 ORDER BY B.Start_Date_ DESC;

--select * from dba_jobs a where a.JOB in (3382251, 3382248)
