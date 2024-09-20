SELECT OR_order_activity.*
  FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
 WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
   AND OR_related_order.related_order_id = OR_order_activity.order_id
   AND OR_order_activity.Status = 'F'
   AND OR_order_activity.package_id = mo_packages.package_id
--   AND OR_order_activity.task_type_id in (10622, 10624)
   AND mo_packages.package_type_id in (323, 100229) 
   AND OR_order.order_id = OR_related_order.related_order_id
   AND OR_order.legalization_date >= '09-02-2015' AND OR_order.legalization_date < '01-04-2015'
   AND OR_order_activity.product_id in (select cargnuse from open.cargos c, open.servsusc s
                                         where c.cargnuse = sesunuse 
                                           and sesuserv = 6121
                                           and cargfecr >= '09-02-2015' and cargfecr < '01-04-2015'
                                           and cargdoso like 'PP%'
                                           and cargconc in (19,30,674))
