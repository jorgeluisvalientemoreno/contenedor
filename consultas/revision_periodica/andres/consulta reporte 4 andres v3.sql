with suspensiones as(
select su.product_id,
       su.suspension_type_id tipo_susp,
       open.dage_suspension_type.fsbgetdescription(su.suspension_type_id) desc_tipo_susp,
       su.register_date, su.aplication_Date, su.inactive_date ,su.active, 
       row_number() over ( partition by su.product_id order by su.product_id, su.aplication_Date desc) filas
from open.pr_prod_suspension su
where su.suspension_type_id in (101,102,103,104)
  and su.aplication_Date<'01/03/2020'
  and (su.inactive_date >= '01/03/2020' or
       (su.inactive_date is null and active='Y')
       )    
       
 
)
, productos as(
select sesususc contrato,
       su.product_id producto,
       sesuesco esta_cort,
       open.pktblestacort.fsbgetdescription(sesuesco, null) desc_esta_cort,
       p.product_status_id esta_prod,
       open.daps_product_status.fsbgetdescription(p.product_status_id, null) desc_esta_prod,
       sesufein fecha_instala,
       sesucicl,
       p.retire_date fecha_retiro, 
       su.tipo_susp tipo_susp,
       open.dage_suspension_type.fsbgetdescription(su.tipo_susp, null) desc_tipo_susp,
       su.register_date, su.aplication_Date, su.inactive_date ,su.active, 
       filas
from suspensiones su
inner join open.pr_product p on p.product_id=su.product_id
inner join open.servsusc s on s.sesunuse=p.product_id
where (p.retire_date>='01/03/2020' or p.retire_date is null)
  and filas=1
)
, certificados as(
select ce.product_id, ce.register_date, ce.review_date, ce.order_act_review_id,  ce.estimated_end_date, row_number() over ( partition by ce.product_id order by ce.product_id, o.legalization_date desc) filas,
       o.order_id, o.task_type_id, o.legalization_Date, o.operating_unit_id, open.daor_operating_unit.fsbgetname(o.operating_unit_id, null) nombre_unidad, o.order_status_id, o.causal_id,
       open.dage_causal.fsbgetdescription(o.causal_id, null) desc_causal, a.activity_id
from open.pr_certificate ce   
inner join suspensiones su on su.product_id=ce.product_id
inner join open.or_order_activity a on a.order_activity_id=ce.order_act_review_id
inner join open.or_order o on o.order_id=a.order_id
where o.legalization_Date<'01/03/2020'
and su.filas=1
 -- and ce.review_date=(select max(c2.review_date) from open.pr_certificate c2 where  c2.register_date<'01/03/2020' and ce.product_id=c2.product_id)
 and o.task_type_id!=12153
union all
select ce.product_id, ce.register_date, ce.review_date, ce.order_act_review_id,  ce.estimated_end_date, row_number() over ( partition by ce.product_id order by ce.product_id, o2.legalization_date desc) filas,
       o2.order_id, o2.task_type_id, o.legalization_Date, o2.operating_unit_id, open.daor_operating_unit.fsbgetname(o2.operating_unit_id, null) nombre_unidad, o2.order_status_id, o2.causal_id,
       open.dage_causal.fsbgetdescription(o2.causal_id, null) desc_causal, a2.activity_id
from open.pr_certificate ce   
inner join suspensiones su on su.product_id=ce.product_id
inner join open.or_order_activity a on a.order_activity_id=ce.order_act_review_id
inner join open.or_order o on o.order_id=a.order_id
inner join open.or_order_activity a2 on a2.product_id=a.product_id and a2.task_type_id in (12162,10500)
inner join open.or_order o2 on o2.order_id=a2.order_id and o2.task_type_id in (10500,12162) and o2.order_status_id=8
inner join open.ge_causal c on c.causal_id=o2.causal_id and c.class_causal_id=1
where o.legalization_Date<'01/03/2020'
and su.filas=1
  --and ce.review_date=(select max(c2.review_date) from open.pr_certificate c2 where  c2.register_date<'01/03/2020' and ce.product_id=c2.product_id)
 and o.task_type_id=12153
)
, todo as(
select su.contrato,
       su.producto,
       su.esta_cort,
       su.desc_esta_cort,
       su.esta_prod,
       su.desc_esta_prod,
       su.fecha_instala,
       sesucicl,
       su.fecha_retiro, 
       su.tipo_susp,
       su.desc_tipo_susp,
       su.register_date, 
       su.aplication_Date, 
       su.inactive_date 
       ,su.active, 
       su.filas,
       ce.ce.register_date fecha_registro_cert, 
       ce.review_date fecha_revision, 
       ce.order_act_review_id,  
       ce.estimated_end_date, 
       ce.filas filas2,
       ce.order_id, 
       ce.task_type_id, 
       ce.legalization_Date, 
       ce.operating_unit_id, 
       ce.nombre_unidad, 
       ce.order_status_id, 
       ce.causal_id,
       ce.desc_causal, 
       ce.activity_id,
       open.dage_items.fsbgetdescription(ce.activity_id, null) desc_activ, 
       (select  oia.certificados_oia_id from open.ldc_certificados_oia oia where oia.id_producto=ce.product_id and oia.status_certificado='A' and oia.resultado_inspeccion in (1,4) and trunc(fecha_inspeccion)=trunc(review_date) and oia.fecha_registro=(select max(oia2.fecha_registro) from open.ldc_certificados_oia oia2 where oia2.id_producto=oia.id_producto and oia2.fecha_registro<'01/03/2020' and oia2.status_certificado='A' and oia2.resultado_inspeccion in (1,4)) ) oia
from productos su
left join certificados ce on ce.product_id=su.producto
where nvl(ce.filas,1) = 1
)
,PERIODO AS(
select pefacicl, pefaano, pefames, pefacodi
  from open.perifact p
  where pefacodi!=-1
   and pefaano!=-1
   and pefames!=-1
   and pefaano>=2000
   and to_date('01/'||p.pefames||'/'||pefaano,'dd/mm/yyyy')>=to_Date('01/'||TO_CHAR(ADD_MONTHS('29/02/2020',-3),'MM')||'/'||TO_CHAR(ADD_MONTHS('29/02/2020',-3),'YYYY'))
   and to_date('01/'||p.pefames||'/'||pefaano,'dd/mm/yyyy')<=to_Date('01/'||TO_CHAR(ADD_MONTHS('29/02/2020',0),'MM')||'/'||TO_CHAR(ADD_MONTHS('29/02/2020',0),'YYYY'))
order by pefacicl, pefaano, pefames desc
)
,todo2 as(
select todo.*,
       co.certificado,
       co.fecha_registro,
       co.fecha_inspeccion,
       co.id_organismo_oia,
       open.daor_operating_unit.fsbgetname(co.id_organismo_oia, null) unidad_cert,
       pefaano,
       pefames,
       LEEMLETO,
       row_number() over ( partition by producto order by producto) filasmes
from todo
left join open.ldc_certificados_oia co on co.certificados_oia_id=todo.oia
left join periodo p on p.pefacicl=sesucicl
LEFT JOIN OPEN.LECTELME L ON p.pefacodi=l.leempefa and l.leemsesu=todo.producto and l.leemclec='F'
--where producto=50080759
order by todo.producto, pefaano desc, pefames desc)
select todo2.contrato,
       todo2.producto,
       todo2.esta_cort,
       todo2.desc_esta_cort,
       todo2.esta_prod,
       todo2.desc_esta_prod,
       todo2.fecha_instala,
       todo2.sesucicl,
       todo2.fecha_retiro, 
       todo2.tipo_susp,
       todo2.desc_tipo_susp,
       todo2.register_date, 
       todo2.aplication_Date, 
       todo2.inactive_date,
       todo2.active, 
       todo2.filas,
       todo2.fecha_registro_cert, 
       todo2.fecha_revision, 
       todo2.order_act_review_id,  
       todo2.estimated_end_date, 
       todo2.filas2,
       todo2.order_id, 
       todo2.task_type_id, 
       todo2.legalization_Date, 
       todo2.operating_unit_id, 
       todo2.nombre_unidad, 
       todo2.order_status_id, 
       todo2.causal_id,
       todo2.desc_causal, 
       todo2.activity_id,
       todo2.desc_activ, 
       todo2.oia,
       todo2.certificado,
       todo2.fecha_registro,
       todo2.fecha_inspeccion,
       todo2.id_organismo_oia,
       todo2.unidad_cert,
       max(DECODE(filasmes,1,leemleto,null)) lectura1,
       max(DECODE(filasmes,2,leemleto,null)) lectura2,
       max(DECODE(filasmes,3,leemleto,null)) lectura3,
       max(DECODE(filasmes,4,leemleto,null)) lectura4
       --(select leemleto from open.lectelme l, open.perifact pf where l.leemclec='T' and l.leemsesu=producto and pf.pefacodi=l.leempefa and pf.pefafimo<=aplication_Date and pf.pefaffmo>=aplication_Date and rownum=1) lec_susp
from todo2     
group by
todo2.contrato,
       todo2.producto,
       todo2.esta_cort,
       todo2.desc_esta_cort,
       todo2.esta_prod,
       todo2.desc_esta_prod,
       todo2.fecha_instala,
       todo2.sesucicl,
       todo2.fecha_retiro, 
       todo2.tipo_susp,
       todo2.desc_tipo_susp,
       todo2.register_date, 
       todo2.aplication_Date, 
       todo2.inactive_date,
       todo2.active, 
       todo2.filas,
       todo2.fecha_registro_cert, 
       todo2.fecha_revision, 
       todo2.order_act_review_id,  
       todo2.estimated_end_date, 
       todo2.filas2,
       todo2.order_id, 
       todo2.task_type_id, 
       todo2.legalization_Date, 
       todo2.operating_unit_id, 
       todo2.nombre_unidad, 
       todo2.order_status_id, 
       todo2.causal_id,
       todo2.desc_causal, 
       todo2.activity_id,
       todo2.desc_activ, 
       todo2.oia,
       todo2.certificado,
       todo2.fecha_registro,
       todo2.fecha_inspeccion,
       todo2.id_organismo_oia,
       todo2.unidad_cert 

--31047
