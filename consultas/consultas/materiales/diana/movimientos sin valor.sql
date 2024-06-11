--no registra valores de movimientos
select items_id, operating_unit_id, sum(amount), sum(costo)
from (
select --items_id, m.operating_unit_id, sum(dmitcant) cantidad, sum(dmitcant*dmitcoun) costo
     m.uni_item_bala_mov_id, m.items_id, m.operating_unit_id, amount, total_value, document_type_id,d.id_items_documento, d.fecha, documento_externo ,mmittimo,dmitcoun*dmitcant costo
from open.or_uni_item_bala_mov m, open.ge_items_documento d, open.ldci_intemmit, open.ldci_dmitmmit
where m.operating_unit_id=2705
 and movement_type!='N'
-- and items_id=10000937
 and m.id_items_documento=d.id_items_documento
 and document_type_id=101
 and mmitdsap=documento_externo
 and mmitcodi=dmitmmit
 and dmitcoin=items_id
--group by items_id, m.operating_unit_id
union
select --items_id, m.operating_unit_id, sum(dmitcant) cantidad, sum(dmitcant*dmitcoun) costo
     m.uni_item_bala_mov_id, m.items_id, m.operating_unit_id, -1*amount, total_value, document_type_id,d.id_items_documento, d.fecha, documento_externo ,mmittimo,-1*dmitcoun*dmitcant costo
from open.or_uni_item_bala_mov m, open.ge_items_documento d, open.ldci_intemmit, open.ldci_dmitmmit
where m.operating_unit_id=2705
 and movement_type!='N'
-- and items_id=10000937
 and m.id_items_documento=d.id_items_documento
 and document_type_id=105
 and mmitnudo=to_char(d.id_items_documento)
 and mmitcodi=dmitmmit
 and dmitcoin=items_id
union
select m.uni_item_bala_mov_id, m.items_id, m.operating_unit_id, -1*amount, total_value, document_type_id,d.id_items_documento, d.fecha, documento_externo ,null mmittimo,0 costo
from open.or_uni_item_bala_mov m, open.ge_items_documento d
where m.operating_unit_id=2705
 and movement_type!='N'
 --and items_id=10000937
 and m.id_items_documento=d.id_items_documento
 and document_type_id=105
 and not exists(select null from open.ldci_intemmit where mmitdsap=documento_externo and mmitdsap is not null)
 )
 group by operating_unit_id, items_id
;



