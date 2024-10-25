--metas_mensuales_por_unidad_operativa_ldcmetamensual 
select *
from open.ldc_metamensual mm
where mm.metauniop = 4296
and   mm.meta_finicial >= '01/07/2024'
for update
