-- INGRESo Internas..
select m.invmsesu, m.invmconc, c.concdesc, m.invmvain
  from open.Ldci_Ingrevemi M, open.concepto c
 where m.invmsesu in (SELECT DISTINCT  OR_order_activity.product_id
                        FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                       WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                         AND OR_related_order.related_order_id = OR_order_activity.order_id
                         AND OR_order_activity.Status = 'F'
                         AND OR_order_activity.package_id = mo_packages.package_id
                         AND OR_order_activity.task_type_id in (10622, 10624)
                         AND mo_packages.package_type_id in (323, 100271) 
                         AND OR_order.order_id = OR_related_order.related_order_id
                         AND OR_order.legalization_date >= '09-02-2015'
                         AND OR_order.legalization_date <  '01-03-2015')
    AND invmconc = 30
    AND m.invmconc = c.conccodi     
