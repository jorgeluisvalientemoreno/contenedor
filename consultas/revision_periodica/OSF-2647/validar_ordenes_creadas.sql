-- solicitudes_por_producto
select p.package_type_id    Tipo_Solicitud,
       ts.description       Desc_Tipo_Solicitud,
       p.package_id         Solicitud,
       p.motive_status_id   Estado_Solicitud,
       e.description,
       trunc(p.request_date) Crea_Sol,
       o.order_id           Orden,
       o.task_type_id       Tipo_Trabajo,
       a.activity_id        Actividad,
       i.description        Desc_Actividad,
       o.order_status_id    Estado_OT,
       p.subscriber_id      Clie_Sol,
       a.subscriber_id      Clie_Act,
       p.comment_,
       case when p.subscriber_id = a.subscriber_id then 'IGUAL'
           else 'DIFERENTE' end as Cliente,
       ms.subscription_id    Cont_Mot,
       a.subscription_id    Cont_Act,
       case when  ms.subscription_id = a.subscription_id then 'IGUAL'
           else 'DIFERENTE' end as contrato,
       ms.product_id         Prod_Mot,
       a.product_id         Prod_Act,
       case when  ms.product_id = a.product_id then 'IGUAL'
           else 'DIFERENTE' end as producto
  from open.mo_packages p
  left join open.ps_package_type ts on ts.package_type_id =  p.package_type_id
  left join open.mo_motive ms on ms.package_id =  p.package_id
  left join ps_motive_status  e  on e.motive_status_id = ms.motive_status_id 
  left join open.or_order_activity a on p.package_id = a.package_id
  left join open.or_order o on a.order_id = o.order_id  
  left join open.servsusc s on ms.product_id = s.sesunuse
  left join open.pr_product  pr on ms.product_id = pr.product_id
  left join open.ge_items i on a.activity_id = i.items_id
 where p.subscriber_id = 82383
 --and   ms.product_id in (50705405, 50705677,50650360, 50650999, 50705750, 50649067, 50648453, 50705602)
 and   p.package_type_id in (100246)
 and ms.product_id in (50649941,50648588,50649582,50649591,50649690,50649715,50649826,50650791,50648931,50650003,50705707,50648589,50650713,50649800,50649841,50649865,50706349,50651041,50648518,50648608,50705963,50648619,50648631,50649717,50649725,50649796,50649972,50648543,50705907,50649815,50649882,50649895,50706333,50650030,50651073,50705836,50648684,50650705,50649874,50649986,50705436,50648594,50648598,50648626,50648714,50648726,50648764,50648792,50706126,50649960,50705857,50705879,50649753,50649833,50649844,50649856,50649900,50649908,50648963,50650990,50705703,50705832,50648556,50648648,50649765)
 --and   a.activity_id in (4295664)
 and   p.request_date >= '05/06/2024'
  order by ms.motiv_recording_date desc
 
-- and   ms.product_id in (50705405, 50705677,50650360, 50650999, 50705750, 50649067, 50648453, 50705602)
