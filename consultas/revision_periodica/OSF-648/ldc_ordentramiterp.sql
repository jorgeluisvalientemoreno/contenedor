select l.orden,
       l.tipotrabajo,
       t.description,
       l.causal,
       g.description,
       l.solicitud,
       l.unidadopera,
       a.order_id,
       a.task_type_id,
       t2.description,
       o.order_status_id,
       o.operating_unit_id,
       o.created_date,
       o.legalization_date,
       l.procesado
from ldc_ordentramiterp  l
left join or_task_type  t on t.task_type_id = l.tipotrabajo
left join ge_causal  g on g.causal_id = l.causal
left join or_order_activity  a on a.package_id = l.solicitud
left join or_order  o on o.order_id = a.order_id
left join or_task_type  t2 on t2.task_type_id = o.task_type_id
where l.orden = 263252222;
