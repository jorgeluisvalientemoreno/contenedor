--Valida la programaci�n del job

select *
from estaproc p
where p.proceso like '%PRC_EJECASIGLEGASUSPCDMACOM%'
order by p.fecha_inicial_ejec desc
