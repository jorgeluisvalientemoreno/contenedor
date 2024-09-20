-- INGRESOS MIGRADOS - Ultima consulta
select 'Ing_Mig' Tipo, invmsesu, sesucate, invmconc, concdesc, sum(Total) Total, sum(reportada) reportada, (sum(Total) - sum(nvl(reportada,0))) Contabilizar, celocebe
  from (
          SELECT  /*+
                      index (cargos, IX_CARGOS02)
                      index (ab_address, PK_AB_ADDRESS)
                      index (servsusc, PK_SERVSUSC)
                  */
                  m.invmsesu, sesucate, invmconc, o.concdesc, 'DB', sum(invmvain) total,
                  (SELECT sum(invmvain)
                     from open.Ldci_Ingrevemi x
                    where x.invmsesu = m.invmsesu
                      and x.invmsesu in (SELECT DISTINCT  OR_order_activity.product_id
                                              FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                                             WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                                               AND OR_related_order.related_order_id = OR_order_activity.order_id
                                               AND OR_order_activity.Status = 'F'
                                               AND OR_order_activity.package_id = mo_packages.package_id
                                               AND OR_order.task_type_id in (10622, 10624)
                                               AND mo_packages.package_type_id in (100271)
                                               AND OR_order.legalization_date >= '09-02-2015' -- FECHA FIJA
                                               AND OR_order.legalization_date <= '&Fecha_Final 23:59:59'
                                               AND OR_order.order_id = OR_related_order.related_order_id
                                               AND OR_order.CAUSAL_ID IN (select c.causal_id from open.ge_causal c where c.class_causal_id = 1)
                                               AND OR_order_activity.product_id in (SELECT distinct hcecnuse
                                                                                    FROM   open.hicaesco h
                                                                                    WHERE hcecfech >= '&Fecha_Inicial'
                                                                                    AND   hcecfech <= '&Fecha_Final 23:59:59'
                                                                                    AND   hcecnuse = OR_order_activity.product_id
                                                                                    AND   hcececan = 96
                                                                                    AND   hcececac = 1
                                                                                    AND   hcecserv = 7014)                                               )
                      AND x.invmconc = 30
                      AND x.invmconc = m.invmconc
                    group by x.invmsesu) Reportada,
                   l.celocebe
          from open.Ldci_Ingrevemi m, open.servsusc s, open.ab_address, open.suscripc, open.ge_subscriber g,
               open.ldci_centbenelocal l, open.concepto o
          where m.invmsesu in (SELECT distinct hcecnuse
                                 FROM open.hicaesco h
                                WHERE hcececan = 96
                                  AND hcececac = 1
                                  AND hcecserv = 7014
                                  AND hcecfech >= '&Fecha_Inicial' and hcecfech <= '&Fecha_Final 23:59:59')
          AND m.invmsesu = s.sesunuse
          AND sesususc = susccodi
          AND suscclie = g.subscriber_id
          AND g.address_id = ab_address.address_id
          AND ab_address.geograp_location_id = l.celoloca AND invmconc = conccodi
         group by m.invmsesu, sesucate, invmconc, o.concdesc, 'DB', l.celocebe
         ORDER BY INVMSESU, INVMCONC
      )

group by invmsesu, sesucate, invmconc, concdesc, 'DB', celocebe
order by sesucate, celocebe, invmconc
