select sesususc "Contrato",
       sesunuse "Producto",
       o.order_id "Orden",
       o.task_type_id  || ' -' || initcap(t.description)  "Tipo_trabajo",
  case when  o.order_status_id = 5 then 'Asignada'
       when   o.order_status_id = 8 then 'Legalizada'
       when  o.order_status_id = 11 then 'Bloqueada'
       when  o.order_status_id = 12 then 'Anulada'
       when  o.order_status_id = 0 then 'Registrada'
       when  o.order_status_id = 7 then 'Ejecutada' end as "Estado",
       sesucicl "Ciclo",
       pf.pefacodi "Periodo_fact",
       otl.order_id "Orden lectura" ,otl.task_type_id "Tipo_trabajo" ,otl.legalization_date "Fecha_legalizacion_lect",
       pf.pefafimo "Fecha_inicial_fact",
       pf.pefaffmo "Fecha_fin_fact",
       pc.pecscons "Periodo_cons",
       pc.pecsfeci "Fecha_inicial_cons",
       pc.pecsfecf "Fecha_fin_cons"
from open.or_order o
inner join open.or_task_type t  on t.task_type_id =o.task_type_id
inner join  open.or_order_activity a on  o.order_id = a.order_id 
left join open.servsusc s on  a.subscription_id = s.sesususc 
left join open.perifact pf on pf.pefacicl = s.sesucicl and pefaano=2023 and pefames=2 
left join open.pericose pc on  pf.pefacicl = pc.pecscico and  pc.pecsfecf  between pf.pefafimo and pf.pefaffmo
left join  ( select o1.order_id ,o1.task_type_id ,o1.legalization_date, a1.subscription_id, a1.product_id
             from open.or_order o1 
             left join open.or_order_activity a1 on a1.order_id = o1.order_id 
             where  o1.task_type_id =12617
             and o1.order_status_id =8
             and o1.legalization_date >= '01/01/2023' ) otl on  otl.subscription_id=sesususc  and sesunuse = otl.product_id  and otl.legalization_date between pf.pefafimo and pf.pefaffmo  
where  o.task_type_id in (select task_type_id
                          from open.or_task_types_items ti, open.ge_items_attributes ia, open.ge_items i
                          where ia.items_id = ti.items_id
                          and ti.items_id = i.items_id
                          and attribute_1_id = 400022
                        and attribute_2_id = 400021)
and o.order_status_id in (0,5) 
and not exists ( select null from open.procejec c 
                where c.prejcope= pf.pefacodi
                and c.prejprog like '%FGCC%')
and exists ( select null from open.procejec c 
                where c.prejcope= pf.pefacodi
                and c.prejprog like '%FGCA%')
and exists ( select null 
            from open.or_order o2
            left join open.or_order_activity a2 on a2.order_id = o2.order_id 
            where a2.subscription_id = s.sesususc
            and   o2.task_type_id =12617
            and  o2.order_status_id =8
            and  o2.legalization_date between pf.pefafimo and pf.pefaffmo)
group by  sesususc, sesunuse , o.order_id ,  o.task_type_id,t.description , o.order_status_id, o.legalization_date,
sesucicl, pf.pefacodi,pf.pefafimo, pf.pefaffmo,pc.pecscons,pc.pecsfeci,pc.pecsfecf, otl.order_id  ,otl.task_type_id  ,otl.legalization_date 
