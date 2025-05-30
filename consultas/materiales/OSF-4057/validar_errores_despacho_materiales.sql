--validar_errores_despacho_materiales
select *
from ge_error_log  l
where l.time_stamp >= '25/04/2025 14:40:00'
and   upper(l.call_stack) like '%LDCI_PKMOVIVENTMATE%'
order by l.time_stamp desc
