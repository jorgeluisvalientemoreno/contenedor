select l.order_id,
       l.causal_id,
       o.operating_unit_id,
       o.order_status_id,
       l.order_comment,
       l.exec_initial_date,
       l.exec_final_date,
       l.legalizado,
       s.sesucicl,
       l.fecha_registro,
       l.task_type_id,
       l.mensaje_legalizado
from open.ldc_otlegalizar   l
inner join or_order  o  on o.order_id = l.order_id
inner join or_order_activity  oa  on oa.order_id = l.order_id
inner join servsusc  s  on s.sesunuse = oa.product_id
where l.fecha_registro >= '01/05/2023'
and   l.order_comment like '%OSF-889%'
and   s.sesucicl = 8489
and   o.operating_unit_id = 4273
l.order_id in (280194400,
280194383,
280197830,
278725505,
279585360);

-- Trabajos adicionales

select a.order_id,
       a.task_type_id,
       a.actividad,
       t.description,
       a.material,
       a.cantidad,
       a.causal_id
from open.ldc_otadicional a
inner join or_task_type t on t.task_type_id = a.task_type_id
where order_id=280194390;
