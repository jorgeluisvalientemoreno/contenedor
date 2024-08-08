--2007
select  a.product_id,sesuesco,sesuesfn ,product_status_id, sesucate, sesusuca,
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
           and o2.created_date<'28/02/2023' )ot_pend_CM,i.value1,i.value2,substrc( i.value1,9,4) lectura,      
a.order_id||'|'||9688||'|'||'38963||'||a.order_activity_id||'>'||'1'||';'||  regexp_substr( i.value1,'READING>[^>]*')||'>>'||';;;'||'|||'||'1277'||';OSF-654|'||
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
and i.cosscavc = 2007   
order by r.legalization_date desc