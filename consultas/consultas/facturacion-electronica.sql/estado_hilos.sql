select *
from personalizaciones.estaproc
where FECHA_INICIAL_EJEC > sysdate -1
 and proceso LIKE '%JOBFAEL%';