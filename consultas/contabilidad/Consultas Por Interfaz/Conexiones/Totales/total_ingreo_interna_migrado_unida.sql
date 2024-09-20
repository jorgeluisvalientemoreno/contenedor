-- Internas MIGRADAS
SELECT m.invmsesu, invmconc, o.concdesc, sum(invmvain)
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
                         AND OR_order.legalization_date >= '01-08-2015'
                         AND OR_order.legalization_date <  '01-09-2015')
AND m.invmsesu = s.sesunuse
AND sesususc = susccodi
AND suscclie = g.subscriber_id
AND g.address_id = ab_address.address_id
AND ab_address.geograp_location_id = l.celoloca AND invmconc = conccodi
AND m.invmconc in (30,291)
Group by m.invmsesu, invmconc, o.concdesc
union  --all
SELECT m.invmsesu, invmconc, o.concdesc,sum(invmvain) total
from open.Ldci_Ingrevemi m, open.servsusc s, open.ab_address, open.suscripc, open.ge_subscriber g,
     open.ldci_centbenelocal l, open.concepto o
where m.invmsesu in (SELECT distinct hcecnuse
                       FROM open.hicaesco h
                      WHERE hcececan =  96
                        AND hcececac =  1
                        AND hcecserv =  7014
                        AND hcecfech >= '01-08-2015' and hcecfech < '01-09-2015')
AND m.invmsesu = s.sesunuse
AND sesususc = susccodi
AND suscclie = g.subscriber_id
AND g.address_id = ab_address.address_id
AND ab_address.geograp_location_id = l.celoloca AND invmconc = conccodi
and m.invmconc in (30)
group by m.invmsesu, invmconc, o.concdesc
