-- VENTAS CON PRODUCTOS CREADOS
select * from
(
select  'CON_PRODUCTOS' TIPO, 
        cebe, (select g.geo_loca_father_id from open.ge_geogra_location g where g.geograp_location_id = loca) DEPA,
        loca, (select g.description from open.ge_geogra_location g where g.geograp_location_id = loca) DESCRIPCION,
        product_id NUSE, sesucate CATE, EST_TECNICO, DES_TECNICO, cargconc CONCEPTO, --o.concdesc,
        decode(cargconc,19, 'CAR_X_CON.',
                        30, 'INT_RESID.',
                        291,'INT_INDUS.',
                        674,'REV_PREVIA','NO_EXISTE') concdesc,
        sum((cargvalo/ventas)) VR_INGRESO, TIPO_SOLICITUD, 
        (decode((SELECT 1
                   FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                  WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                    AND OR_related_order.related_order_id = OR_order_activity.order_id
                    AND OR_order_activity.Status = 'F'
                    AND OR_order_activity.package_id = mo_packages.package_id
                    AND OR_order_activity.task_type_id in (10622, 10624)
                    AND mo_packages.package_type_id in (323, 100229)
                    AND OR_order.order_id = OR_related_order.related_order_id
                    AND OR_order.legalization_date >= '09-02-2015' 
                    AND OR_order.legalization_date <= '&FECHA_FINAL 23:59:59'
                    AND OR_order_activity.product_id = product_id
                    AND cargconc in (30,291)
                    AND ROWNUM = 1), 1, ((cargvalo/ventas)*-1), 0)) Int_Reportada,
        (select h.hcececac from open.hicaesco h
          where h.hcecnuse = product_id
            and h.hcecfech = (select max(st.hcecfech) from open.hicaesco st 
                               where st.hcecnuse =  product_id)) est_tecnico,                     
  from
       (
        select distinct ort.product_id, cargnuse, cargconc, cargcaca, cargvalo, ventas, SOLICITUD,
               (select l.celocebe
                  from open.GE_GEOGRA_LOCATION t, open.ldci_centbenelocal l
                 where geograp_location_id = (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi)
                   and t.geo_loca_father_id = l.celodpto
                   and t.geograp_location_id = celoloca) CEBE,
               (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi) LOCA,
               96 EST_TECNICO, st.escodesc DES_TECNICO, sesucate, mo.package_type_id TIPO_SOLICITUD/*,
               (decode((SELECT 1
                          FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                         WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                           AND OR_related_order.related_order_id = OR_order_activity.order_id
                           AND OR_order_activity.Status = 'F'
                           AND OR_order_activity.package_id = mo_packages.package_id
                           AND OR_order_activity.task_type_id in (10622, 10624)
                           AND mo_packages.package_type_id in (323, 100229)
                           AND OR_order.order_id = OR_related_order.related_order_id
                           AND OR_order.legalization_date >= '09-02-2015' 
                           AND OR_order.legalization_date <= '&FECHA_FINAL 23:59:59'
                           AND OR_order_activity.product_id = cargnuse
                           AND cargconc in (30,291)
                           AND ROWNUM = 1), 1, cargvalo, 0)) Int_Reportada*/
          from
               (select cargnuse, cargconc, cargcaca, cargvalo, substr(cargdoso, 4, 8) SOLICITUD,
                              (select count(*) from open.or_order_activity act
                                where act.package_id = substr(cargdoso, 4, 8)
                                  and act.task_type_id in (12150, 12152, 12153)
                                  and act.order_id not in (select oro.related_order_id from open.or_related_order oro 
                                                            where oro.related_order_id = act.order_id)) VENTAS
                  from open.cargos, open.servsusc
                 where cargcuco != -1
                   and cargnuse =  sesunuse
                   and sesuserv =  6121
                   and cargfecr >= '01-07-2015' --'09-02-2015'
                   and cargfecr <= '&FECHA_FINAL 23:59:59'
                   and substr(cargdoso,1,3) = 'PP-'
                   and cargconc in (19,30,674,291)
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
/*           and ort.product_id not in (select hi.hcecnuse from open.hicaesco hi
                                       where hi.hcececan = 96 and hi.hcececac = 1
                                         and hi.hcecfech >= '09-02-2015' and hi.hcecfech <= '&FECHA_FINAL 23:59:59'
                                         and hi.hcecserv = 7014)*/
           and 96 = st.escocodi
           and mo.package_id =  ort.package_id
       )
group by cebe, loca, product_id, cargconc, cargvalo, ventas, EST_TECNICO, DES_TECNICO, sesucate, --o.concdesc,
         /*((int_reportada/ventas)*-1),*/ TIPO_SOLICITUD)
