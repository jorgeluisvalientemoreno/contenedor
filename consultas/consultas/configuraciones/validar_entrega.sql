select *
from open.ldc_versionentrega e
inner join open.ldc_versionaplica  ap on e.codigo=ap.codigo_entrega
order by e.fecha desc