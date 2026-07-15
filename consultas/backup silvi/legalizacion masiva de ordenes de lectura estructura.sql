select  a.product_id ,sesuesco,sesuesfn ,product_status_id, sesucate, sesusuca,i.value1,i.value2,substrc( i.value1,9,5) LECT,substrc( i.value2,9,3) ONL, a.order_id,
CASE WHEN i.value1 = 'READING>>>>' then a.order_id||'|'||9688||'|'||'38963||'||a.order_activity_id||'>'||'1'||';'|| regexp_substr( i.value2,'COMMENT1>[^>]*')||'>>'||';;;'||'|||'||'1277'||';OSF-2494|'||substrc ( i.exec_initial_date,1,19) ||';'|| substrc ( i.execution_final_date,1,19)
     ELSE  a.order_id||'|'||9688||'|'||'38963||'||a.order_activity_id||'>'||'1'||';'||  regexp_substr( i.value1,'READING>[^>]*')||'>>'||';;;'||'|||'||'1277'||';OSF-2494|'||substrc ( i.exec_initial_date,1,19) ||';'|| substrc ( i.execution_final_date,1,19)
end as cadena_legalizacion
from open.or_order r
left join open.or_order_activity a  on a.order_id = r.order_id 
left join open.servsusc on a.product_id = sesunuse
left join open.pericose p on sesucicl = p.pecscico
left join open.pr_product pr on pr.product_id = sesunuse and pr.subscription_id = sesususc 
left join open.infopl_654 i on i.cosssesu = a.product_id and i.task_type_id = 12617
where sesucicl  in (801)
and pecscons =107363
and r.task_type_id in (12617)
and r.order_status_id not in (8,12)  
order by r.legalization_date desc

--causal relectura 8017
--causal lectura 9688
/*
SELECT
  a.product_id,
  sesuesco,
  sesuesfn,
  product_status_id,
  sesucate,
  sesusuca,
  i.value1,
  i.value2,
  substrc(i.value2, 10, 2) AS ONL, substrc( i.value1,9,5) LECT, a.order_id,
  DECODE(
    i.value1,
    'READING>>>>',
       a.order_id || '|' || 9688 || '|' || 38963 || '||' || a.order_activity_id || '>' || 1 || ';' ||
      regexp_substr(i.value2, 'COMMENT1>[^>]*') || '>>' || ';;;' || '|||' || 1277 || ';OSF-2494|' ||
      substrc(i.exec_initial_date, 1, 19) || ';' || substrc(i.execution_final_date, 1, 19),
       a.order_id || '|' || 9688 || '|' || 38963 || '||' || a.order_activity_id || '>' || 1 || ';' ||
      regexp_substr(i.value1, 'READING>[^>]*') || '>>' || ';;;' || '|||' || 1277 || ';OSF-2494|' ||
      substrc(i.exec_initial_date, 1, 19) || ';' || substrc(i.execution_final_date, 1, 19)
  ) AS cadena_legalizacion
FROM open.or_order r
LEFT JOIN open.or_order_activity a ON a.order_id = r.order_id
LEFT JOIN open.servsusc ON a.product_id = sesunuse
LEFT JOIN open.pericose p ON sesucicl = p.pecscico
LEFT JOIN open.pr_product pr ON pr.product_id = sesunuse AND pr.subscription_id = sesususc
LEFT JOIN open.infopl_654 i ON i.cosssesu = a.product_id AND i.task_type_id = 12617
WHERE sesucicl IN (606)
AND pecscons = 107349
AND r.task_type_id IN (12617)
AND r.order_status_id NOT IN (8, 12) --and rownum<= 2
ORDER BY r.legalization_date DESC;*/
