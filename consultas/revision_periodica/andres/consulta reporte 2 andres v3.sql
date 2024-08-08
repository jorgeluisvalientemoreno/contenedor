with productos as(
select p.subscription_id, p.product_id, p.category_id, sesufein, p.product_status_id, p.retire_date ,  sesuesco, open.pktblestacort.fsbgetdescription(sesuesco, null) desc_estacort
from open.pr_product p
inner join open.servsusc s on s.sesunuse=p.product_id
where p.product_type_id=7014
  and sesufein>='01/01/2014'
  and sesufein<'01/03/2020'
  and p.product_status_id in (1,2,4)
  and (p.retire_date>'01/03/2020' or p.retire_date is null)
 -- and product_id in (51592499,51592485,51592474,51976265,51950901,51851265,51953255,51864410,51864434,51864430,51921235,51924580,51890799,51890780,51890788,51890798,51890792,51910759,51890779,51890773,51911428,51891395,51889454,51866815,51870011,51872525,51866424,51861560,51849447,51847419,51847431,51847447,51826128,51828479,51817952,51805815,51840292,51677182,51624694,51801906,51804040,51804050,51756952,51756965,51776380,51792161,51756975,51773724,51667395,51764917,51476530,51754109,51698384,51698449,51698459,51698469,51736297,51703869,51698486,51698427,51698447,51698448,51711049,51703445,51700946,51650173,51674749,51512463,51512465,51512466,51512467,51512469,51512471,51512474,51512485,51512486,51512491,51512492,51512497,51512462,51512464,51512468,51512470,51512472,51512473,51512475,51512476,51512477,51512478,51512479,51512480,51512481,51512482,51512483,51512484,51512487,51512488,51512489,51512490,51512493,51512495,51512496,51512417,51512432,51512438,51512439,51512440,51512441,51512442,51512443,51512444,51512445,51512446,51512452,51512454,51512455,51512456,51512457,51512416,51512418,51512419,51512420,51512421,51512422,51512423,51512424,51512425,51512426,51512427,51512428,51512429,51512430,51512431,51512433,51512434,51512435,51512436,51512437,51512447,51512448,51512449,51512450,51512451,51512453,51583536,51653300,51613621,51613626,51613631,51613634,51613654,51613666,51613667,51613669,51613619,51613627,51613628,51613633,51613641,51613642,51613643,51613647,51613649,51613650,51613651,51613653,51613656,51613657,51613659,51613661,51441498,51640739,51639048,51646385)
 --and product_id=50893565
  union all
select p.subscription_id, p.product_id, p.category_id, sesufein, p.product_status_id, p.retire_date , sesuesco, open.pktblestacort.fsbgetdescription(sesuesco, null) desc_estacort
from open.pr_product p
inner join open.servsusc s on s.sesunuse=p.product_id
where p.product_type_id=7014
  and sesufein>='01/01/2014'
  and sesufein<'01/03/2020'
  and p.product_status_id in (3)
  and p.retire_date>'01/03/2020'
  and sesuesco!=110 
  --and product_id=50893565
  --and product_id in (51592499,51592485,51592474,51976265,51950901,51851265,51953255,51864410,51864434,51864430,51921235,51924580,51890799,51890780,51890788,51890798,51890792,51910759,51890779,51890773,51911428,51891395,51889454,51866815,51870011,51872525,51866424,51861560,51849447,51847419,51847431,51847447,51826128,51828479,51817952,51805815,51840292,51677182,51624694,51801906,51804040,51804050,51756952,51756965,51776380,51792161,51756975,51773724,51667395,51764917,51476530,51754109,51698384,51698449,51698459,51698469,51736297,51703869,51698486,51698427,51698447,51698448,51711049,51703445,51700946,51650173,51674749,51512463,51512465,51512466,51512467,51512469,51512471,51512474,51512485,51512486,51512491,51512492,51512497,51512462,51512464,51512468,51512470,51512472,51512473,51512475,51512476,51512477,51512478,51512479,51512480,51512481,51512482,51512483,51512484,51512487,51512488,51512489,51512490,51512493,51512495,51512496,51512417,51512432,51512438,51512439,51512440,51512441,51512442,51512443,51512444,51512445,51512446,51512452,51512454,51512455,51512456,51512457,51512416,51512418,51512419,51512420,51512421,51512422,51512423,51512424,51512425,51512426,51512427,51512428,51512429,51512430,51512431,51512433,51512434,51512435,51512436,51512437,51512447,51512448,51512449,51512450,51512451,51512453,51583536,51653300,51613621,51613626,51613631,51613634,51613654,51613666,51613667,51613669,51613619,51613627,51613628,51613633,51613641,51613642,51613643,51613647,51613649,51613650,51613651,51613653,51613656,51613657,51613659,51613661,51441498,51640739,51639048,51646385)

  )
