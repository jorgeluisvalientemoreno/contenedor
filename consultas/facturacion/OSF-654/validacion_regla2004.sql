select  a.product_id ,sesuesco,sesuesfn ,product_status_id, sesucate, sesusuca,
(select count ( distinct (c1.cosspecs)) from open.conssesu c1 
           where c1.cosssesu = a.product_id 
           and c1.cosssesu = sesunuse 
           and c1.cosscoca = 0 
           and c1.cosspecs between '100681' and '101581' 
           and c1.cossmecc in (1,3) ) as cons_cero,substrc( a.value2,10,2) ONL,
(select count ( distinct (o2.order_id)) from open.or_order o2, open.or_order_activity a2
           where o2.order_id = a2.order_id 
           and  a2.product_id = a.product_id
             and a2.activity_id in (4000980)
           and o2.order_status_id in (8)
           and o2.legalization_date >'24/01/2023' )as ot_leg_12,
(select count ( distinct (o3.order_id)) from open.or_order o3, open.or_order_activity a3
           where o3.order_id = a3.order_id 
           and  a3.product_id = a.product_id
           and a3.activity_id in (4000980)
           and o3.order_status_id in (0,5,7)
           and o3.created_date<'24/02/2023')  as ot_pend_onl_12  ,
(select count ( distinct (o4.order_id)) from open.or_order o4, open.or_order_activity a4
           where o4.order_id = a4.order_id 
           and  a4.product_id = a.product_id
             and a4.activity_id in (100009283)
           and o4.order_status_id in (8)
           and o4.legalization_date >'01/02/2023' )as ot_leg_38,
(select count ( distinct (o5.order_id)) from open.or_order o5, open.or_order_activity a5
           where o5.order_id = a5.order_id 
           and  a5.product_id = a.product_id
           and a5.activity_id in (100009283)
           and o5.order_status_id in (0,5,7)
           and o5.created_date<'24/02/2023')  as ot_pend_onl_38  ,
(select count ( distinct (o6.order_id)) from open.or_order o6, open.or_order_activity a6
           where o6.order_id = a6.order_id 
           and  a6.product_id = a.product_id
             and a6.activity_id in (4000031)
           and o6.order_status_id in (8)
           and o6.legalization_date >'24/01/2023' )as ot_leg_82,
(select count ( distinct (o7.order_id)) from open.or_order o7, open.or_order_activity a7
           where o7.order_id = a7.order_id 
           and  a7.product_id = a.product_id
           and a7.activity_id in (4000031)
           and o7.order_status_id in (0,5,7)
           and o7.created_date<'24/02/2023')  as ot_pend_onl_82  ,
(select count ( distinct (o8.order_id)) from open.or_order o8, open.or_order_activity a8
           where o8.order_id = a8.order_id 
           and  a8.product_id = a.product_id
             and a8.activity_id in (4000949)
           and o8.order_status_id in (8)
           and o8.legalization_date >'24/01/2023' )as ot_leg_64,
(select count ( distinct (o9.order_id)) from open.or_order o9, open.or_order_activity a9
           where o9.order_id = a9.order_id 
           and  a9.product_id = a.product_id
           and a9.activity_id in (4000949)
           and o9.order_status_id in (0,5,7)
           and o9.created_date<'24/02/2023')  as ot_pend_onl_64  ,
(select count ( distinct (o10.order_id)) from open.or_order o10, open.or_order_activity a10
           where o10.order_id = a10.order_id 
           and  a10.product_id = a.product_id
           and a10.activity_id in (4000031,4000949,4000971,4000972,4000973,4000980,4001237,4001238,100007144,100009032,100009033,100009034,100009035,100009039,100009152,100009153,100009154,100009155,100009277,
                                  100009278,100009279,100009280,100009281,100009421,100009422,100007375,100007376,100009156,100009157,100009154)
           and o10.order_status_id in (0,5,7)
           and o10.created_date <'24/02/2023') as ot_onl_8_pend , 
 (select count ( distinct (o11.order_id)) from open.or_order o11, open.or_order_activity a11
           where o11.order_id = a11.order_id 
           and  a11.product_id = a.product_id
           and a11.activity_id in (4000031,4000949,4000971,4000972,4000973,4000980,4001237,4001238,100007144,100009032,100009033,100009034,100009035,100009039,100009152,100009153,100009154,100009155,100009277,
                                  100009278,100009279,100009280,100009281,100009421,100009422,100007375,100007376,100009156,100009157,100009154)
           and o11.order_status_id in (8)
           and o11.legalization_date >'01/02/2023' ) as ot_onl_8_liq,            
(select count ( distinct (o12.order_id)) from open.or_order o12, open.or_order_activity a12
           where o12.order_id = a12.order_id 
           and  a12.product_id = a.product_id
           and o12.order_status_id in (0,5)
           and o12.created_date>'24/02/2023')  as ot_creadas_hoy  ,          
 (select c2.cosscoca  from open.conssesu c2
           where c2.cosssesu = a.product_id 
           and c2.cosssesu = sesunuse 
           and c2.cosspecs = 101983
           and c2.cossmecc in (1,3) ) cons_act,
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
and p.pecscons =101983
and r.task_type_id in (12617)
and r.order_status_id  in (8,12)
and r.legalization_date >'24/02/2023'
