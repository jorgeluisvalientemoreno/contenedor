select (select l.celocebe 
          from open.GE_GEOGRA_LOCATION t, open.ldci_centbenelocal l
         where geograp_location_id = (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS
                                       where address_id = susciddi)
          and t.geo_loca_father_id = l.celodpto 
          and t.geograp_location_id = celoloca) CEBE, 
       Producto, package_type_id, sesucate, sesusuca, cargconc, concdesc, (cargvalo/ventas) Valor,
       -- Reportada
       CASE WHEN CARGCONC IN (30,291) THEN
         (
           DECODE (
                   (SELECT 'X'
                      FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                     WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                       AND OR_related_order.related_order_id = OR_order_activity.order_id
                       AND OR_order_activity.Status = 'F'
                       AND OR_order_activity.package_id = mo_packages.package_id
                       AND OR_order_activity.task_type_id in (10622, 10624)
                       AND mo_packages.package_type_id in (323, 100229) 
                       AND OR_order.order_id = OR_related_order.related_order_id
                       AND OR_order.legalization_date >= '09-02-2015'
                       AND OR_order.legalization_date <= '30-11-2016 23:59:59' -- Orden de apoyo
                       AND OR_order_activity.Status = 'F'
                       AND OR_order_activity.product_id = Producto
                       AND OR_order_activity.product_id not in (select act.product_id
                                                                  from open.or_order_activity act, open.or_order oo
                                                                  where act.product_id = Producto
                                                                    and act.task_type_id in (10622, 10624)
                                                                    and act.order_id = oo.order_id
                                                                    and oo.legalization_date <= '31-10-2016 23:59:59')
                       AND OR_order_activity.product_id not in (SELECT distinct hcecnuse
                                                                  FROM open.hicaesco h
                                                                 WHERE h.hcecnuse = Producto
                                                                   AND hcececan =  96
                                                                   AND hcececac =  1
                                                                   AND hcecserv =  7014
                                                                   AND hcecfech <= '31-10-2016 23:59:59')
                    ), 'X', (cargvalo/ventas), 0) 
            )END Reportada
    
FROM 
(       
select cargconc, cargvalo, package_id, package_type_id, u.product_id Producto, 
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
       (SELECT distinct to_char(m.package_id) package_id, m.package_type_id, a.product_id
          from open.or_order_activity a, open.mo_packages m
         where a.product_id in (SELECT distinct hcecnuse
                                 FROM open.hicaesco h
                                WHERE hcecfech >= '&Fecha_Inicial' and hcecfech <= '&Fecha_Final 23:59:59'
                                  AND h.hcecnuse = a.product_id
                                  AND hcececan = 96
                                  AND hcececac = 1
                                  AND hcecserv = 7014)
          and a.package_id = m.package_id and m.package_type_id in (323)
       ) u
 where cargdoso in 'PP-'||package_id
   and cargconc in (19, 291, 674, 30)
   and cargcaca in (41,53)
)uu, open.concepto, open.servsusc, open.suscripc
  where sesunuse = Producto
    and sesususc = susccodi
    and cargconc = conccodi
