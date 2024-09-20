select l.geo_loca_father_id Departamento, (select g.description from open.ge_geogra_location g where g.geograp_location_id = l.geo_loca_father_id) Des_Departamento,
       l.geograp_location_id, l.description
  from open.ge_geogra_location l
 where l.geo_loca_father_id in(2,3,4)
  
