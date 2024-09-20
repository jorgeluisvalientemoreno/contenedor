select  cebe, (select g.geo_loca_father_id from open.ge_geogra_location g where g.geograp_location_id = loca) DEPA, 
        loca, (select g.description from open.ge_geogra_location g where g.geograp_location_id = loca) DESCRIPCION,
        product_id NUSE, sesucate CATE, EST_TECNICO, DES_TECNICO , cargconc CONCEPTO, o.concdesc,
        sum((cargvalo/ventas)) VR_iNGRESO, ((int_reportada/ventas)*-1) REPORTADO, TIPO_SOLICITUD
  from 
       (
        select distinct ort.product_id, cargnuse, cargconc, cargcaca, cargvalo, ventas, SOLICITUD,
               (select l.celocebe 
                  from open.GE_GEOGRA_LOCATION t, open.ldci_centbenelocal l
                 where geograp_location_id = (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi)
                   and t.geo_loca_father_id = l.celodpto 
                   and t.geograp_location_id = celoloca) CEBE, 
               (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi) LOCA, 
               96 EST_TECNICO, st.escodesc DES_TECNICO, sesucate, mo.package_type_id TIPO_SOLICITUD, 
               (decode((SELECT 1
                          FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                         WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                           AND OR_related_order.related_order_id = OR_order_activity.order_id
                           AND OR_order_activity.Status = 'F'
                           AND OR_order_activity.package_id = mo_packages.package_id
                           AND OR_order_activity.task_type_id in (10622, 10624)
                           AND mo_packages.package_type_id in (323, 100229) 
                           AND OR_order.order_id = OR_related_order.related_order_id
                           AND OR_order.legalization_date < '01-05-2015'
                           AND OR_order_activity.product_id = cargnuse
                           AND cargconc = 30
                           AND ROWNUM = 1), 1, cargvalo, 0)) Int_Reportada
          from 
               (select cargnuse, cargconc, cargcaca, cargvalo, substr(cargdoso, 4, 8) SOLICITUD,
                       (select count(*) from open.or_order_activity
                         where or_order_activity.package_id = substr(cargdoso, 4, 8)
                           and task_type_id in (12150, 12152, 12153)) VENTAS
                  from open.cargos, open.servsusc
                 where cargnuse =  sesunuse
                   and sesuserv =  6121
                   and cargfecr >= '09-02-2015'
                   and cargfecr <  '01-03-2015'
                   and substr(cargdoso,1,3) = 'PP-'
                   and cargconc in (19,30,674,291,137,287)
                   and substr(cargdoso, 4, 8) in (select act.package_id 
                                                    from open.or_order_activity act, open.mo_packages m
                                                   where act.package_id = substr(cargdoso, 4, 8)
                                                     and act.task_type_id  in (12149, 12150, 12152, 12153)
                                                     and act.package_id    =  m.package_id
                                                     and m.package_type_id in (323, 100229))
               ), open.or_order_activity ort, open.suscripc c, open.servsusc s, open.estacort st, open.mo_packages mo
         where ort.package_id = solicitud
           and ort.subscription_id = susccodi
           and ort.product_id = sesunuse
           and ort.task_type_id in (12149, 12150, 12152, 12153)
           and ort.product_id not in (select hi.hcecnuse from open.hicaesco hi
                                       where hi.hcececan = 96 and hi.hcececac = 1 
                                         and hi.hcecfech >= '09-02-2015' and hi.hcecfech < '01-03-2015'
                                         and hi.hcecserv = 7014)
           and 96 = st.escocodi
           and mo.package_id =  ort.package_id
       ), OPEN.CONCEPTO O
 where cargconc = o.conccodi
group by cebe, loca, product_id, cargconc, cargvalo, ventas, EST_TECNICO, DES_TECNICO, sesucate, o.concdesc, 
         ((int_reportada/ventas)*-1), TIPO_SOLICITUD
