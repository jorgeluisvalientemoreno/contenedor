select r.actividad,
t.description,
r.id_causal,
c.description,
r.cumplida,
r.actividad_regenerar,
a.description,
r.actividad_wf,
r.estado_final, 
e.description,
r.tiempo_espera,
r.action,
r.try_legalize
from open.or_regenera_activida  r
left join open.ge_items  t  on r.actividad = t.items_id
left join open.ge_items a  on r.actividad_regenerar = a.items_id
left join open.ge_causal  c  on r.id_causal = c.causal_id
left join open.or_order_status  e  on r.estado_final = e.order_status_id
where r.actividad in (4000035)


