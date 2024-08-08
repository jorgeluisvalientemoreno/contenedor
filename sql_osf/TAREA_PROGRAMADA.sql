--select * from open.ge_object a where upper(a.description) like '%JOB%VENTA%';
select *
  from open.GE_PROCESS_SCHEDULE b
 where /*b.executable_id = 5049 and*/
 b.job <> -1
 ORDER BY B.PROCESS_SCHEDULE_ID DESC;
--select * from dba_jobs where what like '%LDC_PKGESTIONCASURP.PRJOBRECOYSUSPRP%' order by 1 desc;
select sysdate, dba_jobs.*
  from dba_jobs
 where job in (select b.job
                 from open.GE_PROCESS_SCHEDULE b
                where b.executable_id = 500000000013035
                  and b.job <> -1);
--CICOANO=2023|CICOMES=9|ADDRESS=3654|
select *
  from dba_jobs_running
 where job in (select b.job
                 from open.GE_PROCESS_SCHEDULE b
                where b.executable_id = 500000000013035
                  and b.job <> -1);
