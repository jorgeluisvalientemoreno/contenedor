select or_order_activity.product_id  "Producto",
       or_order_activity.subscription_id  "Contrato",
       servsusc.sesuesco "Estado Corte",
       servsusc.sesuesfn  "Estado Financiero",
       mo_packages.package_id  "# Solicitud", 
       or_order.task_type_id || '-  ' || initcap(or_task_type.description)  "Tipo de trabajo",
       or_order.order_id  "Orden",
       or_order.order_status_id || ' - ' || or_order_status.description as "Estado orden",
       or_order.operating_unit_id  "Unidad de Trabajo",
       case when or_order_comment.comment_type_id = 8963 then 'Si' 
            when or_order_comment.comment_type_id != 8963 then 'No' end  "Solicitud SAC asociada",
       or_order.causal_id || '-  ' || initcap(ge_causal.description)  "Causal",
       or_order.created_date  "Fecha de creacion"
from open.or_order
left join open.or_order_status  on or_order.order_status_id = or_order_status.order_status_id
left join open.or_order_activity on or_order_activity.order_id = or_order.order_id
left join open.or_task_type on or_task_type.task_type_id = or_order.task_type_id
left join open.or_operating_unit on or_operating_unit.operating_unit_id = or_order.operating_unit_id
left join open.ge_causal on ge_causal.causal_id = or_order.causal_id
left join open.ge_items on ge_items.items_id = or_order_activity.activity_id
left join open.mo_packages on mo_packages.package_id = or_order_activity.package_id 
left join open.ps_package_type on ps_package_type.package_type_id = mo_packages.package_type_id
left join open.ps_motive_status on mo_packages.motive_status_id = ps_motive_status.motive_status_id
left join open.or_order_comment on or_order_comment.order_id = or_order.order_id
left join open.pr_product on pr_product.product_id = or_order_activity.product_id
left join open.servsusc on servsusc.sesunuse = or_order_activity.product_id
where or_order.task_type_id = 11029
and or_order.order_status_id in (5)
and servsusc.sesuesco = 5
and or_order_comment.comment_type_id = 8963
order by or_order.created_date desc;

