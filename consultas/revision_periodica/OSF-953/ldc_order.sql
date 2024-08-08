select ot.task_type_id,
       o.order_id,
       o.package_id,
       ot.order_status_id,
       o.asignacion,
       o.asignado,
       o.ordeobse,
       o.ordefere,
       o.ordefebl,
       o.ordebloq
  from ldc_order o
 inner join or_order  ot on ot.order_id = o.order_id and ot.order_status_id = 0
   and ot.order_status_id = 0
 where o.ordebloq = 'S'
   and o.asignado = 'N'
   and  exists (select null
          from personalizaciones.ldc_logerrleorresu l
         where l.order_id = o.order_id)
