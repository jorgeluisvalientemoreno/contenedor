select *
from open.ldc_versionentrega e
inner join open.ldc_versionaplica  ap on e.codigo=ap.codigo_entrega
where codigo_caso like '%OSF-551%'
and ap.codigo_empresa = 'EFG'
order by e.fecha desc