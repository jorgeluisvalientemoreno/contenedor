with info_qh as (
    select a1.product_id producto,
           a1.order_id orden_qh,
           a1.order_activity_id order_activity_id_qh,
           r.task_type_id tipo,
           r.created_date,
           r.order_status_id
    from open.or_order r
    inner join open.or_order_activity a1 on a1.order_id = r.order_id
    inner join open.servsusc s on a1.product_id = s.sesunuse
    where s.sesucicl in (&ciclo)
      and r.task_type_id in (&tipo_trab)
      and r.order_status_id in (0,5)
),

info_pl as (
    select a.product_id producto,
           o.order_id orden_pl,
           orden_qh,
           order_activity_id_qh,
           o.task_type_id,
           o.legalization_date,
           pe.pecscons,
           a.value1,
           a.value2,
           o.exec_initial_date,
           o.execution_final_date,
           CASE 
               WHEN a.value1 = 'READING>>>>'
               THEN orden_qh||'|'||o.causal_id||'|'||'38963||'||order_activity_id_qh||'>1;'||
                    regexp_substr(a.value2,'COMMENT1>[^>]*')||'>>'||';;;'||'|||'||'1277'||';PRUEBA|'||
                    substrc(o.exec_initial_date,1,19)||';'||substrc(o.execution_final_date,1,19)
               ELSE orden_qh||'|'||o.causal_id||'|'||'38963||'||order_activity_id_qh||'>1;'||
                    regexp_substr(a.value1,'READING>[^>]*')||'>>'||';;;'||'|||'||'1277'||';PRUEBA|'||
                    substrc(o.exec_initial_date,1,19)||';'||substrc(o.execution_final_date,1,19)
           END cadena_legalizacion
    from open.or_order@osfpl o
    join open.or_order_activity@osfpl a on o.order_id = a.order_id
    join open.servsusc s   on s.sesunuse = a.product_id 
    join open.pericose pe   on pe.pecscico = s.sesucicl and pe.pecsproc='S' and pe.pecsflav='N'
    left join info_qh  on info_qh.producto = a.product_id and info_qh.tipo = o.task_type_id
    where o.task_type_id in (&tipo_trab)
      and s.sesucicl in (&ciclo)
      and o.order_status_id = 8
      and o.legalization_date >= to_date('23/04/2026','dd/mm/yyyy')
)
select *
from info_pl;
