select or_order_activity.subscription_id  "Contrato", 
       or_order_activity.product_id  "Producto", 
       servsusc.sesucicl  "Ciclo", 
       (select pericose.pecscons
                                    from open.pericose
                                    where pericose.pecscico = servsusc.sesucicl
                                    and or_order.created_date between pericose.pecsfeci and pericose.pecsfecf)  "Periodo de Consumo",
       (select pericose.pecsfeci ||' - '|| pericose.pecsfecf
        from open.pericose
        where pericose.pecscico = servsusc.sesucicl
        and or_order.created_date between pericose.pecsfeci and pericose.pecsfecf)  "Vigencia del Periodo",
       or_order_activity.package_id  "Solicitud",
       mo_packages.package_type_id || ' :  ' || ps_package_type.description as "Tipo de Solicitud", 
       mo_packages.motive_status_id || ' :  ' || ps_motive_status.description as "Estado Solicitud", 
       or_order.order_id  "Orden", 
       or_order.task_type_id ||' : '|| initcap(or_task_type.description)  "Tipo de Trabajo",
       or_order_activity.activity_id ||' : '|| initcap(ge_items.description)  "Actividad", 
       or_order.order_status_id ||' : '|| or_order_status.description  "Estado",
       or_order.created_date   "Fecha de Registro", 
       or_order.assigned_date  "Fecha de Asignacion"
from open.or_order
left join open.or_order_activity on or_order_activity.order_id = or_order.order_id
left join open.or_task_type on or_task_type.task_type_id = or_order.task_type_id
left join open.ge_items on ge_items.items_id = or_order_activity.activity_id
left join open.or_order_status on or_order_status.order_status_id = or_order.order_status_id
left join open.mo_packages on mo_packages.package_id = or_order_activity.package_id
left join open.ps_package_type on ps_package_type.package_type_id = mo_packages.package_type_id
left join open.ps_motive_status on ps_motive_status.motive_status_id = mo_packages.motive_status_id
left join open.servsusc on servsusc.sesunuse = or_order_activity.product_id
where or_order.order_status_id in (0,5)
and or_order.task_type_id in (12617)
and exists (select null from open.or_order_activity  oa
            inner join open.mo_packages  p on p.package_id = oa.package_id
            inner join open.or_order  o on o.order_id = oa.order_id
            where oa.product_id = or_order_activity.product_id
            and p.package_type_id = 100101
            and o.order_status_id in (0,5)
            and o.task_type_id in (select task_type_id
                              from or_task_types_items ti, ge_items_attributes ia, ge_items i
                              where ia.items_id = ti.items_id
                              and ti.items_id = i.items_id
                              and attribute_1_id = 400022
                              and attribute_2_id = 400021)
            and not exists (select null
                from open.ldc_ctrllectura
                where ldc_ctrllectura.num_producto = oa.product_id
                and ldc_ctrllectura.id_solicitud = oa.package_id)                 
             )
and (select nvl(hc.hcppcopr, 0)
     from open.hicoprpm hc
     where hc.hcppsesu = or_order_activity.product_id
     and hc.hcpppeco = (select pc.pecscons
                        from open.pericose pc
                        where pc.pecsfecf = (select max(t.pecsfecf)
                                             from open.pericose t
                                             where t.pecscico in (select ss.sesucicl
                                                                  from open.servsusc ss
                                                                  where ss.sesunuse = or_order_activity.product_id)
                                                                  and t.pecsproc = 'S'
                                                                  and t.pecsflav = 'S')
                                             and pc.pecscico in (select ss.sesucicl
                                                                 from open.servsusc ss
                                                                 where ss.sesunuse = or_order_activity.product_id)
                                             and rownum = 1)) > 0
and not exists (select null 
                from open.or_order  o
                inner join open.or_order_activity  oa on oa.order_id = o.order_id
                where oa.product_id = or_order_activity.product_id
                and o.order_status_id in (0,5)
                and o.task_type_id = 12619);
