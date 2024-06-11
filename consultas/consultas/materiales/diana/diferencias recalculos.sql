


select m.movement_type, m.item_moveme_caus_id , b.total_value, m.total_value, d.document_type_id
from open.or_uni_item_bala_mov b, open.or_uni_item_bala_mov_copia2 m, open.ge_items_documento d
where m.uni_item_bala_mov_id=b.uni_item_bala_mov_id
  and m.total_value!=b.total_value
  and m.items_id=10010688
  and d.id_items_documento=m.id_items_documento
  and m.operating_unit_id=2557
