--validar_job_liquidacartera
select *
from ge_process_schedule s, sa_executable e
where s.EXECUTABLE_ID=e.executable_id
  and e.name='LIQUIDACARTERA'
    ORDER BY start_date_ desc;

select *
from LDC_LOGPROC
order by loprfege desc;

/*select *
from ldc_osf_estaproc
where proceso like  '%CARTERA%'
and fecha_inicial_ejec >= '07/07/2024'
order by fecha_inicial_ejec desc;*/



    

