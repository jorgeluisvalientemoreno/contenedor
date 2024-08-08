--validacion regla 2007
select  a.product_id ,sesuesco,sesuesfn ,product_status_id, sesucate, sesusuca,
(select count ( distinct (c1.cosspecs)) from open.conssesu c1 
           where c1.cosssesu = a.product_id 
           and c1.cosssesu = sesunuse 
           and c1.cosscoca = 0 
           and c1.cossfere between '01/09/2022' and '01/01/2023'
           and c1.cossmecc in (1,3) ) as cons_cero,
(select count ( distinct (o2.order_id)) from open.or_order o2, open.or_order_activity a2
           where o2.order_id = a2.order_id 
           and  a2.product_id = a.product_id
             and a2.activity_id in (4000044,4001237,4001238,4295392,4295470,100002357,
             100002508,100007648,100008476,100009421,100009422,100009447,100006618,
             100006989,100006990,100006330,100006982,100006983,100004199,100003638) 
           and o2.order_status_id in (0,5)
           and o2.created_date<'27/02/2023' )ot_pend_CM,substrc( a.value1,9,4) lectura ,
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
where sesucicl  in (1201)
and pecscons =101983
and r.task_type_id in (12617)
and r.order_status_id  in (8,12)
and r.legalization_date >= '28/02/2023 11:45:00' --CAMBIARRRRR
order by r.legalization_date desc