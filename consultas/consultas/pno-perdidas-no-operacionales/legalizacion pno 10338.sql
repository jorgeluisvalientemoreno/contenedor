select b.order_id||'|'||9047||'|'||13538||'|'||'FECHA_REGISTRO_QUEJA='||damo_packages.fdtgetrequest_date(b.package_id )||';AREA_REAL_CAUSANT=76;'||'FECHA_REGISTRO_RECLAMO='||damo_packages.fdtgetrequest_date(b.package_id )||'|'||b.order_activity_id ||'>1;COMMENT0>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|||3;prueba'
from open.OR_ORDER a , open.or_order_activity b --, open.ge_sectorope_zona c
where b.task_type_id=10338
--and   b.operating_sector_id=332
--and   b.operating_unit_id=3316
and   a.ORDER_STATUS_ID = 5
--and c.id_zona_operativa=179
--and   c.id_sector_operativo= b.operating_sector_id
and   b.order_id=a.order_id;


