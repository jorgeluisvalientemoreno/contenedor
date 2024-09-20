-- SC UNIFICADO
-- MIGRADAS ANULADAS
SELECT 'Anu_Mig' Tipo, M.INVMSESU, s.sesucate, M.INVMCONC, o.concdesc, M.INVMVAIN Total, 0 Reportada, M.INVMVAIN Contabilizar, l.celocebe   
  from open.ldci_ingrevemi m, open.servsusc s, open.ab_address, open.suscripc, open.ge_subscriber g,
       open.ldci_centbenelocal l, open.concepto o
 where m.invmsesu in (SELECT distinct hcecnuse FROM open.hicaesco h
                       WHERE hcececac in (110)
                         AND hcecserv = 7014
                         AND hcecfech >= '&Fecha_Inicial' and hcecfech <= '&Fecha_Final 23:59:59')
   AND M.INVMSESU = s.sesunuse
   AND sesususc = susccodi
   AND suscclie = g.subscriber_id
   AND g.address_id = ab_address.address_id
   AND ab_address.geograp_location_id = l.celoloca AND invmconc = conccodi
--
UNION ALL
--
-- Internas MIGRADAS
SELECT 'Int_Mig' Tipo, m.invmsesu, sesucate, invmconc, o.concdesc, sum(invmvain), 0 reportada, sum(invmvain) contabilizar, l.celocebe  
  from open.Ldci_Ingrevemi m, open.servsusc s, open.ab_address, open.suscripc, open.ge_subscriber g,
       open.ldci_centbenelocal l, open.concepto o
where m.invmsesu in (SELECT DISTINCT OR_order_activity.product_id
                       FROM open.OR_order_activity, open.or_order , open.mo_packages
                      WHERE OR_order_activity.package_id = mo_packages.package_id
                        AND or_order.task_type_id in (12149, 12151) -- (10622, 10624)
                        AND mo_packages.package_type_id in (100271) 
                        AND OR_order.order_id = OR_order_activity.order_id
                        AND OR_order.legalization_date >= '&Fecha_Inicial'          -- FECHA INICIAL
                        AND OR_order.legalization_date <= '&Fecha_Final 23:59:59'
                        AND OR_order.CAUSAL_ID IN (select c.causal_id from open.ge_causal c where c.class_causal_id = 1)
                        AND OR_order_activity.product_id not in (select act.product_id 
                                                                   from open.or_order_activity act, open.or_order oo
                                                                  where act.product_id = OR_order_activity.product_id
                                                                    and oo.task_type_id in (10622, 10624)
                                                                    and act.order_id = oo.order_id
                                                                    and oo.legalization_date < '01/06/2018')
                        AND OR_order_activity.product_id not in (SELECT distinct hcecnuse
                                                                   FROM open.hicaesco h
                                                                  WHERE hcececan = 96
                                                                    AND hcececac = 1
                                                                    AND hcecserv = 7014
                                                                    AND hcecfech < '&Fecha_Inicial')
                        AND OR_order_activity.order_id not in (select oo.related_order_id
                                                                 from open.OR_related_order oo 
                                                                where oo.related_order_id = OR_order_activity.order_id
                                                                  and oo.rela_order_type_id = 14)                                                                     
                    )  -- FECHA FINAL
AND m.invmsesu = s.sesunuse
AND sesususc = susccodi
AND suscclie = g.subscriber_id
AND g.address_id = ab_address.address_id
AND ab_address.geograp_location_id = l.celoloca AND invmconc = conccodi
AND m.invmconc in (30)
Group by m.invmsesu, sesucate, invmconc, o.concdesc, 'DB', l.celocebe
--
UNION ALL
--
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
                                             WHERE OR_related_order.related_order_id = OR_order_activity.order_id
                                               AND OR_order_activity.package_id = mo_packages.package_id
                                               AND (
                                                    or_order.task_type_id in (10622, 10624)    AND               
                                                    OR_order.legalization_date >= '09/02/2015' AND 
                                                    OR_order.legalization_date <= '31/05/2018 23:59:59' -- Fecha Fija
                                                  OR
                                                    -- Nuevo esquema de reportar Ingreso de Interna
                                                    or_order.task_type_id in (12149, 12151)    AND                   
                                                    OR_order.legalization_date >= '01/06/2018' AND    -- Fecha Fija - Nuevo esquema de reportar Interna  
                                                    OR_order.legalization_date <  to_date('&Fecha_Final', 'dd-mm-yyyy') + 1 -- Fecha cierre mes anterior
                                                   )                                                   
                                               AND OR_order.order_id = OR_related_order.related_order_id
                                               AND OR_order.CAUSAL_ID IN (select c.causal_id from open.ge_causal c where c.class_causal_id = 1)
