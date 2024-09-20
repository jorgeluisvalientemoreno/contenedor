-- VENTAS CON PRODUCTOS CREADOS
select TIPO, CEBE, DEPA, LOCA, DESCRIPCION, NUSE, CATE, EST_TECNICO, DES_TECNICO, CONCEPTO, CONCDESC, VR_INGRESO,
       SOLICITUD, TIPO_SOLICITUD, FEC_CARGO, ING_REPORTADO
 from
(
select  'CON_PRODUCTOS' TIPO, 
        cebe, (select g.geo_loca_father_id from open.ge_geogra_location g where g.geograp_location_id = loca) DEPA,
        loca, (select g.description from open.ge_geogra_location g where g.geograp_location_id = loca) DESCRIPCION,
        product_id NUSE, sesucate CATE, 
        EST_TECNICO, (select st.escodesc from open.estacort st where st.escocodi = EST_TECNICO) DES_TECNICO,
        cargconc CONCEPTO, --o.concdesc,
        decode(cargconc,19, 'CAR_X_CON.',
                        30, 'INT_RESID.',
                        291,'INT_INDUS.',
                        674,'REV_PREVIA','NO_EXISTE') concdesc,
        sum((cargvalo/ventas)) VR_INGRESO, TO_NUMBER(SOLICITUD) SOLICITUD, TIPO_SOLICITUD, fec_cargo,
        (decode((SELECT 'X'
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
                    AND OR_order_activity.product_id = xx.product_id
                    AND cargconc in (30,291)
                    AND ROWNUM = 1), 'X', ((cargvalo/ventas)*-1), 0)) ING_REPORTADO
  from
       (
        select distinct ort.product_id, cargnuse, cargconc, cargcaca, cargvalo, ventas, SOLICITUD,
               (select l.celocebe
                  from open.GE_GEOGRA_LOCATION t, open.ldci_centbenelocal l
                 where geograp_location_id = (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi)
                   and t.geo_loca_father_id = l.celodpto
                   and t.geograp_location_id = celoloca) CEBE,
               (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi) LOCA,
               (select h.hcececac from open.hicaesco h
                 where h.hcecnuse = product_id
                   and h.hcecfech = (select max(st.hcecfech) from open.hicaesco st 
                                      where st.hcecnuse = product_id and st.hcecfech <= '&FECHA_FINAL 23:59:59')) est_tecnico, 
               sesucate, mo.package_type_id TIPO_SOLICITUD, fec_cargo
          from
               (select cargnuse, cargconc, cargcaca, cargvalo, substr(cargdoso, 4, 8) SOLICITUD, trunc(cargfecr) fec_cargo,
                       (select count(*) from open.or_order_activity act, open.or_order oo
                         where act.package_id = substr(cargdoso, 4, 8)
                           and act.order_id      =  oo.order_id
                           and oo.created_date  <= '&FECHA_FINAL 23:59:59'                            
                           and act.task_type_id in (12150, 12152, 12153)
                           and act.order_id not in (select oro.related_order_id from open.or_related_order oro 
                                                    where oro.related_order_id = act.order_id)) VENTAS,
                       (select count(distinct(act.product_id))
                          from open.or_order_activity act, open.or_order oo
                         where act.package_id = substr(cargdoso, 4, 8)
                           and act.order_id      =  oo.order_id
                           and oo.created_date  <= '&FECHA_FINAL 23:59:59'
                           and act.task_type_id in (12150, 12152, 12153)
                           and act.order_id not in (select oro.related_order_id from open.or_related_order oro 
                                                     where oro.related_order_id = act.order_id)) Productos   
                  from open.cargos, open.servsusc
                 where cargcuco != -1
                   and cargnuse = sesunuse
                   and sesuserv =  6121
                   and cargfecr >= '01-05-2015'
                   and cargfecr <= '&FECHA_FINAL 23:59:59'
                   and substr(cargdoso,1,3) = 'PP-'
                   --and cargdoso = 'PP-16080943'
                   and cargconc in (19,30,674,291)
               ), open.or_order_activity ort, open.suscripc c, open.servsusc s, open.mo_packages mo
         where VENTAS > 0
           AND VENTAS = PRODUCTOS
           AND ort.package_id = solicitud
           and ort.subscription_id = susccodi
           and ort.product_id = sesunuse
           and ort.task_type_id in (12149, 12150, 12152, 12153, 12162)
           and mo.package_id =  ort.package_id
           and ort.product_id not in (select h.hcecnuse from open.hicaesco h 
                                       where h.hcecnuse = ort.product_id
                                         and h.hcececan = 96
                                         and h.hcececac = 1 and h.hcecfech <= '&FECHA_FINAL 23:59:59')
       ) xx
group by cebe, loca, product_id, cargconc, cargvalo, ventas, EST_TECNICO, sesucate, SOLICITUD, TIPO_SOLICITUD, fec_cargo
)
