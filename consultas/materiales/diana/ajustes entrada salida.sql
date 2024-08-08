select distinct t.document_type_id, description, m.movement_type, sum(total_value)
from open.ge_document_type t, open.or_uni_item_bala_mov m, open.ge_items_documento d
where m.id_items_documento=d.id_items_documento
  and d.document_type_id=t.document_type_id
  and d.document_type_id in (112,117,107,113)
  group by t.document_type_id, description, m.movement_type
