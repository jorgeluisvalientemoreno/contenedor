select tipo, producto, xx.sesucate, concclco, conc, concdesc, Total, 
       (select l.celocebe 
          from open.GE_GEOGRA_LOCATION t, open.ldci_centbenelocal l
         where geograp_location_id = (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS
                                       where address_id = susciddi)
           and t.geo_loca_father_id = l.celodpto 
           and t.geograp_location_id = celoloca) CEBE
  from (
        -- Internas MIGRADAS
        select tipo, invmsesu producto, sesucate, concclco, invmconc conc, concdesc, Total
          from (
        SELECT 'Int_mig' tipo, m.invmsesu, sesucate, concclco, invmconc, o.concdesc, sum(invmvain) Total
          from open.Ldci_Ingrevemi m, open.concepto o, open.servsusc s
         Where m.invmsesu in (SELECT DISTINCT OR_order_activity.product_id
                                FROM open.OR_related_order, open.OR_order_activity, open.or_order , open.mo_packages
                               WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                                 AND OR_related_order.related_order_id = OR_order_activity.order_id
                                 AND OR_order_activity.Status = 'F'
                                 AND OR_order_activity.package_id = mo_packages.package_id
                                 AND OR_order_activity.task_type_id in (10622, 10624)
                                 AND mo_packages.package_type_id in (100271)
                                 AND OR_order.order_id = OR_related_order.related_order_id
                                 AND OR_order.legalization_date >= '01-05-2016'          -- FECHA INICIAL
                                 AND OR_order.legalization_date <= '31-05-2016 23:59:59'
                                 AND OR_order.CAUSAL_ID IN (select c.causal_id from open.ge_causal c
                                                             where c.class_causal_id = 1)
                                 /*AND OR_order_activity.product_id not in (SELECT distinct hcecnuse
                                                                      FROM open.hicaesco h
                                                                     WHERE hcececan = 96
                                                                       AND hcececac = 1
                                                                       AND hcecserv = 7014
                                                                       AND hcecfech < '&Fecha_Inicial')*/)  -- FECHA FINAL
        AND m.invmsesu = s.sesunuse
        AND invmconc = conccodi
        AND m.invmconc in (30)
        Group by m.invmsesu, sesucate, invmconc, o.concdesc, concclco
        )
        --
        UNION
        -- INGRESOS MIGRADOS - Ultima Consulta
        select tipo, invmsesu producto, sesucate, concclco, invmconc conc, concdesc, Total
          from (
        select 'Ing_mig' tipo, invmsesu, sesucate, concclco, invmconc, concdesc, sum(Total - nvl(reportada,0)) Total
          from (
                  SELECT  /*+
                              index (cargos, IX_CARGOS02)
                              index (ab_address, PK_AB_ADDRESS)
                              index (servsusc, PK_SERVSUSC)
                          */
                          m.invmsesu, sesucate, invmconc, concclco, o.concdesc, 'DB', sum(invmvain) total,
                          (SELECT sum(invmvain)
                             from open.Ldci_Ingrevemi x
                            where x.invmsesu = m.invmsesu
                              and x.invmsesu in (SELECT DISTINCT  OR_order_activity.product_id
                                                      FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                                                     WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                                                       AND OR_related_order.related_order_id = OR_order_activity.order_id
                                                       AND OR_order_activity.Status = 'F'
                                                       AND OR_order_activity.package_id = mo_packages.package_id
                                                       AND OR_order_activity.task_type_id in (10622, 10624)
                                                       AND mo_packages.package_type_id in (100271)
                                                       AND OR_order.legalization_date >= '09-02-2015' -- FECHA FIJA
                                                       AND OR_order.legalization_date <= '31-05-2016 23:59:59'
                                                       AND OR_order.order_id = OR_related_order.related_order_id)
                              AND x.invmconc = 30
                              AND x.invmconc = m.invmconc
                            group by x.invmsesu) Reportada
                  from open.Ldci_Ingrevemi m, open.servsusc s, open.concepto o
                  where m.invmsesu in (SELECT distinct hcecnuse
                                         FROM open.hicaesco h
                                        WHERE hcececan = 96
                                          AND hcececac = 1
                                          AND hcecserv = 7014
                                          AND hcecfech >= '01-05-2016' and hcecfech <= '31-05-2016 23:59:59')
                  AND m.invmsesu = s.sesunuse
                  AND invmconc = conccodi
                 group by m.invmsesu, sesucate, invmconc, o.concdesc, concclco
              )
        group by invmsesu, sesucate, invmconc, concdesc, concclco
        )
        --
        UNION
        -- Internas OSF Legalizadas
        select tipo, product_id producto, SESUCATE, concclco, CARGCONC conc, CONCDESC, TOTAL
          from (
        select 'Int_con' tipo, product_id, SESUCATE, concclco, CARGCONC, CONCDESC, SUM(VALOR) TOTAL
        FROM (
        select product_id, package_type_id, sesucate, sesusuca, concclco, cargconc, concdesc, Vr_Unitario Valor
         from  open.servsusc, open.suscripc,
               (select cargconc, concclco, o.concdesc, product_id, m.package_type_id,
                       (cargvalo/(select count(*) from open.or_order_activity a, open.or_order o
                                   where package_id   = substr(c.cargdoso,4,8)
                                     and a.task_type_id = 12150
                                     and a.order_id   = o.order_id
                                     and (o.causal_id is null OR
                                          o.causal_id in (select gc.causal_id from open.ge_causal gc
                                                          where gc.causal_id = o.causal_id and gc.class_causal_id = 1))
                                     )) Vr_Unitario
                  from open.cargos c, open.concepto o, open.mo_packages m,
                       (SELECT DISTINCT to_char(mo_packages.package_id) package_id, OR_order_activity.product_id
                          FROM open.OR_related_order, open.OR_order_activity, open.or_order,
                               open.mo_packages, open.ge_items i
                         WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                           AND OR_related_order.related_order_id = OR_order_activity.order_id
                           AND OR_order_activity.Status = 'F'
                           AND OR_order_activity.package_id = mo_packages.package_id
                           AND OR_order_activity.task_type_id in (10622, 10624)
                           AND mo_packages.package_type_id    in (323)
                           AND OR_order.order_id = OR_related_order.related_order_id
                           AND OR_order.legalization_date >= '01-05-2016'       -- FECHA INICIAL
                           AND OR_order.legalization_date <= '31-05-2016 23:59:59'  -- FECHA FINAL
                           AND OR_order_activity.Status = 'F'
                           AND OR_order.CAUSAL_ID IN (select c.causal_id from open.ge_causal c
                                                       where c.class_causal_id = 1)
                           AND OR_order_activity.product_id not in (SELECT distinct hcecnuse
                                                                      FROM open.hicaesco h
                                                                     WHERE hcecfech < '01-05-2016'
                                                                       AND hcececan = 96
                                                                       AND hcececac = 1
                                                                       AND hcecserv = 7014)) u
                 where cargconc in (30, 291)
                   and cargconc = o.conccodi
                   and cargdoso = 'PP-'||u.package_id
                   and u.package_id = m.package_id)
          where sesunuse = product_id
            and sesususc = susccodi
         )
        GROUP BY product_id, SESUCATE, CARGCONC, CONCDESC, concclco
        )
        --
        UNION
        -- INGRESOS OSF NUEVA 03/05/2015
        select tipo, product_id producto, SESUCATE, concclco, CARGCONC conc, CONCDESC, Total
          from (
        select 'Ing_con' tipo, product_id, SESUCATE, concclco, CARGCONC, CONCDESC, SUM(VALOR - nvl(reportada,0)) Total --, sum(reportada) Reportada
        FROM (
        select product_id, package_type_id, sesucate, sesusuca, concclco, cargconc, concdesc, (cargvalo/ventas) Valor,
               -- Ingreso Reportado
               (select cargvalo/ventas
                  from
                       (select cargconc, product_id, cargvalo
                          from open.cargos c,
                               (SELECT DISTINCT to_char(mo_packages.package_id) package_id, OR_order_activity.product_id
                                  FROM open.OR_related_order, open.OR_order_activity, open.or_order,
                                       open.mo_packages, open.ge_items i
                                 WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                                   AND OR_related_order.related_order_id = OR_order_activity.order_id
                                   AND OR_order_activity.Status = 'F'
                                   AND OR_order_activity.package_id = mo_packages.package_id
                                   AND OR_order_activity.task_type_id in (10622, 10624)
                                   AND mo_packages.package_type_id in (323)
                                   AND OR_order.order_id = OR_related_order.related_order_id
                                   AND OR_order.legalization_date >= '09-02-2015'
                                   AND OR_order.legalization_date <= '31-05-2016 23:59:59' -- Orden de apoyo
                                   AND OR_order_activity.Status = 'F'
                                   AND OR_order_activity.product_id in (SELECT distinct hcecnuse
                                                                         FROM open.hicaesco h
                                                                        WHERE hcecfech >= '01-05-2016'
                                                                          and hcecfech <= '31-05-2016 23:59:59'
                                                                          AND hcecnuse = OR_order_activity.product_id
                                                                          AND hcececan = 96
                                                                          AND hcececac = 1
                                                                          AND hcecserv = 7014)) u
                          where cargdoso = 'PP-' || u.package_id
                            and cargconc in (30, 291)
                          ) ux
                where ux.product_id = uu.product_id
                  and ux.cargconc = uu.cargconc) Reportada
          ----
          from (
                select cargconc, cargvalo, package_id, package_type_id, u.product_id,
                       (select count(*) from open.or_order_activity a, open.or_order o
                                   where package_id   = u.package_id
                                     and a.task_type_id in (12150, 12152, 12153)
                                     and a.order_id   = o.order_id
                                     and a.order_id not in (select oro.related_order_id from open.or_related_order oro
                                                            where oro.related_order_id = a.order_id)) VENTAS
                  from open.cargos,
                       (SELECT distinct to_char(m.package_id) package_id, m.package_type_id, a.product_id
                          from open.or_order_activity a, open.mo_packages m
                         where a.product_id in (SELECT distinct hcecnuse
                                                 FROM open.hicaesco h
                                                WHERE hcecfech >= '01-05-2016' and hcecfech <= '31-05-2016 23:59:59'
                                                  AND hcecnuse = a.product_id
                                                  AND hcececan = 96
                                                  AND hcececac = 1
                                                  AND hcecserv = 7014)
                          and a.package_id = m.package_id and m.package_type_id in (323)) u
                 where cargdoso =  'PP-'||package_id
                   and cargconc in (19, 291, 674, 30)
                   and cargcaca in (41,53)
               ) uu, open.concepto, open.servsusc
          where sesunuse = product_id
            and cargconc = conccodi
        )
        GROUP BY product_id, SESUCATE, CARGCONC, CONCDESC, concclco
        )
        --
        UNION
        --
        -- MIGRADAS ANULADAS
        SELECT 'Anu_Mig' tipo, M.INVMSESU producto, s.sesucate, o.concclco, invmconc conc, o.concdesc, M.INVMVAIN total
          from open.ldci_ingrevemi m, open.servsusc s, open.concepto o 
         where m.invmsesu in (SELECT distinct hcecnuse FROM open.hicaesco h
                               WHERE hcececac in (110)
                                 AND hcecserv = 7014
                                 AND hcecfech >= '&Fecha_Inicial' and hcecfech <= '&Fecha_Final 23:59:59')
           AND M.INVMSESU = s.sesunuse
           AND invmconc = conccodi
       ) xx, open.servsusc su, open.suscripc
 where sesunuse = producto
   AND sesususc = susccodi
   AND total != 0
