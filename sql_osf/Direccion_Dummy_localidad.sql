select aa.address_id, aa.address, aa.geograp_location_id, ggl.description
  from ab_address aa
 inner join ge_geogra_location ggl
    on ggl.geograp_location_id = aa.geograp_location_id
   and (SELECT count(1) FROM pr_product WHERE address_id = aa.address_id) > 0
   and aa.address = 'KR GENERICA CL GENERICA - 0'
   and ggl.geograp_location_id = 5;

select * from ge_geogra_location ggl where ggl.geograp_location_id = 2;
select * from ge_geogra_location ggl where ggl.geo_loca_father_id = 2;
