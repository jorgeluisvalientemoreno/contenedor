select o.order_id orden,
       a.subscription_id contrato,
       a.product_id producto,
       o.task_type_id tipo_trabajo,
       o.order_status_id estado_orden,
       ll.exec_final_date fecha_ejecucion_final,
       to_char(trunc(sysdate - ll.exec_final_date)) dias_sin_legalizar,
       s.sesucate categoria,
       s.sesusuca subcategoria,
       o.operating_unit_id||' '||'-'||' '||u.name  unidad_operativa,
       u.contractor_id||' '||'-'||' '||c.nombre_contratista  contratista,
       ll.causal_id  causal,
       ll.legalizado
  from or_order o
 inner join or_order_activity  a  on a.order_id = o.order_id
 left join servsusc  s  on s.sesunuse = a.product_id
 left join or_operating_unit  u  on u.operating_unit_id = o.operating_unit_id
 left join ge_contratista  c  on c.id_contratista = u.contractor_id
 left join open.ldc_otlegalizar  ll  on ll.order_id  = o.order_id and ll.causal_id = 9944 and ll.legalizado = 'N'
 where o.task_type_id in
       (select to_number(column_value)
          from table(ldc_boutilities.SPLITstrings(dald_parameter.fsbGetValue_Chain('TT_CXC_SIN_LEG'), ',')))
   and o.order_status_id = 8
 and  to_char(trunc(sysdate - ll.exec_final_date)) >= 15
 and exists 
 (select null
 from  open.ldc_otlegalizar  ll2
 where ll2.order_id  = o.order_id )
 order by o.execution_final_date desc
