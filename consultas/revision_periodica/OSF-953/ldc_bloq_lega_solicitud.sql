select ot.task_type_id,
       b.package_id_orig, 
       b.package_id_gene,
       ot.order_id,
       ot.order_status_id
  from ldc_bloq_lega_solicitud b
 inner join or_order_activity  a  on a.package_id = b.package_id_gene
 inner join or_order  ot on ot.order_id = a.order_id and ot.order_status_id = 0
   and  exists (select null
          from personalizaciones.ldc_logerrleorresu l
         where l.order_id = ot.order_id)

