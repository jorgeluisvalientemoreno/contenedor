select g.geograp_location_id, g.description,
       g.geo_loca_father_id, (select t.description from open.ge_geogra_location t 
                               where t.geograp_location_id = g.geo_loca_father_id) descp
  from open.ge_geogra_location g
 where g.geo_loca_father_id in (2,3,4)
