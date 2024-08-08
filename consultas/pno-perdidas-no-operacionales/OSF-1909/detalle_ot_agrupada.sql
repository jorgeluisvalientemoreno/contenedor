select distinct ag.orden_agrupadora,
       o.task_type_id  tipo_trab_agr,
       o.order_status_id  estado_ot_agr,
       o.operating_unit_id  Unidad_trab_agr,
       o.legalization_date  fech_leg_agr,
       o.is_pending_liq,
       ag.orden,
       o2.task_type_id  tipo_trab_indiv,
       o2.order_status_id  estado_ot_indiv,
       o2.operating_unit_id  Unidad_trab_indiv,
       o2.legalization_date  fech_leg_indiv,
       ag.fecha_procesada,
       ag.estado
from detalle_ot_agrupada  ag
inner join open.or_order o on o.order_id = ag.orden_agrupadora
inner join open.or_order o2 on o2.order_id = ag.orden
--where o.created_date >= '22/05/2024 11:00:00'
order by ag.orden_agrupadora
--ag.fecha_procesada > '23/02/2024 2:00:00 '

--ag.estado = 'P'



--ag.orden_agrupadora in (305897979)
--and   trunc(o.created_date) >= '19/02/2024'
--order by ag.orden

--
/*select *--count (*)
from detalle_ot_agrupada  ag
inner join open.or_order o on o.order_id = ag.orden_agrupadora
where ag.orden = 297258974
and   trunc(o.created_date) >= '19/02/2024'*/
--ag.estado = 'P'

--and   ag.orden = 297905843
