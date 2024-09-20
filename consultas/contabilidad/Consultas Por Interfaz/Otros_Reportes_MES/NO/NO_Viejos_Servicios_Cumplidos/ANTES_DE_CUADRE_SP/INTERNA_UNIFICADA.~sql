-- INTERNA UNIFICADA MIG - OSF
select CEBE, LOCA, DESCRIPCION, SESUCATE, SESUSUCA, /*CARGCONC, CONCDESC,*/ SUM(VALOR) TOTAL
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
       product_id, sesucate, sesusuca, /*cargconc, concdesc,*/ Interna Valor
  FROM open.servsusc, open.suscripc,
       (SELECT product_id, (case when nvl(Interna_S,0) > 0 then INTERNA_S
                                else Interna_M end) INTERNA
          from (
                select product_id,
                       (select (cargvalo/(select count(*) from open.or_order_activity
                                           where package_id = substr(c.cargdoso,4,8)
                                             and task_type_id = 12150))
                          from open.cargos c
                         where substr(cargdoso, 1, 2) = 'PP'
                           and substr(cargdoso, 4, 8) = package_id
                           and cargconc in (30, 289, 291)) Interna_S, -- INTERNA OSF
                       (SELECT sum(invmvain)
                          from open.Ldci_Ingrevemi m
                         where m.invmsesu = product_id
                           AND m.invmconc in (30)
                        group by m.invmsesu) Interna_M -- INTERNA MIGRADA
                  from 
                       (SELECT DISTINCT to_char(mo_packages.package_id) package_id, OR_order_activity.product_id
                          FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages, open.ge_items i
                         WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                           AND OR_related_order.related_order_id = OR_order_activity.order_id
                           AND OR_order_activity.Status = 'F'
                           AND OR_order_activity.package_id = mo_packages.package_id
                           AND OR_order_activity.task_type_id in (10622, 10624)
                           AND mo_packages.package_type_id in (323, 100229, 100271) 
                           AND OR_order.order_id = OR_related_order.related_order_id
                           AND OR_order.legalization_date >= '01-06-2015'
                           AND OR_order.legalization_date <  '01-07-2015' -- Orden de apoyo
                           AND OR_order_activity.Status = 'F') u
               ))
  where sesunuse = product_id
    and sesususc = susccodi)
GROUP BY CEBE, LOCA, DESCRIPCION, SESUCATE, SESUSUCA--, CARGCONC, CONCDESC                 
