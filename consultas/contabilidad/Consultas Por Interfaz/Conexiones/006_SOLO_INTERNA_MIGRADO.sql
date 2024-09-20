-- Internas MIGRADAS
SELECT  /*+
            index (cargos, IX_CARGOS02)
            index (cuencobr, PK_CUENCOBR)
            index (ab_address, PK_AB_ADDRESS)
            index (servsusc, PK_SERVSUSC)
        */
      m.invmsesu, sesucate, invmconc, o.concdesc, 'DB', sum(invmvain), l.celocebe  
from open.Ldci_Ingrevemi m, open.servsusc s, open.ab_address, open.suscripc, open.ge_subscriber g,
     open.ldci_centbenelocal l, open.concepto o
where m.invmsesu in (SELECT DISTINCT OR_order_activity.product_id
                        FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                       WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                         AND OR_related_order.related_order_id = OR_order_activity.order_id
                         AND OR_order_activity.Status = 'F'
                         AND OR_order_activity.package_id = mo_packages.package_id
                         AND OR_order_activity.task_type_id in (10622, 10624)
                         AND mo_packages.package_type_id in (100271) 
                         AND OR_order.order_id = OR_related_order.related_order_id
                         AND OR_order.legalization_date >= '01-06-2015'
                         AND OR_order.legalization_date <  '01-07-2015')
AND m.invmsesu = s.sesunuse
AND sesususc = susccodi
AND suscclie = g.subscriber_id
AND g.address_id = ab_address.address_id
AND ab_address.geograp_location_id = l.celoloca AND invmconc = conccodi
AND m.invmconc in (30)
group by m.invmsesu, sesucate, invmconc, o.concdesc, 'DB', l.celocebe
