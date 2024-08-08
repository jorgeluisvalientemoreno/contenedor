    
    SELECT o.causal_id, o.order_status_id, status, o2.causal_id, o2.order_status_id, count(1) cant
--description,  o.order_id, status, o.task_type_id,DECODE(status, 'P', 'Pendiente', 'E', 'Excluido','R','PROYECTO', 'F','PNO DETECTADA','N','Ninguna PNO detectada') estado, o.causal_id, order_status_id , c.description,legalization_date 
FROM open.ge_causal c, open.FM_POSSIBLE_NTL p, open.or_order o, open.or_related_order r, open.or_order o2
WHERE  p.order_id = o.order_id AND r.order_id(+) = p.order_id AND o.task_type_id = 12672 AND o2.order_id = r.related_order_id AND o2.task_type_id = 10312
AND c.causal_id = o.causal_id
GROUP BY o.causal_id, o.order_status_id, status, o2.causal_id, o2.order_status_id;
;

SELECT o.causal_id, o.order_status_id, status, o2.causal_id, o2.order_status_id, count(1) cant
--description,  o.order_id, status, o.task_type_id,DECODE(status, 'P', 'Pendiente', 'E', 'Excluido','R','PROYECTO', 'F','PNO DETECTADA','N','Ninguna PNO detectada') estado, o.causal_id, order_status_id , c.description,legalization_date 
FROM open.ge_causal c, open.FM_POSSIBLE_NTL p, open.or_order o, open.or_related_order r, open.or_order o2
WHERE  p.order_id = o.order_id AND r.order_id(+) = p.order_id AND o.task_type_id = 12672 AND o2.order_id = r.related_order_id AND o2.task_type_id = 10312
AND c.causal_id = o.causal_id
GROUP BY o.causal_id, o.order_status_id, status, o2.causal_id, o2.order_status_id;
;

SELECT *
FROM OPEN.OR_TASK_TYPE
WHERE TASK_TYPE_ID IN (12672, 10312 )
