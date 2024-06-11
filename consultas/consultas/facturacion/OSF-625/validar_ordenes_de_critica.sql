select or_order_activity.product_id "Producto",
       servsusc.sesucico "Ciclo",
       or_order.task_type_id  || ' -' || initcap(or_task_type.description)  "Tipo_trabajo",
       or_order_activity.package_id "Solicitud",
       or_order.order_id "Orden",
   case when  or_order.order_status_id = 5 then 'Asignada'
        when  or_order.order_status_id = 8 then 'Legalizada'
        when  or_order.order_status_id = 11 then 'Bloqueada'
        when  or_order.order_status_id = 12 then 'Anulada'
        when  or_order.order_status_id = 0 then 'Registrada'
        when  or_order.order_status_id = 7 then 'Ejecutada' end as "Estado",
        or_order.operating_unit_id "Unidad_operativa",
       or_order.created_date "Fecha_creacion"
from or_order 
inner join open.or_task_type  on or_task_type.task_type_id =or_order.task_type_id
inner join open.or_order_activity  on or_order_activity.order_id =or_order.order_id
left join open.servsusc on servsusc.sesunuse =  or_order_activity.product_id
left join open.ldc_otlegalizar on or_order.order_id= ldc_otlegalizar.order_id 
where or_order.task_type_id in (12619)
and or_order.order_status_id in (0,5)
and or_order_activity.product_id = 1052029
order by or_order.created_date desc;