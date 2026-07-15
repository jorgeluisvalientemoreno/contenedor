declare
cursor cuDatos is
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
      and r.order_status_id in (5)
      AND ROWNUM<=1
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
           to_Date(o.exec_initial_date,'dd/mm/yyyy hh24:mi:ss') exec_initial_date,
          to_Date(o.execution_final_date,'dd/mm/yyyy hh24:mi:ss') execution_final_date,
           CASE
               WHEN a.value1 = 'READING>>>>'
               THEN orden_qh||'|'||o.causal_id||'|'||'38963||'||order_activity_id_qh||'>1;'||
                    regexp_substr(a.value2,'COMMENT1>[^>]*')||'>>'||';;;'||'|||'||'1277'||';PRUEBA'
               ELSE orden_qh||'|'||o.causal_id||'|'||'38963||'||order_activity_id_qh||'>1;'||
                    regexp_substr(a.value1,'READING>[^>]*')||'>>'||';;;'||'|||'||'1277'||';PRUEBA'
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
      AND LEGALIZATION_DATE BETWEEN PE.PECSFECI AND PE.PECSFECF 
      AND PE.PECSCONS=135665
)
select *
from info_pl;

nuError number;
sbError varchar2(4000);
begin
     for reg in cuDatos loop
       nuError := 0;
       sbError := null;
       api_legalizeOrders(
            reg.cadena_legalizacion,
            reg.exec_initial_date,
            reg.execution_final_date,
            NULL,
            nuerror,
            sberror
        );

         dbms_output.put_line(reg.cadena_legalizacion);
        IF nuerror = 0 THEN
            dbms_output.put_line('OK [' || reg.orden_qh || ']');
            COMMIT;
        ELSE
            dbms_output.put_line('ERROR [' || reg.orden_qh || '] - ' || sberror);
        END IF;
     end loop;
     commit;
end;
