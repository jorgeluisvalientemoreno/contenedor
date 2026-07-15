select g.geo_loca_father_id, 
       (select t.description from open.ge_geogra_location t 
         where t.geograp_location_id = g.geo_loca_father_id) descp,
       g.geograp_location_id, 
       g.description
  from open.ge_geogra_location g
 where g.geo_loca_father_id in (8978)
