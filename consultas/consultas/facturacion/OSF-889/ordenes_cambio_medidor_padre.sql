select or_order_activity.product_id "Producto",
       or_order_activity.subscription_id "Contrato",
       mo_packages.package_type_id || ' :  ' || ps_package_type.description as "Tipo de solicitud",
       or_order_activity.package_id "Solicitud",
       mo_packages.motive_status_id || ' :  ' ||
       ps_motive_status.description as "Estado solicitud",
       or_order.order_id "Orden",
       or_order.task_type_id || ' : ' || initcap(or_task_type.description) "Tipo de trabajo",
       or_order_activity.activity_id || ' : ' ||
       initcap(ge_items.description) "Actividad",
       or_order.order_status_id || ' : ' || or_order_status.description "Estado",
       or_order.operating_unit_id "Unidad Operativa",
       mo_packages.request_date "Fecha de registro",
       servsusc.sesucicl "ciclo"
  from open.or_order
 inner join open.or_order_activity on or_order_activity.order_id = or_order.order_id
 inner join open.or_task_type on or_task_type.task_type_id = or_order.task_type_id
 inner join open.ge_items on ge_items.items_id = or_order_activity.activity_id
 inner join open.or_order_status on or_order_status.order_status_id = or_order.order_status_id
  left join open.mo_packages on mo_packages.package_id = or_order_activity.package_id
  left join open.ps_package_type on ps_package_type.package_type_id = mo_packages.package_type_id
  left join open.ps_motive_status on ps_motive_status.motive_status_id = mo_packages.motive_status_id
  left join servsusc on servsusc.sesunuse = or_order_activity.product_id
 where or_order.order_status_id in (0,5)
   and servsusc.sesucicl = 8489
   and servsusc.sesuesco = 1
   and or_order.task_type_id in
       (select task_type_id
          from or_task_types_items ti, ge_items_attributes ia, ge_items i
         where ia.items_id = ti.items_id
           and ti.items_id = i.items_id
           and attribute_1_id = 400022
           and attribute_2_id = 400021)
 order by servsusc.sesucicl;
