select lo.geograp_location_id,
       lo.description,
       zo.id_zona_oper,
       zc.descripcion
from open.ge_geogra_location lo 
left join open.ldc_zona_loc_ofer_cart zo on zo.localidad=lo.geograp_location_id
left join open.ldc_zona_ofer_cart zc on zc.id_zona_oper=zo.id_zona_oper
where lo.geog_loca_area_type=3