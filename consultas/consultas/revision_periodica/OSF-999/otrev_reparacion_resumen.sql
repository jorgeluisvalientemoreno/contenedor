select o.codigo_localidad, o.localidad,  count(o.product_id)  ordenes
from ldc_otrev_repa  o
where o.codigo_localidad = 55
group by o.codigo_localidad, o.localidad
order by count(o.product_id) desc
