select a.product_id producto,
       p.package_type_id tipo_solicitud,
       p.package_id solicitud,
       p.motive_status_id estado_solicitud,
       o.order_id orden,
       o.task_type_id tipo_trabajo,
       a.activity_id actividad,
       i.description desc_actividad,
       o.order_status_id estado_ot,
       o.causal_id,
       g.class_causal_id || ' ' || ge.description clase_causal,
       o.operating_unit_id unidad_opertativa
from open.mo_packages p
left join or_order_activity a on p.package_id = a.package_id
left join or_order o on a.order_id = o.order_id  
left join servsusc s on a.product_id = s.sesunuse
left join pr_product  pr on a.product_id  = pr.product_id
left join ge_items i on a.activity_id = i.items_id  
left join ge_causal g on g.causal_id = o.causal_id
left join ge_class_causal ge on ge.class_causal_id = g.class_causal_id 
where o.task_type_id in (12149,12151,12150,12152,12162)
and  p.package_id = 176813478
and  o.order_status_id in (8)
order by   o.created_date desc;