select *
from open.ldc_versionentrega e
inner join open.ldc_versionaplica  ap on e.codigo=ap.codigo_entrega
where e.nombre_entrega like '%OSS_CON_CBB_200308_5%';
 