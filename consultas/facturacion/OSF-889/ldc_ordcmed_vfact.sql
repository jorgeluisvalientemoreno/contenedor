select m.orden,
       m.orden_hija,
       o.task_type_id,
       t.description,
       m.causal,
       o.order_status_id,
       o.operating_unit_id,
       m.periodo,
       m.fecha_procesa
from personalizaciones.ldc_ordcmed_vfact  m
inner join or_order  o on o.order_id = m.orden
inner join or_task_type  t on t.task_type_id = o.task_type_id
where m.periodo = 104327;
