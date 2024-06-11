
--se recomienda consultar por unidad e item
select m.operating_unit_id,
       origen.name,
       origen.oper_unit_classif_id,
       origen.oper_unit_status_id,
       open.daor_oper_unit_status.fsbgetdescription(origen.oper_unit_status_id, null) desc_estatus_orien,
       m.items_id,
       i.description desc_item,
       i.item_classif_id,
       m.uni_item_bala_mov_id,
       m.move_date,
       decode(m.movement_type,'I','INCREMENTO','D', 'DECREMENTO','N','NEUTRO') tipo_movimiento,
       m.item_moveme_caus_id,
       open.daor_item_moveme_caus.fsbgetdescription(m.item_moveme_caus_id, null) desc_movi,
       m.amount cantidad,
       m.total_value,
       m.valor_venta,
       m.terminal,
       m.user_id,
       m.support_document,
       m.target_oper_unit_id,
       dest.name,
       dest.oper_unit_classif_id,
       dest.oper_unit_status_id,
       open.daor_oper_unit_status.fsbgetdescription(dest.oper_unit_status_id, null) desc_estatus_dest,
       m.id_items_seriado,
       s.serie,
       s.id_items_estado_inv,
       s.operating_unit_id unidad_serial,
       m.id_items_documento,
       d.document_type_id,
       open.dage_document_type.fsbgetdescription(d.document_type_id, null) desc_docu_type,
       d.documento_externo,
       d.fecha,
       d.estado,
       d.comentario,
       d.terminal_id,
       d.user_id      
from open.or_uni_item_bala_mov m
inner join open.ge_items i on i.items_id=m.items_id
left join open.or_operating_unit origen on origen.operating_unit_id=m.operating_unit_id
left join open.or_operating_unit dest on dest.operating_unit_id = m.target_oper_unit_id
left join open.ge_items_documento d on d.id_items_documento=m.id_items_documento
left join open.ge_items_seriado s on s.id_items_seriado=m.id_items_seriado