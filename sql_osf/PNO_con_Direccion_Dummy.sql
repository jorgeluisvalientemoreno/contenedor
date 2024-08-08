select aa.address_id, aa.address, aa.geograp_location_id, aa.description
  from FM_POSSIBLE_NTL a
 inner join ab_address aa
    on a.address_id = aa.address_id
 inner join ge_geogra_location ggl
    on ggl.geograp_location_id = aa.geograp_location_id
   and (SELECT count(1) FROM pr_product WHERE address_id = aa.address_id) > 0
   and aa.address = 'KR GENERICA CL GENERICA - 0'
 where status in ('P', 'R')
   and product_type_id = 7014;
   

