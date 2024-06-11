select or_order_activity.product_id "Producto",
       servsusc.sesucico "Ciclo",
       (select max(pc2.pecscons)
       from open.pericose pc2
       where pc.pecscico= pc2.pecscico
       and pc2.pecscons < pc.pecscons
       and pc2.pecsfecf < pc.pecsfeci
       and pc2.pecsfeci = (select max(pc3.pecsfeci)
       from open.pericose pc3 where pc2.pecscico= pc3.pecscico
        and pc3.pecscons < pc.pecscons and pc3.pecsfecf < pc.pecsfeci ))"Periodo_cons_ant",
       pc.pecscons "Periodo_cons",
       pc.pecsfeci "Fecha_inicial_cons",or_order_activity.package_id "Solicitud",or_order.order_id "Orden",
       pc.pecsfecf "Fecha_fin_cons",
       or_order.task_type_id  || ' -' || initcap(or_task_type.description)  "Tipo_trabajo",
   case when  or_order.order_status_id = 5 then 'Asignada'
        when  or_order.order_status_id = 8 then 'Legalizada'
        when  or_order.order_status_id = 11 then 'Bloqueada'
        when  or_order.order_status_id = 12 then 'Anulada'
        when  or_order.order_status_id = 0 then 'Registrada'
        when  or_order.order_status_id = 7 then 'Ejecutada' end as "Estado",
        or_order.operating_unit_id "Unidad_operativa",
       or_order.created_date "Fecha_creacion",
       fecha_registro ,
       ldc_otlegalizar.exec_final_date "Fecha_fin_ejecucion_ot",
       legalizado
from or_order
inner join open.or_task_type  on or_task_type.task_type_id =or_order.task_type_id
inner join open.or_order_activity  on or_order_activity.order_id =or_order.order_id
left join open.servsusc on servsusc.sesunuse =  or_order_activity.product_id
left join open.ldc_otlegalizar on or_order.order_id= ldc_otlegalizar.order_id
left join open.pericose pc on pc.pecscico = servsusc.sesucico and ldc_otlegalizar.exec_final_date  between pc.pecsfeci and pc.pecsfecf
left join open.perifact pf on servsusc.sesucico = pf.pefacicl and pc.pecsfecf  between pf.pefafimo and pf.pefaffmo
Where or_order.task_type_id  in (10074,10075,11260,10534,12143,10933,10951,10764,11027,11028,11033,11034,11094,10720,12619)
and or_order.order_status_id in (0,5,8)
and rownum <= 3
and or_order_activity.product_id = 17188800
order by or_order.created_date desc
