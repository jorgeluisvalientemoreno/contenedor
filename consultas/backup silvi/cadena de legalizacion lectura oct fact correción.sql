SELECT sesunuse, 
       sesucicl
       ac.legalization_date,
       ac.task_type_id,
       ac.order_id,
       ac.value1 ,
       ac.value2 ,
       ac.exec_initial_date , 
       ac.execution_final_date,
CASE WHEN ac.value1 = 'READING>>>>' then a.order_id||'|'||9688||'|'||'38963||'||a.order_activity_id||'>'||'1'||';'|| regexp_substr( ac.value2,'COMMENT1>[^>]*')||'>>'||';;;'||'|||'||'1277'||';PRUEBA|'||substrc ( i.exec_initial_date,1,19) ||';'|| substrc ( i.execution_final_date,1,19)
     ELSE  a.order_id||'|'||9688||'|'||'38963||'||a.order_activity_id||'>'||'1'||';'||  regexp_substr( ac.value1,'READING>[^>]*')||'>>'||';;;'||'|||'||'1277'||';PRUEBA|'||substrc ( i.exec_initial_date,1,19) ||';'|| substrc ( i.execution_final_date,1,19) END as cadena_legalizacion
from  open.or_order  r 
inner join open.or_order_activity a on  a.order_id = r.order_id 
inner join open.servsusc s on a.product_id = s.sesunuse 
inner join open.perifact p on p.pefacicl = sesucicl and p.pefaano=2025 and p.pefames=10 
left join( select o.order_id, o.task_type_id, o.legalization_date, a.product_id, a.value1, a.value2 ,o.exec_initial_date  , o.execution_final_date
           from open.or_order_activity@osfpl a
           inner join open.or_order@osfpl o on o.order_id=a.order_id
           and o.task_type_id in (12617, 10043)
          ) ac  on ac.product_id=sesunuse and to_char(ac.legalization_date,'dd/mm/yyyy hh24:mi')= to_char(p.pefaffmo,'dd/mm/yyyy hh24:mi')
where r.task_type_id in (12617)
and r.order_status_id  in (0,5)  
