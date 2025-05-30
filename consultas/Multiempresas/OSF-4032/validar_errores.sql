--validar_errores
select *--error_log_id, time_stamp, trim(description)
from
    ge_error_log el
where el.time_stamp > to_date( '5/05/2025 17:50:03', 'dd/mm/yyyy hh24:mi:ss' )
and el.time_stamp < to_date( '5/05/2025 18:05:03', 'dd/mm/yyyy hh24:mi:ss' )
--and application = 'LDCANDM'
order by el.error_log_id desc
