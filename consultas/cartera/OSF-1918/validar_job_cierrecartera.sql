--validar_job_cierrecartera
select *
from ldc_temp_cierrecartera_hilos
order by fecha_inicial desc;

select *
from LDC_LOGPROC l
order by l.loprfege desc;

select *--distinct unidad_operativa
                    from ldc_metas_cont_gestcobr r
                   where r.ano = 2024
                     and r.mes = 8
                     and r.meta_usuarios > 0
                     and r.meta_deuda > 0
                     and r.tarifa_usuario is not null
                     and r.tarifa_cartera is not null
