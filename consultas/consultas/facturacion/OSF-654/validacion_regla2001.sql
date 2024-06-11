select  a.product_id ,sesuesco,sesuesfn ,product_status_id, sesucate, sesusuca,
(select count ( distinct (o2.order_id)) from open.or_order o2, open.or_order_activity a2
           where o2.order_id = a2.order_id 
           and  a2.product_id = a.product_id
             and a2.activity_id in (4000980)
           and o2.order_status_id in (0,5)
           and o2.created_date<'24/02/2023' )ot_leg_vist_pend,
 (select count ( distinct (o3.order_id)) from open.or_order o3, open.or_order_activity a3,ge_causal ge1,or_requ_Data_value da 
           where o3.order_id = a3.order_id 
           and  a3.product_id = a.product_id
           and o3.causal_id = ge1.causal_id 
           and  da.order_id = o3.order_id
           and a3.activity_id in (4000980)
           and o3.order_status_id in (8)
           and ge1.class_causal_id =1 
           and da.name_1 LIKE '%Lectura%'
           and da.value_1 is not null 
           and o3.legalization_date > (sysdate - 180))ot_vis_conlect,
 (select count ( distinct (o4.order_id)) from open.or_order o4, open.or_order_activity a4,ge_causal ge2,or_requ_Data_value da2 
           where o4.order_id = a4.order_id 
           and  a4.product_id = a.product_id
           and o4.causal_id = ge2.causal_id 
           and  da2.order_id = o4.order_id
           and a4.activity_id in (4000980)
           and o4.order_status_id in (8)
           and o4.legalization_date > (sysdate - 180)  )ot_vis_menos_6 ,substrc( a.value2,10,2) ONL,
(select count ( distinct (o12.order_id)) from open.or_order o12, open.or_order_activity a12
           where o12.order_id = a12.order_id 
           and  a12.product_id = a.product_id
           and o12.order_status_id in (0,5)
           and o12.created_date>'27/02/2023')  as ot_creadas_hoy  ,   
(select o13.task_type_id from open.or_order o13, open.or_order_activity a13
           where o13.order_id = a13.order_id 
           and  a13.product_id = a.product_id
           and o13.order_status_id in (0,5)
           and o13.created_date>'27/02/2023')  as ot_task_type  ,    
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
and pecscons =101983
and r.task_type_id in (12617)
and r.order_status_id  in (8,12)  
and r.legalization_date >= '27/02/2023'
order by r.legalization_date desc
