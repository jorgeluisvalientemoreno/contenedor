--localidades_x_zonas_ofertadas
select zl.id_zona_oper,
       z.descripcion, 
       zl.localidad,
       l.description
from ldc_zona_loc_ofer_cart zl
left join ldc_zona_ofer_cart  z  on z.id_zona_oper = zl.id_zona_oper
left join ge_geogra_location  l  on l.geograp_location_id = zl.localidad
order by zl.id_zona_oper
