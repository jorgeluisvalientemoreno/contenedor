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
                   AND mo_packages.package_type_id in (323/*, 100229*/) 
                   AND OR_order.order_id = OR_related_order.related_order_id
                   AND OR_order.legalization_date >= '01-11-2015'
                   AND OR_order.legalization_date <= '30-11-2015 23:59:59' -- Orden de apoyo
                   AND OR_order_activity.Status = 'F') u
         where substr(cargdoso, 1, 2) = 'PP'
           and substr(cargdoso, 4, 8) = u.package_id
           and cargconc = o.conccodi
           and cargconc in (30, 291)
           and u.package_id = m.package_id)
  where sesunuse = product_id
    and sesususc = susccodi
 )
GROUP BY CEBE, LOCA, DESCRIPCION, product_id, SESUCATE, SESUSUCA, CARGCONC, package_type_id, CONCDESC    
           
   
