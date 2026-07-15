SELECT a.product_id,
       o.order_id ORDEN_PL ,
       a1.order_id ORDEN_QH,
       o.task_type_id,
       o.legalization_date,
       le.leemoble,
       le.leemleto,
       a.value1,
       a.value2,
       CASE WHEN a.value1 = 'READING>>>>'
            THEN a1.order_id||'|'||o.causal_id||'|'||'38963||'||a1.order_activity_id||'>1;'||
                 regexp_substr(a.value2,'COMMENT1>[^>]*')||'>>'||';;;'||'|||'||'1277'||';PRUEBA|'||
                 substrc(o.exec_initial_date,1,19)||';'||substrc(o.execution_final_date,1,19)
            ELSE a1.order_id||'|'||o.causal_id||'|'||'38963||'||a1.order_activity_id||'>1;'||
                 regexp_substr(a.value1,'READING>[^>]*')||'>>'||';;;'||'|||'||'1277'||';PRUEBA|'||
                 substrc(o.exec_initial_date,1,19)||';'||substrc(o.execution_final_date,1,19)
       END cadena_legalizacion
FROM open.or_order@osfqa o
JOIN open.or_order_activity@osfqa a on o.order_id = a.order_id
JOIN open.lectelme@osfqa le on a.product_id = le.leemsesu and le.leempecs = 135422
JOIN open.pericose pe on pe.pecscons = le.leempecs
JOIN open.or_order_activity a1 on a1.product_id= a.product_id and a1.task_type_id= a.task_type_id and a1.status='R' 
WHERE o.task_type_id IN (10043,12617)
AND o.order_status_id = 8
AND le.leemclec = 'F'
AND trunc(o.legalization_date) =  trunc(pe.pecsfecf);
