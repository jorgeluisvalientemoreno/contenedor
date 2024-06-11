with certificados as(
select ce.product_id, ce.register_date, ce.review_date, ce.order_act_review_id,  ce.estimated_end_date, row_number() over ( partition by ce.product_id order by ce.product_id, o.legalization_date desc) filas,
       o.order_id, o.task_type_id, o.legalization_Date, o.operating_unit_id, open.daor_operating_unit.fsbgetname(o.operating_unit_id, null) nombre_unidad, o.order_status_id, o.causal_id,
       open.dage_causal.fsbgetdescription(o.causal_id, null) desc_causal, a.activity_id
from open.pr_certificate ce   
inner join open.or_order_activity a on a.order_activity_id=ce.order_act_review_id
inner join open.or_order o on o.order_id=a.order_id
where ce.estimated_end_date<'01/03/2020'
  and ce.register_date<'01/03/2020'
  and ce.review_date=(select max(c2.review_date) from open.pr_certificate c2 where c2.register_date<'01/03/2020' and ce.product_id=c2.product_id)
  and not exists(select null from open.pr_prod_suspension su where su.aplication_Date<'01/03/2020' and su.product_id=Ce.product_id and  (su.inactive_date >= '01/03/2020' or  (su.inactive_date is null and active='Y' ) 
       ))
--979210
--946003
 and o.task_type_id!=12153
 
union all
select ce.product_id, ce.register_date, ce.review_date, ce.order_act_review_id,  ce.estimated_end_date, row_number() over ( partition by ce.product_id order by ce.product_id, o2.legalization_date desc) filas,
       o2.order_id, o2.task_type_id, o2.legalization_Date, o2.operating_unit_id, open.daor_operating_unit.fsbgetname(o2.operating_unit_id, null) nombre_unidad, o2.order_status_id, o2.causal_id,
       open.dage_causal.fsbgetdescription(o2.causal_id, null) desc_causal, a2.activity_id
from open.pr_certificate ce   
inner join open.or_order_activity a on a.order_activity_id=ce.order_act_review_id
inner join open.or_order o on o.order_id=a.order_id
inner join open.or_order_activity a2 on a2.product_id=a.product_id and a2.task_type_id in (12162,10500)
inner join open.or_order o2 on o2.order_id=a2.order_id and o2.task_type_id in (10500,12162) and o2.order_status_id=8
inner join open.ge_causal c on c.causal_id=o2.causal_id and c.class_causal_id=1
where ce.estimated_end_date<'01/03/2020'
  and ce.register_date<'01/03/2020'
  and ce.review_date=(select max(c2.review_date) from open.pr_certificate c2 where c2.register_date<'01/03/2020' and ce.product_id=c2.product_id)
  and not exists(select null from open.pr_prod_suspension su where su.aplication_Date<'01/03/2020' and su.product_id=Ce.product_id and  (su.inactive_date >= '01/03/2020' or  (su.inactive_date is null and active='Y' ) 
       ))
--979210
--946003
 and o.task_type_id=12153
)
, todo as(
select p.subscription_id contrato,
       p.product_id producto,
       p.product_status_id esta_prod,
       open.daps_product_status.fsbgetdescription(p.product_status_id, null) desc_esta_prod,
       sesuesco esta_cort,
       open.pktblestacort.fsbgetdescription(sesuesco, null) desc_esta_cort,
       sesufein fecha_instalacion,
       p.retire_date fecha_retiro,
       c.register_date, 
       c.review_date, 
       c.estimated_end_date,
       c.filas,
       c.order_id, 
       c.task_type_id, 
       c.legalization_Date, 
       c.operating_unit_id, 
       c.nombre_unidad, 
       c.order_status_id, 
       c.causal_id,
       c.desc_causal, 
       c.activity_id cod_actividad,
       open.dage_items.fsbgetdescription(c.activity_id, null) desc_activ,
       (select  oia.certificados_oia_id from open.ldc_certificados_oia oia where oia.id_producto=p.product_id and oia.status_certificado='A' and oia.resultado_inspeccion in (1,4) and trunc(fecha_inspeccion)=trunc(review_date) and oia.fecha_registro=(select max(oia2.fecha_registro) from open.ldc_certificados_oia oia2 where oia2.id_producto=oia.id_producto and oia.fecha_registro<=oia2.fecha_registro and oia2.status_certificado='A' and oia2.resultado_inspeccion in (1,4)) ) oia
from certificados c
inner join open.pr_product p on p.product_id=c.product_id
inner join open.servsusc s on s.sesunuse=c.product_id
where (p.retire_date>='01/03/2020' or p.retire_date is null)
)
select todo.*,
       co.certificado,
       co.fecha_registro,
       co.fecha_inspeccion,
       co.id_organismo_oia,
       open.daor_operating_unit.fsbgetname(co.id_organismo_oia, null) unidad_cert
from todo
left join open.ldc_certificados_oia co on co.certificados_oia_id=todo.oia
