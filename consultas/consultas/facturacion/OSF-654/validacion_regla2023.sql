--validacion regla 2023
select  a.product_id ,sesuesco,sesuesfn ,product_status_id, sesucate, sesusuca,
(select count ( distinct (o2.order_id)) from open.or_order o2, open.or_order_activity a2
           where o2.order_id = a2.order_id 
           and  a2.product_id = a.product_id
             and a2.task_type_id in (10764, 11045, 11260, 11094, 10526, 10527, 10075, 10528, 10074, 10534, 10720, 10933, 12143, 10951, 11027)
           and o2.order_status_id in (0,5)
           and o2.created_date<'01/03/2023' )ot_pend_CM,
substrc( a.value1,9,4) lectura ,
(select count ( distinct (o12.order_id)) from open.or_order o12, open.or_order_activity a12
           where o12.order_id = a12.order_id 
           and  a12.product_id = a.product_id
           and o12.order_status_id in (0,5)
           and o12.created_date>'01/03/2023')  as ot_creadas_hoy  ,
(select round(co1.cpsccoto / co1.cpscprod , 2)
           from ldc_coprsuca co1
           where co1.cpscubge = ab.geograp_location_id
           and co1.cpsccate = sesucate
           and co1.cpscsuca = sesusuca
           and co1.cpscanco = 2022
           and co1.cpscmeco = 9 ) as cpps,
(select hicoprpm.hcppcopr cons_promedio
           from open.hicoprpm
           where hicoprpm.hcppsesu  = sesunuse 
           and hcpppeco = 101581 ) as cpp,
(select h2.hcppcopr * 4 cons_promedio
           from open.hicoprpm h2
           where h2.hcppsesu  = sesunuse 
           and h2.hcpppeco = 101581 ) as cpp_limt ,
 (select c2.cosscoca  from open.conssesu c2
           where c2.cosssesu = a.product_id 
           and c2.cosssesu = sesunuse 
           and c2.cosspecs = 101983
           and c2.cossmecc in (1,3)
           and c2.cossfere = (select (max(c1.cossfere)) from conssesu c1 where  c2.cosssesu = c1.cosssesu) ) cons_act,
(select c5.cossmecc  from open.conssesu c5
           where c5.cosssesu = a.product_id 
           and c5.cosssesu = sesunuse 
           and c5.cosspecs = 101983
           and c5.cossmecc in (1,3)
           and c5.cossfere = (select (max(c6.cossfere)) from conssesu c6 where  c5.cosssesu = c6.cosssesu) ) metodo,
(select c3.cosscavc  from open.conssesu c3
           where c3.cosssesu = a.product_id 
           and c3.cosssesu = sesunuse 
           and c3.cosspecs = 101983
           and c3.cossmecc in (1,3)
           and c3.cossfere = (select (max(c7.cossfere)) from conssesu c7 where  c7.cosssesu = c3.cosssesu) ) regla,
(select c4.cossfufa   from open.conssesu c4
           where c4.cosssesu = a.product_id 
           and c4.cosssesu = sesunuse 
           and c4.cosspecs = 101983
           and c4.cossmecc in (1,3)
           and c4.cossfere = (select (max(c8.cossfere)) from conssesu c8 where  c8.cosssesu = c4.cosssesu)) funcion_cons            
from open.or_order r
left join open.or_order_activity a  on a.order_id = r.order_id 
left join open.servsusc on a.product_id = sesunuse
left join open.pericose p on sesucicl = p.pecscico
left join open.pr_product pr on pr.product_id = sesunuse and pr.subscription_id = sesususc 
left join open.ab_address ab on  pr.address_id = ab.address_id 
where sesucicl  in (1201)
and pecscons =101983
and r.task_type_id in (10043)
and r.order_status_id  in (8,12)
and r.legalization_date >= '01/01/2023 12:00:00'
and a.product_id in (1045737,50192086,50580737,1062256,1109881,50581992)  --CAMBIARRRRR
order by r.legalization_date desc