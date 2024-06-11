Select o.order_id, o.task_type_id,
     a.id_items,
     a.descripcion_items,
     a.cantidad,
     a.valor_unitario,
     a.valor_total
from open.ge_detalle_acta  a,
     open.ge_acta  ac,
     open.or_order  o
where a.id_acta in (204133,
204134,
204135)
and   a.id_items =  102008
and a.id_acta = ac.id_acta
and a.id_orden = o.order_id
