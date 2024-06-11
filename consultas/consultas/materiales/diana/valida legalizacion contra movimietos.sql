with base as(
select o.order_id,
       o.legalization_date,
       (select a.activity_id||it.description from open.or_order_activity a inner join open.ge_items it on it.items_id=a.activity_id where a.order_id=o.order_id ) actividad,
       i.items_id,
       i.description,
       oi.value
from open.or_order o
inner join open.or_order_items oi on oi.order_id=o.order_id
inner join open.ge_items i on i.items_id=oi.items_id and i.item_classif_id in (3,8,21)
where o.order_status_id=8
 and o.legalization_Date>='01/07/2023'
 and o.legalization_date<'01/08/2023'
 and oi.value!=0)
select base.*,
       d.id_items_documento,
       d.id_items_documento,
       m.amount,
       m.total_value
from base
left join open.ge_items_documento d on d.document_type_id=118 and d.documento_externo=to_char(base.order_id)
left join open.or_uni_item_bala_mov m on m.id_items_documento=d.id_items_documento and m.movement_type='D' and m.items_id=base.items_id
where actividad!='102400FACTURA DE REQUISICION'
