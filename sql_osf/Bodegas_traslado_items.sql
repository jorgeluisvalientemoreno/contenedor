select *
from open.or_uni_item_bala_mov m
where m.operating_unit_id=799
  and m.movement_type='N'
  and m.item_moveme_caus_id=20
  and items_id in (4001211,4295313)
  and m.support_document= ' '
  ;
  
  select *
  from open.ge_items_documento
  where id_items_documento in (1339611,1378953);
