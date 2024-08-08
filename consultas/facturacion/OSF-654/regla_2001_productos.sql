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
           and da.name_1 like '%Lectura%'
           and da.value_1 is not null 
           and o3.legalization_date > (sysdate - 180))ot_vis_conlect,
 (select count ( distinct (o4.order_id)) from open.or_order o4, open.or_order_activity a4,ge_causal ge2,or_requ_Data_value da2 
           where o4.order_id = a4.order_id 
           and  a4.product_id = a.product_id
           and o4.causal_id = ge2.causal_id 
           and  da2.order_id = o4.order_id
           and a4.activity_id in (4000980)
           and o4.order_status_id in (8)
           and o4.legalization_date > (sysdate - 180)  )ot_vis_menos_6 ,i.value1,i.value2,substrc( i.value2,10,2) ONL,      
a.order_id||'|'||9688||'|'||'38963||'||a.order_activity_id||'>'||'1'||';'||  regexp_substr( i.value2,'COMMENT1>[^>]*')||'>>'||';;;'||'|||'||'1277'||';OSF-654|'||
substrc ( i.exec_initial_date,1,19) ||';'|| substrc ( i.execution_final_date,1,19) as cadena_legalizacion
from open.or_order r
left join open.or_order_activity a  on a.order_id = r.order_id 
left join open.servsusc on a.product_id = sesunuse
left join open.pericose p on sesucicl = p.pecscico
left join open.pr_product pr on pr.product_id = sesunuse and pr.subscription_id = sesususc 
left join open.infopl_654 i on i.cosssesu = a.product_id and i.task_type_id = 12617
where sesucicl  in (1201)
and pecscons =101983
and r.task_type_id in (12617)
and r.order_status_id not in (8,12)
and i.cosscavc = 2001      
order by r.legalization_date desc