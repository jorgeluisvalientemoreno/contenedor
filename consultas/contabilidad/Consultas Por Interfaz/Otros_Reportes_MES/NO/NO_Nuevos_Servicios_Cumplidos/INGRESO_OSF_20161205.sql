-- INGRESOS OSF NUEVA 03/05/2015
select * 
  from 
(
select (select db.celocebe from open.ldci_centbenelocal db where db.celoloca = loca) cebe,
       producto, package_type_id, SESUCATE, SESUSUCA, CARGCONC, CONCDESC, 
       SUM(VALOR) TOTAL, sum(reportada) reportada
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
                                FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                               WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                                 AND OR_related_order.related_order_id = OR_order_activity.order_id
                                 AND OR_order_activity.Status = 'F'
                                 AND OR_order_activity.package_id = mo_packages.package_id
                                 AND OR_order_activity.task_type_id in (10622, 10624)
                                 AND mo_packages.package_type_id in (323) 
                                 AND OR_order.order_id = OR_related_order.related_order_id
                                 AND OR_order.legalization_date >= '09-02-2015'
                                 AND OR_order.legalization_date <= '&Fecha_Final 23:59:59' -- Orden de apoyo
                                 AND OR_order_activity.Status = 'F'
                                 AND OR_order.CAUSAL_ID IN (select c.causal_id from open.ge_causal c where c.class_causal_id = 1)
                                 AND OR_order_activity.product_id in (SELECT distinct hcecnuse
                                                                      FROM   open.hicaesco h
                                                                      WHERE hcecfech >= '&Fecha_Inicial'
                                                                      AND   hcecfech <= '&Fecha_Final 23:59:59'
                                                                      AND   hcecnuse = OR_order_activity.product_id
                                                                      AND   hcececan = 96
                                                                      AND   hcececac = 1
                                                                      AND   hcecserv = 7014)
                             )

               where cargdoso = 'PP-' || package_id
                 and cargconc in (30, 291)
                 and product_id not in (SELECT distinct hs.hcecnuse
                                          FROM open.hicaesco hs
                                         WHERE hs.hcecnuse = product_id
                                           AND hs.hcececan = 96
                                           AND hs.hcececac = 1
                                           AND hs.hcecserv = 7014
                                           AND hs.hcecfech < '&Fecha_Inicial')                  
                 ) u                 
            ) ux
        where ux.product_id = uu.producto --uu.product_id
          and ux.cargconc = uu.cargconc
       ) Reportada

  ----      
  from (
        select cargconc, cargvalo, package_id, package_type_id, producto, --u.product_id, 
               (select count(*) from open.or_order_activity a, open.or_order o
                           where package_id   = u.package_id
                             and ((a.task_type_id in (12150, 12152, 12153)) 
                                      OR (a.task_type_id = 12149 
                                         and a.package_id not in (select act.package_id from open.or_order_activity act 
                                                                   where act.package_id = u.package_id
                                                                     and act.task_type_id in (12150, 12152, 12153))
                                         )
                                 )
                             and a.order_id   = o.order_id
                             and a.order_id not in (select oro.related_order_id from open.or_related_order oro
                                                     where oro.related_order_id = a.order_id)    
               ) VENTAS
          from open.cargos, 
               (SELECT distinct to_char(m.package_id) package_id, m.package_type_id, a.product_id producto
                  from open.or_order_activity a, open.mo_packages m
                 where a.product_id in (SELECT distinct hcecnuse
                                         FROM open.hicaesco h
                                        WHERE hcecfech >= '&Fecha_Inicial' and hcecfech <= '&Fecha_Final 23:59:59'
                                          AND h.hcecnuse = a.product_id
                                          AND hcececan = 96
                                          AND hcececac = 1
                                          AND hcecserv = 7014)
                  and a.package_id = m.package_id and m.package_type_id in (323/*, 100229*/)) u
         where cargdoso in 'PP-'||package_id
           and cargconc in (19, 291, 674, 30)
           and cargcaca in (41,53)
       ) uu, open.concepto, open.servsusc, open.suscripc
  where sesunuse = producto
    and sesususc = susccodi
    and cargconc = conccodi
)
GROUP BY loca, producto, SESUCATE, SESUSUCA, CARGCONC, CONCDESC, package_type_id
)
