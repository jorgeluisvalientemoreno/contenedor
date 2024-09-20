select susccodi, (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi) LOCA,
       (select l.description from open.ge_geogra_location l 
         where l.geograp_location_id in (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi)) des_loca
  from open.suscripc, OPEN.SERVsusc s 
 where susccodi = sesususc
   and sesunuse = 50650783