, certificados as(
select ce.product_id, ce.register_date, ce.review_date, ce.order_act_review_id,  row_number() over ( partition by ce.product_id order by ce.product_id, o.legalization_date desc) filas,
       o.order_id, o.task_type_id, o.legalization_Date, o.operating_unit_id, open.daor_operating_unit.fsbgetname(o.operating_unit_id, null) nombre_unidad, o.order_status_id, o.causal_id,
       open.dage_causal.fsbgetdescription(o.causal_id, null) desc_causal, a.activity_id
from open.pr_certificate ce   
inner join open.or_order_activity a on a.order_activity_id=ce.order_act_review_id
inner join open.or_order o on o.order_id=a.order_id
where ce.register_date=(select min(ce2.register_date) from open.pr_certificate ce2 where ce.product_id=ce2.product_id and ce2.register_Date<'01/03/2020')
and o.task_type_id!=12153

union all
select ce.product_id, ce.register_date, ce.review_date, ce.order_act_review_id,  row_number() over ( partition by ce.product_id order by ce.product_id, o2.legalization_date desc) filas,
       o2.order_id, o2.task_type_id, o2.legalization_Date, o2.operating_unit_id, open.daor_operating_unit.fsbgetname(o2.operating_unit_id, null) nombre_unidad, o2.order_status_id, o2.causal_id,
       open.dage_causal.fsbgetdescription(o2.causal_id, null) desc_causal, a2.activity_id
from open.pr_certificate ce   
inner join open.or_order_activity a on a.order_activity_id=ce.order_act_review_id
inner join open.or_order o on o.order_id=a.order_id
inner join open.or_order_activity a2 on a2.product_id=a.product_id and a2.task_type_id in (12162,10500)
inner join open.or_order o2 on o2.order_id=a2.order_id and o2.task_type_id in (10500,12162) and o2.order_status_id=8
inner join open.ge_causal c on c.causal_id=o2.causal_id and c.class_causal_id=1
where ce.register_date=(select min(ce2.register_date) from open.pr_certificate ce2 where ce.product_id=ce2.product_id)
and o.task_type_id=12153

)
, todo as(
select p.subscription_id contrato,
       p.product_id producto ,
       p.category_id cod_Categoria,
       open.pktblcategori.fsbgetdescription(p.category_id) desc_cate,
       p.product_status_id estado_prod,
       open.daps_product_status.fsbgetdescription(p.product_status_id, null) desc_esta_prod,
       p.sesuesco estado_corte,
       p.desc_estacort,
       sesufein fecha_instalacion,
       p.retire_date fecha_retiro,
       c.register_date fecha_registro, 
       c.review_date fecha_revision, 
       c.filas,
       c.order_id, 
       c.task_type_id, 
       open.daor_task_Type.fsbgetdescription(c.task_type_id , null) desc_titr,
        c.activity_id actividad,
       open.dage_items.fsbgetdescription(c.activity_id, null) desc_actividad,
       c.legalization_Date fecha_lega, 
       c.operating_unit_id, 
       c.nombre_unidad, 
       c.order_status_id, 
       c.causal_id,
       c.desc_causal,
       (select oia.certificados_oia_id from open.ldc_certificados_oia oia where oia.id_producto=p.product_id and oia.status_certificado='A' and oia.resultado_inspeccion in (1,4) and trunc(fecha_inspeccion)=trunc(review_date) and oia.fecha_registro=(select max(oia2.fecha_registro) from open.ldc_certificados_oia oia2 where oia2.id_producto=oia.id_producto and oia2.fecha_registro<'01/03/2020' and trunc(oia2.fecha_inspeccion)<=trunc(c.register_date) and oia2.status_certificado='A' and oia2.resultado_inspeccion in (1,4)) ) oia
from productos p
left join certificados c on c.product_id=p.product_id
where nvl(filas,1)=1
)
select todo.*,
       co.certificado,
       co.fecha_registro,
       co.fecha_inspeccion,
       co.id_organismo_oia,
       open.daor_operating_unit.fsbgetname(co.id_organismo_oia, null) unidad_cert
from todo
left join open.ldc_certificados_oia co on co.certificados_oia_id=todo.oia
