WITH INFO_QH AS (
select a1.product_id producto,
       a1.order_id ORDEN_QH,
       a1.order_activity_id order_activity_id_QH,
       r.task_type_id tipo,
       r.created_date,
       r.order_status_id
from open.or_order r
INNER join open.or_order_activity a1  on a1.order_id = r.order_id
INNER join open.servsusc on a1.product_id = sesunuse 
where sesucicl in (901) 
 and r.task_type_id in (12617)
and r.order_status_id  in (0,5)
),
INFO_PL AS (
SELECT a.product_id producto ,
       o.order_id ORDEN_PL ,
       ORDEN_QH,
       order_activity_id_QH,
       o.task_type_id,
       o.legalization_date,
       le.leemoble,
       le.leemleto,
       o.causal_id,
       a.value1,
       a.value2,
       o.exec_initial_date,
       o.execution_final_date,
       CASE WHEN a.value1 = 'READING>>>>'
            THEN ORDEN_QH||'|'||o.causal_id||'|'||'38963||'||order_activity_id_QH||'>1;'||
                 regexp_substr(a.value2,'COMMENT1>[^>]*')||'>>'||';;;'||'|||'||'1277'||';PRUEBA|'||
                 substrc(o.exec_initial_date,1,19)||';'||substrc(o.execution_final_date,1,19)
            ELSE ORDEN_QH||'|'||o.causal_id||'|'||'38963||'||order_activity_id_QH||'>1;'||
                 regexp_substr(a.value1,'READING>[^>]*')||'>>'||';;;'||'|||'||'1277'||';PRUEBA|'||
                 substrc(o.exec_initial_date,1,19)||';'||substrc(o.execution_final_date,1,19)
       END cadena_legalizacion
FROM open.or_order@osfpl o
JOIN open.or_order_activity@osfpl a on o.order_id = a.order_id
JOIN open.lectelme@osfpl le on a.product_id = le.leemsesu and le.leempecs = 135422
JOIN open.servsusc on sesunuse = a.product_id
LEFT JOIN INFO_QH on INFO_QH.producto = a.product_id  and INFO_QH.tipo= o.task_type_id
WHERE o.task_type_id IN (12617)
AND sesucicl = 901 
AND o.order_status_id = 8
AND le.leemclec = 'F'
AND o.legalization_date>= '23/04/2026'
)
select *
from info_pl 


