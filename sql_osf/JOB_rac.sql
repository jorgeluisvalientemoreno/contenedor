--select * from open.ge_object g where upper(g.name_) like upper('%ldc_boasigauto.prasignacion%');
--select gps.* , rowid from open.ge_process_schedule gps where gps.parameters_ like '%120652%';
select * from dba_jobs k where k.JOB in (85572);
select * from dba_jobs_running_rac k where k.JOB in (85572);
select gps.*, rowid
  from open.ge_process_schedule gps
 where gps.JOB in (85572)
   and gps.executable_id = 500000000002480;
select sysdate, count(1)
  from (select /*+ use_nl(A) */
         *
          from open.TMP_INFORME_PROV_CART A
         where ano = 2022
           and mes = 11) a;
select *
  from dba_jobs a, dba_jobs_running_rac b
 where upper(a.WHAT) like upper('%pkgldc_ifrs.prExecuteIFRS%')
   and a.THIS_DATE > to_date('21/12/2022')
   and a.LOG_USER = 'OPEN'
   and a.JOB = b.JOB
 order by a.THIS_DATE desc;
select *
  from dba_jobs a, dba_jobs_running_rac b
 where upper(a.WHAT) like upper('%pkgLDC_IFRS.ProGenDataModeloIFRS%')
   and a.THIS_DATE > to_date('21/12/2022')
   and a.LOG_USER = 'OPEN'
   and a.JOB = b.JOB
 order by a.THIS_DATE desc;
