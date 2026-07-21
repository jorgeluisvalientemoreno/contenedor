/*select count(1) from (select oo.order_id || ';' || oou.operating_unit_id
  from open.or_order oo
 inner join OPEN.or_order_activity ooa
    on ooa.order_id = oo.order_id
   and ooa.activity_id = 4000803
 inner join open.ge_sectorope_zona GSZ
    on oo.operating_sector_id = gsz.id_sector_operativo
 inner join open.or_operating_unit OOU
    on oou.operating_zone_id = GSZ.ID_ZONA_OPERATIVA
   and oou.operating_unit_id in (4006, 4007, 4008)
 where oo.order_status_id = 0
   and oo.task_type_id = 12626group by
 oo.order_id || ';' || oou.operating_unit_id);*/

select oo.order_id || ';' || oou.operating_unit_id
  from open.or_order oo
 inner join OPEN.or_order_activity ooa
    on ooa.order_id = oo.order_id
   and ooa.activity_id = 4000803
 inner join open.ge_sectorope_zona GSZ
    on oo.operating_sector_id = gsz.id_sector_operativo
 inner join open.or_operating_unit OOU
    on oou.operating_zone_id = GSZ.ID_ZONA_OPERATIVA
   and oou.operating_unit_id in (4006, 4007, 4008)
 where oo.order_status_id = 0
   and oo.task_type_id = 12626
 group by oo.order_id || ';' || oou.operating_unit_id; --46710
