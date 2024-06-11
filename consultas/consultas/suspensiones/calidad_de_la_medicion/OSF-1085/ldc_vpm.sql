select v.product_id,
       v.emsscoem,
       v.fecha_vpm,
       v.fecha_proxima_vpm,
       sysdate
from ldc_vpm  v
where v.product_id = 50069432
