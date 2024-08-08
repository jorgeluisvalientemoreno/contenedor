select distinct e.executable_id,
	   e.name,
	   e.description
from open.ldc_versionentrega c
inner join open.ldc_versionobjetos v on c.codigo=v.codigo_entrega
left join open.ps_package_type t on v.objeto='ps_package_type_'||t.package_type_id
left join open.sa_executable  e on (upper(objeto) =e.name  or upper(tipo) =e.name or e.name=t.tag_name)   and e.name not in ('FWCEA','FWCPB','FWCOB','FWCGR','FWCPB','FWCMD','ORMTB')
where (e.name is not null or v.objeto like '%PS_PACKAGE_TYPE%')
and c.nombre_entrega='OSS_HT_0000132_7'
