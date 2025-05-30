select oou.operating_unit_id || ' - ' || oou.name, oou.*
  from open.or_operating_unit oou
 where oou.operating_unit_id = 3117;
