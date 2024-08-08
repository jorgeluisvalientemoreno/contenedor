select tl.consecutivo,
       tl.descripcion,
       tl.departamento,
       tilo.localidad,
       l.description
from  open.ldc_tipo_list_depart  tl
inner join open.ldc_loc_tipo_list_dep tilo  on tilo.tipo_lista = tl.consecutivo
inner join open.ge_geogra_location    l  on l.geograp_location_id = tilo.localidad;