SELECT *  
FROM DBA_SCHEDULER_RUNNING_CHAINS  
WHERE JOB_NAME LIKE '%GOPCVNEL%'
order by start_date desc  ;

select * 
from estaprog where esprprog like 'GOPCVNEL%' and esprinfo = 'GDGU'   
ORDER BY esprfein DESC  ;

select *
from ldc_log_salescomission 
order by fecha_inicio desc

select *
from ge_acta g
order by  g.fecha_creacion desc
