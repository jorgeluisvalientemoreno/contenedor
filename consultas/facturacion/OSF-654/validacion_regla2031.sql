--2031
select  a.product_id,sesuesco,sesuesfn ,product_status_id,ab.geograp_location_id, sesucate, sesusuca, ROUND(r.execution_final_date - sesufein)  dias,
case when  (select count (cpsccons)
           from ldc_coprsuca co 
           where co.cpscubge = ab.geograp_location_id 
           and co.cpsccate = sesucate 
           and co.cpscsuca = sesusuca) > 0 then 'Tiene_prom_sub' 
    when ( select count (cpsccons)
          from ldc_coprsuca co 
          where co.cpscubge = ab.geograp_location_id 
          and co.cpsccate = sesucate 
          and co.cpscsuca = sesusuca ) = 0 then 'No_tiene_prom_sub' end as cons_sub,
case when (select count (hcppcons)
            from hicoprpm h1
            where h1.hcppsesu= sesunuse 
            and hcpppeco =  101581 ) > 0 then 'si_cpp' 
    when   (select count (hcppcons)
            from hicoprpm h1
            where h1.hcppsesu= sesunuse 
            and hcpppeco =  101581 ) = 0 then 'No_cpp' end as cons_pp , 
(select co1.cpsccoto / co1.cpscprod
           from ldc_coprsuca co1 
           where co1.cpscubge = ab.geograp_location_id 
           and co1.cpsccate = sesucate 
           and co1.cpscsuca = sesusuca
           and co1.cpscanco = 2022
           and co1.cpscmeco = 9 ) as cpps,
substrc(substrc( a.value1,9,4),1,2) lectura,
(select leemlean Lectura_ant
         from open.lectelme l1 
         where l1.leemsesu =  sesunuse
         and l1.leempecs = pecscons
         and l1.leemfela = (select (max(l2.leemfela)) from lectelme l2 where l1.leemsesu = l2.leemsesu  )) lect_ant,
(select count ( distinct (o12.order_id)) from open.or_order o12, open.or_order_activity a12
           where o12.order_id = a12.order_id 
           and  a12.product_id = a.product_id
           and o12.order_status_id in (0,5)
           and o12.created_date>'28/02/2023')  as ot_creadas_hoy  ,   
(select o13.task_type_id from open.or_order o13, open.or_order_activity a13
           where o13.order_id = a13.order_id 
           and  a13.product_id = a.product_id
           and o13.order_status_id in (0,5)
           and o13.created_date>'28/02/2023')  as ot_task_type  ,    
 (select c2.cosscoca  from open.conssesu c2
           where c2.cosssesu = a.product_id 
           and c2.cosssesu = sesunuse 
           and c2.cosspecs = 101983
           and c2.cossmecc in (1,3) ) cons_act,
(select c5.cossmecc  from open.conssesu c5
           where c5.cosssesu = a.product_id 
           and c5.cosssesu = sesunuse 
           and c5.cosspecs = 101983
           and c5.cossmecc in (1,3)) metodo,
(select c3.cosscavc  from open.conssesu c3
           where c3.cosssesu = a.product_id 
           and c3.cosssesu = sesunuse 
           and c3.cosspecs = 101983
           and c3.cossmecc in (1,3)) regla,
(select c4.cossfufa   from open.conssesu c4
           where c4.cosssesu = a.product_id 
           and c4.cosssesu = sesunuse 
           and c4.cosspecs = 101983
           and c4.cossmecc in (1,3)) funcion_cons 
from open.or_order r
left join open.or_order_activity a  on a.order_id = r.order_id 
left join open.servsusc on a.product_id = sesunuse
left join open.pericose p on sesucicl = p.pecscico
left join open.pr_product pr on pr.product_id = sesunuse and pr.subscription_id = sesususc 
left join open.ab_address ab on  pr.address_id = ab.address_id 
left join open.hicoprpm on hcppsesu = a.product_id and  hcppsesu = sesunuse 
where sesucicl  in (1201)
and pecscons =101983
and r.task_type_id in (12617)
and r.order_status_id  in (8)
and r.legalization_date >= '28/02/2023 17:00:00'
order by r.legalization_date desc