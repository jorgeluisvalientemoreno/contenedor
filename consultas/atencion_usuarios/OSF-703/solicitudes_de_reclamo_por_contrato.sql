select mo_motive.subscription_id  "Contrato",
       mo_packages.package_id  "# Solicitud", 
       mo_packages.package_type_id || '-  ' || ps_package_type.description as "Tipo de solicitud", 
       mo_packages.motive_status_id || '-  ' || ps_motive_status.description as "Estado solicitud", 
       mo_packages.cust_care_reques_num  "Interaccion",
       mo_packages.reception_type_id || '-  ' || ge_reception_type.description  "Medio de recepcion",
       mo_packages.request_date   "Fecha de registro", 
       or_order.order_id  "Orden",
       or_order.order_status_id || ' - ' || or_order_status.description as "Estado orden",
       or_order.task_type_id || '-  ' || initcap(or_task_type.description)  "Tipo de trabajo"
from open.mo_packages
left join open.mo_motive on mo_motive.package_id = mo_packages.package_id
left join open.pr_product on pr_product.product_id = mo_motive.product_id 
left join open.ps_motive_status on mo_packages.motive_status_id = ps_motive_status.motive_status_id
left join open.ps_package_type on ps_package_type.package_type_id = mo_packages.package_type_id
left join open.ge_reception_type on ge_reception_type.reception_type_id = mo_packages.reception_type_id
left join open.or_order_activity on or_order_activity.package_id = mo_packages.package_id
left join open.or_order on or_order.order_id = or_order_activity.order_id 
left join open.or_order_status  on or_order.order_status_id = or_order_status.order_status_id
left join open.or_task_type on or_task_type.task_type_id = or_order.task_type_id
where mo_packages.package_type_id = 545
and mo_motive.subscription_id = 1181188
and mo_packages.request_date >= trunc(sysdate)
order by mo_packages.request_date desc;