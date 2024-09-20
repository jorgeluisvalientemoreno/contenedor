select m.*,
      (SELECT m.invmvato --DISTINCT  OR_order_activity.product_id
          FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
         WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
           AND OR_related_order.related_order_id = OR_order_activity.order_id
           AND OR_order_activity.Status = 'F'
           AND OR_order_activity.package_id = mo_packages.package_id
           AND OR_order_activity.task_type_id in (10622, 10624)
           AND mo_packages.package_type_id in (100271)
           AND OR_order.legalization_date >= '09-02-2015'
           AND OR_order.legalization_date <  '01-06-2015'
           AND OR_order.order_id = OR_related_order.related_order_id
           AND OR_order_activity.product_id = M.INVMSESU
           and m.invmconc = 30
           and rownum = 1) Reportado
  from open.Ldci_Ingrevemi m
 where m.invmsesu not in (SELECT distinct hcecnuse FROM open.hicaesco h
                          WHERE hcececan = 96
                            AND hcececac = 1
                            AND hcecserv = 7014
                            AND hcecfech >= '09-02-2015' and hcecfech < '01-06-2015')
