-- Ingresos OSF  NUEVA 03/05/2015
select CEBE, LOCA, DESCRIPCION, 
       SESUCATE CATE, (select ct.catedesc from open.categori ct where ct.catecodi = sesucate) Desc_Categoria,
       SESUSUCA, CARGCONC, CONCDESC, SUM(VALOR) TOTAL
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
       product_id, sesucate, sesusuca, cargconc, concdesc, (cargvalo/ventas) Valor
  from (
        select cargconc, cargvalo, package_id, u.product_id, 
               (select count(*) from open.or_order_activity
                where or_order_activity.package_id = u.package_id
                 and task_type_id in (12150, 12152, 12153)) VENTAS
          from open.cargos, 
               (SELECT distinct to_char(m.package_id) package_id, m.package_type_id, a.product_id
                  from open.or_order_activity a, open.mo_packages m
                 where a.product_id in (SELECT distinct hcecnuse
                                         FROM open.hicaesco h
                                        WHERE hcececan = 96
                                          AND hcececac = 1
                                          AND hcecserv = 7014
                                          AND hcecfech >= '01-07-2015' and hcecfech < '01-08-2015')
                  and a.package_id = m.package_id and m.package_type_id in (323, 100229)) u
         where cargdoso in 'PP-'||package_id
           and cargconc in (/*19,  */674)
           and cargcaca = 53
       ), open.concepto, open.servsusc, open.suscripc
  where sesunuse = product_id
    and sesususc = susccodi
    and cargconc = conccodi)
GROUP BY CEBE, LOCA, DESCRIPCION, SESUCATE, SESUSUCA, CARGCONC, CONCDESC    
