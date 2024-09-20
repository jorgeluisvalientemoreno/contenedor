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
                 WHERE OR_order.legalization_date >= '01-07-2018'         -- FECHA INICIAL
                   AND OR_order.legalization_date <= '31-07-2018 23:59:59'  -- FECHA FINAL
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
                                                               AND hcecfech < '01-07-2018')
                   AND OR_order_activity.order_id not in (select oo.related_order_id
                                                            from open.OR_related_order oo 
                                                           where oo.related_order_id = OR_order_activity.order_id
                                                             and oo.rela_order_type_id = 14)                                                               
               ) u
         where cargconc in (30, 291)
           and cargconc = o.conccodi
           and cargdoso = 'PP-'||u.package_id
           and u.package_id = m.package_id)
  where sesunuse = product_id
    and sesususc = susccodi
 )
