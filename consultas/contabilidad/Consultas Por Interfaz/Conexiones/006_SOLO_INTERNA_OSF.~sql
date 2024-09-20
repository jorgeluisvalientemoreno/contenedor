-- Internas OSF Legalizadas
select o.concdesc, product_id, (cargvalo/(select count(*) from open.or_order_activity
                                            where package_id = substr(c.cargdoso,4,8)
                                              and task_type_id = 12150)) Vr_Unitario
  from open.cargos c, open.concepto o, 
       (SELECT DISTINCT to_char(mo_packages.package_id) package_id, OR_order_activity.product_id 
          FROM open.OR_related_order, open.OR_order_activity, open.or_order, 
               open.mo_packages, open.ge_items i
         WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
           AND OR_related_order.related_order_id = OR_order_activity.order_id
           AND OR_order_activity.Status = 'F'
           AND OR_order_activity.package_id = mo_packages.package_id
           AND OR_order_activity.task_type_id in (10622, 10624)
           AND mo_packages.package_type_id in (323, 100229) 
           AND OR_order.order_id = OR_related_order.related_order_id
           AND OR_order.legalization_date >= '01-05-2015'
           AND OR_order.legalization_date <  '01-06-2015' -- Orden de apoyo
           AND OR_order_activity.Status = 'F') u
 where substr(cargdoso, 1, 2) = 'PP'
   and substr(cargdoso, 4, 8) = u.package_id
   and cargconc = o.conccodi
   and cargconc = 30
   