/*                                               AND OR_order_activity.product_id in (SELECT distinct hcecnuse
                                                                                    FROM   open.hicaesco h
                                                                                    WHERE hcecfech >= '&Fecha_Inicial'
                                                                                    AND   hcecfech <= '&Fecha_Final 23:59:59'
                                                                                    AND   hcecnuse = OR_order_activity.product_id
                                                                                    AND   hcececan = 96
                                                                                    AND   hcececac = 1
                                                                                    AND   hcecserv = 7014)    */                                           
                                        )
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
--order by sesucate, celocebe, invmconc
--
UNION ALL
--
-- INGRESOS OSF NUEVA 03/05/2015
select *
  from
(
select 'Ing_Osf' Tipo, producto, SESUCATE, CARGCONC, CONCDESC, SUM(VALOR) TOTAL, sum(reportada) reportada, (SUM(VALOR) - sum(nvl(reportada,0))) Contabilizar,
       (select db.celocebe from open.ldci_centbenelocal db where db.celoloca = loca) cebe
FROM (
      select producto, package_type_id, sesucate, sesusuca, cargconc, concdesc, (cargvalo/ventas) Valor,
             (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi) LOCA,
             -- Ingreso Reportado
             (select sum(vr_unitario/ventas) vr_unitario
               from (select cargconc, product_id, vr_unitario
                       from
                            (select cargconc, product_id, (cargvalo) Vr_Unitario, package_id
                               from open.cargos c,
                                    (SELECT DISTINCT to_char(mo_packages.package_id) package_id, OR_order_activity.product_id
                                       FROM open.OR_order_activity, open.or_order, open.mo_packages
                                      WHERE OR_order_activity.package_id = mo_packages.package_id
                                      
                                        AND (
                                              or_order.task_type_id in (10622, 10624)    AND               
                                              OR_order.legalization_date >= '09/02/2015' AND 
                                              OR_order.legalization_date <= '31/05/2018 23:59:59' -- Fecha Fija
                                            OR
                                              -- Nuevo esquema de reportar Ingreso de Interna
                                              or_order.task_type_id in (12149, 12151)    AND                   
                                              OR_order.legalization_date >= '01/06/2018' AND    -- Fecha Fija - Nuevo esquema de reportar Interna  
                                              OR_order.legalization_date <  to_date('&Fecha_Final', 'dd-mm-yyyy') + 1 -- Fecha cierre mes anterior
                                            )                                
                                        --AND or_order.task_type_id in (10622, 10624, 12149, 12151)
                                        AND mo_packages.package_type_id in (323)
                                        AND OR_order.order_id = OR_order_activity.order_id
                                        --AND OR_order.legalization_date >= '09-02-2015'
                                        --AND OR_order.legalization_date <= '&Fecha_Final 23:59:59' -- Orden de apoyo
                                        AND OR_order_activity.Status = 'F'
                                        AND OR_order.CAUSAL_ID IN (select c.causal_id from open.ge_causal c where c.class_causal_id = 1)
                                    )

                     where cargdoso = 'PP-' || package_id
                       and cargconc in (30, 291)
      /*                 and product_id not in (SELECT distinct hs.hcecnuse
                                                FROM open.hicaesco hs
                                               WHERE hs.hcecnuse = product_id
                                                 AND hs.hcececan = 96
                                                 AND hs.hcececac = 1
                                                 AND hs.hcecserv = 7014
                                                 AND hs.hcecfech < '&Fecha_Inicial')*/
                       ) u
                  ) ux
              where ux.product_id = uu.producto --uu.product_id
                and ux.cargconc = uu.cargconc
             ) Reportada

        ----
        from (
              select cargconc, cargvalo, package_id, package_type_id, producto, --u.product_id,
                     cargunid VENTAS
                from open.cargos, open.concepto o,
                     (SELECT distinct to_char(m.package_id) package_id, m.package_type_id, a.product_id producto, tt.concept 
                        from open.or_order_activity a, open.mo_packages m, open.or_task_type tt
                       where a.product_id in (SELECT distinct hcecnuse
                                               FROM open.hicaesco h
                                              WHERE hcecfech >= '&Fecha_Inicial' and hcecfech <= '&Fecha_Final 23:59:59'
                                                AND h.hcecnuse = a.product_id
                                                AND hcececan = 96
                                                AND hcececac = 1
                                                AND hcecserv = 7014)
                        and a.package_id = m.package_id and m.package_type_id in (323/*, 100229*/)
                        and a.task_type_id = tt.task_type_id) u
               where cargdoso in 'PP-'||package_id
                 and cargconc =  conccodi
                 and concept  =  cargconc
                 and concclco in (4,19,400)
              --   and cargDOSO =  'PP-82456278'
                 and cargcaca in (41,53)
             ) uu, open.concepto, open.servsusc, open.suscripc
        where sesunuse = producto
          and sesususc = susccodi
          and cargconc = conccodi
      --    and producto = 51450869
     )
      GROUP BY loca, producto, SESUCATE, SESUSUCA, CARGCONC, CONCDESC, package_type_id
)
--
UNION ALL
--
-- Internas OSF Legalizadas
select 'Ing_Interna_Osf' Tipo, product_id, SESUCATE, CARGCONC, CONCDESC, /*SUM*/(VALOR) TOTAL, 0 Reportada, /*SUM*/(VALOR) Contabilizar, CEBE
  FROM (
select (select l.celocebe
          from open.GE_GEOGRA_LOCATION t, open.ldci_centbenelocal l
         where geograp_location_id = (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS
                                       where address_id = susciddi)
          and t.geo_loca_father_id = l.celodpto
          and t.geograp_location_id = celoloca) CEBE,
       (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi) LOCA,
       (select g.description from open.ge_geogra_location g
         where g.geograp_location_id =  (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi)) DESCRIPCION,
       product_id, package_type_id, order_id, sesucate, sesusuca, cargconc, concdesc, Vr_Unitario Valor
 from  open.servsusc, open.suscripc,
       (select cargconc, o.concdesc, product_id, m.package_type_id, u.order_id,
               (cargvalo/cargunid) Vr_Unitario
          from open.cargos c, open.concepto o, open.mo_packages m,
               (SELECT DISTINCT to_char(mo_packages.package_id) package_id, OR_order_activity.product_id, OR_order.order_id
                  FROM open.OR_order_activity, open.or_order, open.mo_packages
                 WHERE OR_order.legalization_date >= '&Fecha_Inicial'                           -- FECHA INICIAL
                   AND OR_order.legalization_date <  to_date('&Fecha_Final', 'dd-mm-yyyy') + 1  -- FECHA FINAL
                   AND or_order.order_id = OR_order_activity.order_id
                   AND OR_order_activity.Status = 'F'
                   AND OR_order_activity.package_id = mo_packages.package_id
                   AND mo_packages.package_type_id in (323)
                   AND or_order.task_type_id in (12149, 12151) -- (10622, 10624)
                   AND OR_order.CAUSAL_ID IN (select c.causal_id from open.ge_causal c where c.class_causal_id = 1)
                   AND OR_order_activity.order_id = or_order.order_id
                   AND OR_order_activity.product_id not in (select act.product_id
                                                              from open.or_order_activity act, open.or_order oo, open.mo_packages mp,
                                                                   open.OR_related_order oro
                                                             where act.product_id = OR_order_activity.product_id
                                                               and act.order_id = oo.order_id
                                                               and oro.related_order_id = oo.order_id
                                                               and oro.rela_order_type_id in (4, 13)
                                                               and oo.task_type_id in (10622, 10624)
                                                               AND act.package_id = mp.package_id
                                                               AND mp.package_type_id in (323)
                                                               and oo.legalization_date < '01/06/2018' -- Fecha Fija, comienza nuevo proceso interna
                                                               AND oo.CAUSAL_ID IN (select ca.causal_id from open.ge_causal ca
                                                                                     where ca.causal_id = oo.CAUSAL_ID
                                                                                       and ca.class_causal_id = 1))
                   AND OR_order_activity.product_id not in (SELECT distinct hcecnuse
                                                              FROM open.hicaesco h
                                                             WHERE h.hcecnuse = OR_order_activity.product_id
                                                               AND hcececan = 96
                                                               AND hcececac = 1
                                                               AND hcecserv = 7014
                                                               AND hcecfech < '&Fecha_Inicial')
                   AND OR_order_activity.order_id not in (select oo.related_order_id
                                                            from open.OR_related_order oo 
                                                           where oo.related_order_id = OR_order_activity.order_id
                                                             and oo.rela_order_type_id = 14)                                                               
               ) u
         where cargconc in (30, 291)
           and cargconc = o.conccodi
           and cargdoso = 'PP-'||u.package_id
--           and cargDOSO =  'PP-84114953'
           and u.package_id = m.package_id)
  where sesunuse = product_id
    and sesususc = susccodi
 )
