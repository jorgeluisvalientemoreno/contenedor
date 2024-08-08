select *
from open.LDC_PKG_OR_ITEM i
--where fecha>='30/03/2022'
where i.package_id=92805736
;


select *
from open.LDC_PKG_OR_ITEM_DETAIL r
;

select *
from open.LDC_VENT_EXC_COMISION
where register_date>='30/03/2022';

select *
from open.ldc_cc_log_vent_anul a
where a.fecha>='30/03/2022';
