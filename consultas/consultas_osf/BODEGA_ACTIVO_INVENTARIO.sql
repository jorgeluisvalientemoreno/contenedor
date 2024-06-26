select gi.items_id, gi.description, gis.serie, gis.operating_unit_id
  from open.ge_items_seriado gis
 inner join open.ge_items gi
    on gi.items_id = gis.items_id
 where gi.items_id in (10004070, 10002017, 10002011)
   and operating_unit_id in (4604, 4606);
