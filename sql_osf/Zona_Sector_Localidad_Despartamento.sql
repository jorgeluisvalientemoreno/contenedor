select sz.id_zona_operativa || ' - ' || z.description "Zona",
       sz.id_sector_operativo || ' - ' || s.description "Sector Operativa",
       gLocalidad.geograp_location_id || ' - ' || gLocalidad.description "Localidad",
       gpadre.geograp_location_id || ' - ' || gpadre.description "Departamento"
  from open.ge_sectorope_zona sz
 inner join open.or_operating_zone z
    on z.operating_zone_id = sz.id_zona_operativa
 inner join open.or_operating_sector s
    on s.operating_sector_id = sz.id_sector_operativo
 inner join open.ge_geogra_location g
    on g.operating_sector_id = s.operating_sector_id
 inner join open.ge_geogra_location gLocalidad
    on gLocalidad.geograp_location_id = g.geo_loca_father_id
 inner join open.ge_geogra_location gpadre
    on gpadre.geograp_location_id = gLocalidad.geo_loca_father_id
 order by sz.id_zona_operativa asc
