select  a.product_id ,sesuesco,sesuesfn ,product_status_id, sesucate, sesusuca
,i.value1,i.value2,substrc( i.value2,10,2) ONL,      
a.order_id||'|'||9688||'|'||'38963||'||a.order_activity_id||'>'||'1'||';'||  regexp_substr( i.value2,'COMMENT1>[^>]*')||'>>'||';;;'||'|||'||'1277'||';prueba|'||
substrc ( i.exec_initial_date,1,19) ||';'|| substrc ( i.execution_final_date,1,19) as cadena_legalizacion
from open.or_order r
left join open.or_order_activity a  on a.order_id = r.order_id 
left join open.servsusc on a.product_id = sesunuse
left join open.pericose p on sesucicl = p.pecscico
left join open.pr_product pr on pr.product_id = sesunuse and pr.subscription_id = sesususc 
left join open.infopl_654 i on i.cosssesu = a.product_id and i.task_type_id = 12617
where  r.task_type_id in (12617)   
order by r.legalization_date desc