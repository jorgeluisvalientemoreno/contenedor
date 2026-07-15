--ordenes_por_tipo_de_notificacion
select o.order_id,
       o.task_type_id,
       tt.description,
       o.order_status_id,
       o.operating_unit_id,
       u.name,
       u.admin_base_id,
       ba.descripcion,
       mb.empresa  empresa_base,
       nt.id_notificacion,
       n.description,
       n.xsl_template_id,
       x.description
from or_order o
 inner join or_task_type  tt  on tt.task_type_id = o.task_type_id
 inner join or_order_activity  a  on a.order_id = o.order_id
 inner join or_notif_tipo_traba nt  on nt.id_tipo_trabajo = o.task_type_id and nt.id_notificacion = 100376
 inner join ge_notification  n  on n.notification_id = nt.id_notificacion
 inner join ge_xsl_template x  on x.xsl_template_id = n.xsl_template_id
 inner join or_operating_unit  u  on u.operating_unit_id  = o.operating_unit_id
 inner join ge_base_administra  ba  on ba.id_base_administra = u.admin_base_id
 left outer join multiempresa.base_admin  mb  on mb.base_administrativa = ba.id_base_administra
 left outer join ct_item_novelty nv  on nv.items_id = a.activity_id and nv.liquidation_sign is null
where 1 = 1
 and  o.order_status_id in (5,8)
 
 
 and o.order_id = 113590808
 
 
 --and rownum <= 20
 --and u.admin_base_id != 3
 --and o.order_id = 13382314


 --and o.created_date >= '01/01/2025'
 --and u.admin_base_id != 3
 --and rownum <= 10
 order by o.created_date
--and o.order_id = 12888202


--and o.task_type_id not in (12527)
--and u.admin_base_id = 3
 
/*
OSF-4720


100375- LDC_NOTI_GENERICA_ORDENES_DE_TRABAJO GDCA - 13382314
100375- LDC_NOTI_GENERICA_ORDENES_DE_TRABAJO GDGU - 13843094

100376 - LDC_NOTIFICACION_REVISION_CONSUMO GDCA - 113590842
100376 - LDC_NOTIFICACION_REVISION_CONSUMO GDGU - 113590808

OSF-4719

100199 LDC_NOTIFICACION_CONST_REDES_EXT GDCA - 369197223
100199 LDC_NOTIFICACION_CONST_REDES_EXT GDGU - 369643718

100154 LDC_Notificacion_Orden_Trab_Peticiones GDCA - 12879526
100154 LDC_Notificacion_Orden_Trab_Peticiones GDGU - 12888202

OSF-4718

100471 LDC_FORM_SUS_RECO_PERS_GDC GDCA - 367049717 - 4337
100471 LDC_FORM_SUS_RECO_PERS_GDC GDGU - 366827597 - 4333

100153 LDC_CONSTRUCCION DE INTERNAS GDCA - 343412679 - 4595
100153 LDC_CONSTRUCCION DE INTERNAS GDGU - 367006995 - 4253

100472 LDC_FORMATO_ORD_RECONE_CARTERA_GDC GDCA - 370381241 - 4757
100472 LDC_FORMATO_ORD_RECONE_CARTERA_GDC GDGU - 370547979 - 4333

100193 LDC_NOTIFICACION_OT_SERV_INGENIERIA GDCA - 55588332 - 2075
100193 LDC_NOTIFICACION_OT_SERV_INGENIERIA GDGU - 13358460 - 3359

100473 LDC_FORMATO_ORD_PERSECU_CARTERA_GDC GDCA - 370194585 - 4757
100473 LDC_FORMATO_ORD_PERSECU_CARTERA_GDC GDGU - 369347737 - 4333


*/
