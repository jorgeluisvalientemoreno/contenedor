select *
from ldc_log_proceso_vmp  l
where    L.producto in (50069432)
order by l.log_proceso_vmp_id desc
