select o.codigo_localidad, o.localidad,  count(o.product_id)  ordenes
from ldc_otrev  o
where o.codigo_localidad = 115
group by o.codigo_localidad, o.localidad
