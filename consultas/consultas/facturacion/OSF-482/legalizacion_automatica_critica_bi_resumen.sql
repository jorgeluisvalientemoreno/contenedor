select c.flagprocesado,
       s.sesucicl,
       c.idperiodoconsumo,
       c.idreglacritica,
       o.task_type_id,
       t.description,
       o.order_status_id,
       o.operating_unit_id,
       o.causal_id,
       co.order_comment,
       count(distinct(c.idorden))
  from open.ldc_bi_proc_critica_consumo c
 left join open.or_order  o  on o.order_id = c.idorden
 left join open.or_order_comment  co  on co.order_id = c.idorden
 left join open.or_task_type  t  on t.task_type_id = o.task_type_id
 left join open.servsusc  s  on s.sesunuse = c.idproducto
 where c.idperiodoconsumo in (102007)
 --and   c.idreglacritica != 0
     group by c.flagprocesado,
          s.sesucicl,
          c.idperiodoconsumo,
          c.idreglacritica,
          o.task_type_id,
          t.description,
          o.order_status_id,
          o.operating_unit_id,
          o.causal_id,
          co.order_comment
 order by s.sesucicl desc, c.idreglacritica desc

