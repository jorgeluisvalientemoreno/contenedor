El job ejecuta este procedimiento LDC_PRGAPYCAR.
Con este query se puede consultar su programación:
select *
from SYS.DBA_SCHEDULER_JOBS
where UPPER(COMMENTS) LIKE '%POST%';


insert into LDC_VALIDGENAUDPREVIAS(cod_pefacodi, fecha_audprevia, PROCESO) VALUES (nuPeriodo , SYSDATE, 'AUDPOST');



select *
from LDC_VALIDGENAUDPREVIAS