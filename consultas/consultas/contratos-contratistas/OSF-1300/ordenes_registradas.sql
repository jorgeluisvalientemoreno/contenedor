select or_order_activity.product_id  "Producto",
       or_order_activity.subscription_id  "Contrato",
       mo_packages.package_id  "# Solicitud", 
       mo_packages.motive_status_id || ' :  ' || ps_motive_status.description as "Estado solicitud",
       or_order.order_id  "Orden",
       or_order.task_type_id || ' :  ' || initcap(or_task_type.description)  "Tipo de trabajo",
       or_order.order_status_id || ' : ' || or_order_status.description as "Estado orden",
       or_order.operating_unit_id ||' :  '|| initcap(or_operating_unit.name)  "Unidad",
       or_order.causal_id || ' : ' || initcap(ge_causal.description)  "Causal",
       or_order_activity.activity_id ||' : '|| initcap(ge_items.description)   "Actividad",
       or_order.defined_contract_id  "Contrato",
       or_order.legalization_date   "Fecha legalizacion"
from open.or_order
left join open.or_order_status  on or_order.order_status_id = or_order_status.order_status_id
left join open.or_order_activity on or_order_activity.order_id = or_order.order_id
left join open.or_task_type on or_task_type.task_type_id = or_order.task_type_id
left join open.or_operating_unit on or_operating_unit.operating_unit_id = or_order.operating_unit_id
left join open.ge_causal on ge_causal.causal_id = or_order.causal_id
left join open.ge_items on ge_items.items_id = or_order_activity.activity_id
left join open.mo_packages on mo_packages.package_id = or_order_activity.package_id 
left join open.ps_motive_status on mo_packages.motive_status_id = ps_motive_status.motive_status_id 
where or_order.task_type_id = 12155
and or_order.order_status_id = 0


--and or_order_activity.activity_id in (4000056,294129466);
