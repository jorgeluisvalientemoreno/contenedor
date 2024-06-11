select c.idperiodoconsumo,
       s.sesucicl,
       c.idproducto,
       o.task_type_id,
       t.description,
       c.idorden,
       o.order_status_id,
       o.operating_unit_id,
       c.consumo,
       c.idreglacritica,
       c.reglacritica,
       c.flagprocesado,
       c.msgerror
  from open.ldc_bi_proc_critica_consumo c
 inner join open.or_order  o  on o.order_id = c.idorden
 inner join open.or_task_type  t  on t.task_type_id = o.task_type_id
 inner join open.servsusc  s  on s.sesunuse = c.idproducto
