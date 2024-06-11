--validar_log_flujos
select *
from ldc_wf_sendactivitieslog  l
where l.package_id = 206852408
order by l.logdate desc
;
