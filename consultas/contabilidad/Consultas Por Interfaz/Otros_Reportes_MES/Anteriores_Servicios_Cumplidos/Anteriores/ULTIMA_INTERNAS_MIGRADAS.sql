-- Internas MIGRADAS
SELECT 'Int_Mig' Tipo, m.invmsesu, sesucate, invmconc, o.concdesc, sum(invmvain), 0 reportada, sum(invmvain) contabilizar, l.celocebe  
  from open.Ldci_Ingrevemi m, open.servsusc s, open.ab_address, open.suscripc, open.ge_subscriber g,
       open.ldci_centbenelocal l, open.concepto o
where m.invmsesu in (SELECT DISTINCT OR_order_activity.product_id
                        FROM open.OR_related_order, open.OR_order_activity, open.or_order , open.mo_packages
                       WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                         AND OR_related_order.related_order_id = OR_order_activity.order_id
                         AND OR_order_activity.Status = 'F'
                         AND OR_order_activity.package_id = mo_packages.package_id
                         AND or_order.task_type_id in (10622, 10624)
                         AND mo_packages.package_type_id in (100271) 
                         AND OR_order.order_id = OR_related_order.related_order_id
                         AND OR_order.legalization_date >= '&Fecha_Inicial'          -- FECHA INICIAL
                         AND OR_order.legalization_date <= '&Fecha_Final 23:59:59'
                         AND OR_order.CAUSAL_ID IN (select c.causal_id from open.ge_causal c where c.class_causal_id = 1)
                    AND OR_order_activity.product_id not in (select act.product_id 
                                                              from open.or_order_activity act, open.or_order oo
                                                             where act.product_id = OR_order_activity.product_id
                                                               and oo.task_type_id in (10622, 10624)
                                                               and act.order_id = oo.order_id
                                                               and oo.legalization_date < '&Fecha_Inicial')
                         AND OR_order_activity.product_id not in (SELECT distinct hcecnuse
                                                                    FROM open.hicaesco h
                                                                   WHERE hcececan = 96
                                                                     AND hcececac = 1
                                                                     AND hcecserv = 7014
                                                                     AND hcecfech < '&Fecha_Inicial'))  -- FECHA FINAL
AND m.invmsesu = s.sesunuse
AND sesususc = susccodi
AND suscclie = g.subscriber_id
AND g.address_id = ab_address.address_id
AND ab_address.geograp_location_id = l.celoloca AND invmconc = conccodi
AND m.invmconc in (30)
Group by m.invmsesu, sesucate, invmconc, o.concdesc, 'DB', l.celocebe

