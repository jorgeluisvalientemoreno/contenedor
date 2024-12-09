--validar_errores_correos
select *
from estaproc
where upper(proceso) like '%PKG_CORREO%'
AND fecha_inicial_ejec > trunc(sysdate)-30
order by fecha_inicial_ejec desc
