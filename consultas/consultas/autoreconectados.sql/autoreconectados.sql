SELECT *
FROM LDC_ACTIVIDAD_GENERADA;
select *
from LDC_ORDEASIGPROC;
select *
from LDC_PROCESO;
select *
from LDC_PRODGENEPER;
select *
from open.LDC_SUSP_AUTORECO s
where s.saresesu=1066858;
select *
from LDC_SUSP_PERSECUCION;
select *
from ge_process_schedule
where executable_id=(select e.executable_id from sa_executable e where name='PERSCA')
  and start_date_>='10/09/2019';
select  a.sql_text,EXECUTIONS--a.*--SID, s.SERIAL#, SPID, a.sql_text 
 from gv$session s, v$process p, v$sqlarea a 
 where s.paddr=p.addr and s.sql_id=a.sql_id
  and sid = 1263;


SELECT *
FROM OPEN.LDC_SUSP_PERSECUCION S, OPEN.LDC_PROCESO_aCTIVIDAD A
WHERE S.SUSP_PERSEC_ACT_ORIG=A.ACTIVITY_ID
  AND A.PROCESO_ID=3;
