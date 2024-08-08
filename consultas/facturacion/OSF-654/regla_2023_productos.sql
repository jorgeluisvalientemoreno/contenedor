select  a.product_id ,sesuesco,sesuesfn ,product_status_id, sesucate, sesusuca,
(select count ( distinct (o2.order_id)) from open.or_order o2, open.or_order_activity a2
           where o2.order_id = a2.order_id 
           and  a2.product_id = a.product_id
             and a2.task_type_id in (10764, 11045, 11260, 11094, 10526, 10527, 10075, 10528, 10074, 10534, 10720, 10933, 12143, 10951, 11027)
           and o2.order_status_id in (0,5select a.order_id , status,a.product_id, o.order_status_id , r.task_type_id , r.description , a.register_date, a.value1 ,o.legalization_date , o.exec_initial_date, o.execution_final_date
from or_order_activity a
LEFT JOIN OR_ORDER O ON O.ORDER_ID = A.ORDER_ID
left join or_task_type r on r.task_type_id = a.task_type_id
where  a.product_id in ( 52461652)
and status ='R'
 order by register_date desc)
           and o2.created_date<'01/03/2023' )ot_pend_CM,i.value1,i.value2,substrc( i.value1,9,4) lectura,      
a.order_id||'|'||8017||'|'||'38963||'||a.order_activity_id||'>'||'1'||';'||  regexp_substr( i.value1,'READING>[^>]*')||'>>'||';;;'||'|||'||'1277'||';OSF-654|'||
substrc ( i.exec_initial_date,1,19) ||';'|| substrc ( i.execution_final_date,1,19) as cadena_legalizacion
from open.or_order r
left join open.or_order_activity a  on a.order_id = r.order_id 
left join open.servsusc on a.product_id = sesunuse
left join open.pericose p on sesucicl = p.pecscico
left join open.pr_product pr on pr.product_id = sesunuse and pr.subscription_id = sesususc 
left join open.infopl_654 i on i.cosssesu = a.product_id and i.task_type_id = 10043
where sesucicl  in (1201)
and pecscons =101983
and r.task_type_id in (10043)
and r.order_status_id  in (5)
and i.cosscavc = 2023   
order by r.legalization_date desc