select b.operating_unit_id, b.name, d.*
from open.or_operating_unit b, open.ge_items_documento d, open.or_operating_unit b2
where  not exists (select null from open.ldci_cecounioper c2 where c2.operating_unit_id=b.operating_unit_id)
     and  d.operating_unit_id=b.operating_unit_id
     and d.document_type_id=105
     and b2.operating_unit_id=d.destino_oper_uni_id
     and b2.oper_unit_classif_id=11
     and exists(select * from open.or_uni_item_bala_mov m , open.ge_items i where m.id_items_documento=d.id_items_documento and m.items_id=i.items_id and i.item_classif_id=3);
     
