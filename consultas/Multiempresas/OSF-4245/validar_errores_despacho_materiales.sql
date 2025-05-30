--validar_errores_despacho_materiales
select *
from ge_error_log  l
where l.time_stamp >= '21/05/2025 10:50:00'
and   upper(l.call_stack) like '%LDCI_PKRESERVAMATERIAL%'
order by l.time_stamp desc;

--LDCI_PKRESERVAMATERIAL
