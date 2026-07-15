select gpadre.geograp_location_id || ' - ' || gpadre.description Despartamento,
       gLocalidad.geograp_location_id || ' - ' || gLocalidad.description Localidad,
       sz.id_zona_operativa,
       z.description,
       sz.id_sector_operativo,
       s.description
  from open.ge_sectorope_zona sz
 left join open.or_operating_zone z on z.operating_zone_id = sz.id_zona_operativa
 left join open.or_operating_sector s on s.operating_sector_id = sz.id_sector_operativo
 left join open.ge_geogra_location g on g.operating_sector_id = s.operating_sector_id
 left join open.ge_geogra_location gLocalidad on gLocalidad.geograp_location_id = g.geo_loca_father_id
 left join open.ge_geogra_location gpadre on gpadre.geograp_location_id = gLocalidad.geo_loca_father_id
where sz.id_sector_operativo = 9106
 order by sz.id_zona_operativa asc
 
 select * from ge_sectorope_zona where id_zona_operativa = 162 
 
 
 insert into ge_sectorope_zona  
 select SEQ_GE_SECTOROPE_ZONA.NEXTVAL ,
 162,
 9106 
 from dual 
 
