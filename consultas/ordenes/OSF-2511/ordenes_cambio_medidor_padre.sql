select a.product_id "Producto",
       a.subscription_id "Contrato",
       s.package_type_id || ' :  ' || ps_package_type.description as "Tipo de solicitud",
       a.package_id "Solicitud",
       s.motive_status_id || ' :  ' ||
       ps_motive_status.description as "Estado solicitud",
       o.order_id "Orden",
       o.task_type_id || ' : ' || initcap(tt.description) "Tipo de trabajo",
       a.activity_id || ' : ' ||
       initcap(i.description) "Actividad",
       o.order_status_id || ' : ' || oe.description "Estado",
       o.operating_unit_id "Unidad Operativa",
       s.request_date "Fecha de registro",
       ss.sesucicl "ciclo"
  from open.or_order  o
 inner join open.or_order_activity a  on a.order_id = o.order_id
 inner join open.or_task_type tt on tt.task_type_id = o.task_type_id
 inner join open.ge_items i  on i.items_id = a.activity_id
 inner join open.or_order_status oe on oe.order_status_id = o.order_status_id
  left join open.mo_packages  s on s.package_id = a.package_id
  left join open.ps_package_type on ps_package_type.package_type_id = s.package_type_id
  left join open.ps_motive_status on ps_motive_status.motive_status_id = s.motive_status_id
  left join servsusc  ss on ss.sesunuse = a.product_id
 where o.order_status_id in (0,5)
   and ss.sesuesco = 1
   and o.task_type_id in
       (select task_type_id
          from or_task_types_items ti, ge_items_attributes ia, ge_items i
         where ia.items_id = ti.items_id
           and ti.items_id = i.items_id
           and attribute_1_id = 400022
           and attribute_2_id = 400021)
   and not exists (select null
    from ldc_otlegalizar  l
     where l.order_id = o.order_id)        
 order by ss.sesucicl;


