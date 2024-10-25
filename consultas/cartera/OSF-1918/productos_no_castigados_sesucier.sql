select ldc_osf_sesucier.contrato ,
       ldc_osf_sesucier.producto ,
       ldc_osf_sesucier.nuano, 
       ldc_osf_sesucier.numes,
       ldc_osf_sesucier.ciclo ,
       ldc_osf_sesucier.producto, 
       ldc_osf_sesucier.estado_financiero, 
       ldc_osf_sesucier.categoria , 
       servsusc.sesuesco || ' ' || estacort.escodesc estado_corte  
from open.ldc_osf_sesucier 
left join  open.servsusc  on ldc_osf_sesucier.producto = servsusc.sesunuse and ldc_osf_sesucier.contrato = servsusc.sesususc 
left join open.estacort on servsusc.sesuesco = estacort.escocodi 
where ldc_osf_sesucier.nuano = 2022
and ldc_osf_sesucier.numes= 9 
and ldc_osf_sesucier.tipo_producto in (7014,7055)
and (select count (or_order.order_id)
    from open.or_order   , open.or_order_activity 
    where  or_order.order_id = or_order_activity.order_id 
    and subscription_id = ldc_osf_sesucier.contrato 
    and product_id = ldc_osf_sesucier.producto
    and or_order.order_status_id in (0,5)
    and or_order.task_type_id in (5005) ) = 0 
and ldc_osf_sesucier.sesusape > 0 
and ldc_osf_sesucier.estado_financiero not in ( 'C')
and rownum < 50
  
