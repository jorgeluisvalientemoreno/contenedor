select *
from open.LDC_VERSIONENTREGA e, open.LDC_VERSIONAPLICA  ap
where e.codigo=ap.codigo_entrega
--and e.fecha >= '26/01/2021 17:00:10'
 and codigo_caso like '%113%'
and ap.codigo_empresa = 'GDC'
order by e.fecha desc


