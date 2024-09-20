-- Internas OSF Legalizadas
select CEBE, LOCA, DESCRIPCION, product_id, package_type_id, SESUCATE, SESUSUCA, CARGCONC, CONCDESC, SUM(VALOR) TOTAL
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
       product_id, package_type_id, sesucate, sesusuca, cargconc, concdesc, Vr_Unitario Valor
 from  open.servsusc, open.suscripc,
       (select cargconc, o.concdesc, product_id, m.package_type_id,
               (cargvalo/(select count(*) from open.or_order_activity a--, open.or_order o
                           where package_id   = substr(c.cargdoso,4,8)
                                and ((a.task_type_id in (12150, 12152, 12153)) 
                                      OR (a.task_type_id = 12149 
                                         and a.package_id not in (select act.package_id from open.or_order_activity act 
                                                                   where act.package_id = substr(c.cargdoso,4,8)
                                                                     and act.task_type_id in (12150, 12152, 12153))
                                         )
                                     )
                             /*and (o.causal_id is null OR
                                  o.causal_id in (select gc.causal_id from open.ge_causal gc
                                                  where gc.causal_id = o.causal_id and gc.class_causal_id = 1))*/
                             )) /*total_unidades --*/Vr_Unitario
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
                   AND OR_order.legalization_date >= '&Fecha_Inicial'         -- FECHA INICIAL
                   AND OR_order.legalization_date <= '&Fecha_Final 23:59:59'  -- FECHA FINAL
                   AND OR_order_activity.Status = 'F'
                   AND OR_order.CAUSAL_ID IN (select c.causal_id from open.ge_causal c where c.class_causal_id = 1)
                   and OR_order_activity.product_id not in (select act.product_id 
                                                              from open.or_order_activity act, open.or_order oo
                                                             where act.product_id = OR_order_activity.product_id
                                                               and act.task_type_id in (10622, 10624)
                                                               and act.order_id = oo.order_id
                                                               and oo.legalization_date < '&Fecha_Inicial')
                   AND OR_order_activity.product_id not in (SELECT distinct hcecnuse
                                                              FROM open.hicaesco h
                                                             WHERE hcececan = 96
                                                               AND hcececac = 1
                                                               AND hcecserv = 7014
                                                               AND hcecfech < '&Fecha_Inicial')) u
         where cargconc in (30, 291)
           and cargconc = o.conccodi  
           and cargdoso = 'PP-'||u.package_id       
           and u.package_id = m.package_id)
  where sesunuse = product_id
    and sesususc = susccodi
 )
GROUP BY CEBE, LOCA, DESCRIPCION, product_id, SESUCATE, SESUSUCA, CARGCONC, package_type_id, CONCDESC
