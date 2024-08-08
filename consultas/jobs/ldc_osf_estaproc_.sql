select *
from open.ldc_osf_estaproc e
where e.proceso = 'PRPROCORDEN'
order by e.fecha_inicial_ejec desc
