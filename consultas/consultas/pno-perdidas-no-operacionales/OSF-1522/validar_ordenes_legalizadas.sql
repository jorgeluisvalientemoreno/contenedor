select a.product_id  "Producto",
       a.subscription_id  "Contrato",
       p.package_id  "# Solicitud", 
       p.motive_status_id || ' :  ' || m.description as "Estado solicitud",
       o.order_id  "Orden",
       o.task_type_id || '-  ' || initcap(t.description)  "Tipo de trabajo",
       a.activity_id ||' : '|| initcap(i.description)   "Actividad",
       o.order_status_id || ' : ' || s.description as "Estado orden",
       o.operating_unit_id ||' : '|| initcap(u.name)  "Unidad",
       o.causal_id || '-  ' || initcap(c.description)  "Causal",
       o.defined_contract_id  "Contrato",
       o.legalization_date   "Fecha legalizacion",
       o.is_pending_liq  "Pendiente Liquidacion"
from open.or_order o
left join open.or_order_status s on o.order_status_id = s.order_status_id
left join open.or_order_activity  a on a.order_id = o.order_id
left join open.or_task_type t on t.task_type_id = o.task_type_id
left join open.or_operating_unit u on u.operating_unit_id = o.operating_unit_id
left join open.ge_causal c on c.causal_id = o.causal_id
left join open.ge_items i on i.items_id = a.activity_id
left join open.mo_packages  p on p.package_id = a.package_id 
left join open.ps_motive_status  m on p.motive_status_id = m.motive_status_id
where o.task_type_id = 12617
and   o.order_status_id = 8
--and   o.operating_unit_id = 4439
--and   o.is_pending_liq = 'Y'
and   o.legalization_date >= '18/08/2023' 
and   o.saved_data_values is not null
order by o.legalization_date desc; 
