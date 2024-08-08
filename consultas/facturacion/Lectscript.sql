select *
from dba_scheduler_jobs where lower(job_action) like '%ldc_pkcm_lectesp%';

select *
from open.ldc_osf_estaproc
where proceso='LDC_PKCM_LECTESP.PROGENERACRITICA'

select *
from open.ge_Error_log
where time_stamp>='8/03/2022 7:15:31'
  and upper(call_stack) like '%LDC_PKCM_LECTESP%';
  
SELECT *
FROM OPEN.LDC_CM_LECTESP_PETC T, OPEN.GE_PERSON P
WHERE P.PERSON_ID=T.PERSON_ID
and p.person_id=16248;


select *
from OPEN.LDC_CM_LECTESP_TPCL  
