-- INGRESOS OSF NUEVA 03/05/2015
select CEBE, LOCA, DESCRIPCION, product_id, package_type_id, SESUCATE, SESUSUCA, CARGCONC, CONCDESC, 
       SUM(VALOR) TOTAL, sum(reportada) reportada
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
       product_id, package_type_id, sesucate, sesusuca, cargconc, concdesc, (cargvalo/ventas) Valor,
       -- Ingreso Reportado      
       (select sum(vr_unitario) vr_unitario
       from (select cargconc, product_id, (cargvalo/(select count(*) from open.or_order_activity
                                                          where package_id = substr(c.cargdoso,4,8)
                                                            and task_type_id = 12150)) Vr_Unitario
                from open.cargos c, 
                     (SELECT DISTINCT to_char(mo_packages.package_id) package_id, OR_order_activity.product_id 
                        FROM open.OR_related_order, open.OR_order_activity, open.or_order, 
                             open.mo_packages, open.ge_items i
                       WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                         AND OR_related_order.related_order_id = OR_order_activity.order_id
                         AND OR_order_activity.Status = 'F'
                         AND OR_order_activity.package_id = mo_packages.package_id
                         AND OR_order_activity.task_type_id in (10622, 10624)
                         AND mo_packages.package_type_id in (323/*, 100229*/) 
                         AND OR_order.order_id = OR_related_order.related_order_id
                         AND OR_order.legalization_date >= '09-02-2015'
                         AND OR_order.legalization_date <  '01-10-2015' -- Orden de apoyo
                         AND OR_order_activity.Status = 'F') u
               where substr(cargdoso, 1, 2) = 'PP'
                 and substr(cargdoso, 4, 8) = u.package_id
                 and cargconc in (30, 291)
            ) ux
        where ux.product_id = uu.product_id
          and ux.cargconc = uu.cargconc) Reportada
  ----      
  from (
        select cargconc, cargvalo, package_id, package_type_id, u.product_id, 
               (select count(*) from open.or_order_activity
                where or_order_activity.package_id = u.package_id
                 and task_type_id in (12150, 12152, 12153)) VENTAS
              /* (select count(*) from open.or_order_activity act, open.or_order oo
                 where act.package_id    =  u.package_id
                   and act.order_id      =  oo.order_id
                   and oo.created_date  <=  '31-10-2015 23:59:59'
                   and act.task_type_id in  (12150, 12152, 12153)
                   and act.order_id not in  (select oro.related_order_id from open.or_related_order oro
                                            where oro.related_order_id = act.order_id)) ventas*/
          from open.cargos, 
               (SELECT distinct to_char(m.package_id) package_id, m.package_type_id, a.product_id
                  from open.or_order_activity a, open.mo_packages m
                 where a.product_id in (SELECT distinct hcecnuse
                                         FROM open.hicaesco h
                                        WHERE hcececan = 96
                                          --and h.hcecnuse = 50899792 --50903401 --50907893
                                          AND hcececac = 1
                                          AND hcecserv = 7014
                                          AND hcecfech >= '09-02-2015' and hcecfech < '01-10-2015')
                  and a.package_id = m.package_id and m.package_type_id in (323/*, 100229*/)) u
         where cargdoso in 'PP-'||package_id
           and cargconc in (19, 291, 674, 30)
           and cargcaca in (41,53)
       ) uu, open.concepto, open.servsusc, open.suscripc
  where sesunuse = product_id
    and sesususc = susccodi
    and cargconc = conccodi
)
GROUP BY CEBE, LOCA, DESCRIPCION, product_id, SESUCATE, SESUSUCA, CARGCONC, CONCDESC, package_type_id  
order by product_id, CARGCONC