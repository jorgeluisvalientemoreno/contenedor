-- Servicios Pendientes noviembre
select *
  from (SELECT TIPO,
               CEBE,
               DESCRIPCION_CEBE,
               DEPA,
               DESCRIPCION_DEPARTAMENTO,
               LOCA,
               DESCRIPCION,
               NUSE,
               CATE,
               DESC_CATEGORIA,
               EST_TECNICO,
               DES_TECNICO,
               CONCDESC,
               VR_INGRESO,
               SOLICITUD,
               TIPO_SOLICITUD,
               descripcion_tipo_solicitud,
               FEC_VENTA,
               FEC_CARGO,
               ING_REPORTADO,
               NOTAS
          FROM (select TIPO,
                       CEBE,
                       (SELECT cb.cebedesc
                          FROM open.ldci_centrobenef cb
                         where cb.cebecodi = CEBE) descripcion_cebe,
                       DEPA,
                       (SELECT de.description
                          FROM open.ge_geogra_location de
                         WHERE de.geograp_location_id = DEPA) descripcion_departamento,
                       LOCA,
                       DESCRIPCION,
                       NUSE,
                       CATE,
                       Desc_categoria,
                       EST_TECNICO,
                       DES_TECNICO,
                       CONCDESC,
                       nvl(VR_INGRESO, 0) VR_INGRESO,
                       SOLICITUD,
                       TIPO_SOLICITUD,
                       (SELECT ts.description
                          FROM open.ps_package_type ts
                         WHERE ts.package_type_id = TIPO_SOLICITUD) descripcion_tipo_solicitud,
                       trunc(FEC_VENTA) FEC_VENTA,
                       FEC_CARGO,
                       nvl(ING_REPORTADO, 0) ING_REPORTADO,
                       nvl(NOTAS, 0) NOTAS
                  from (select TIPO,
                               CEBE,
                               DEPA,
                               LOCA,
                               DESCRIPCION,
                               NUSE,
                               CATE,
                               (select ct.catedesc
                                  from open.categori ct
                                 where ct.catecodi = cate) Desc_categoria,
                               EST_TECNICO,
                               DES_TECNICO,
                               CONCDESC,
                               VR_INGRESO,
                               SOLICITUD,
                               TIPO_SOLICITUD,
                               (select distinct mo.request_date
                                  from open.or_order_activity at,
                                       open.mo_packages       mo
                                 where at.product_id = nuse
                                   and at.package_id = mo.package_id
                                   and mo.package_type_id = tipo_solicitud) Fec_Venta,
                               fec_cargo,
                               ING_REPORTADO,
                               (select sum(decode(cargsign,
                                                  'DB',
                                                  cargvalo,
                                                  'AS',
                                                  cargvalo,
                                                  cargvalo * -1)) valor
                                  from open.cargos c
                                 where c.cargnuse = nuse
                                   and c.cargconc = concepto
                                   and c.cargfecr between '09-02-2015' -- FECHA FIJA
                                       and '31-03-2017 23:59:59'
                                   and CARGCUCO > 0
                                   and cargtipr = 'P'
                                   and cargsign NOT IN ('PA', 'AP')
                                   and substr(cargdoso, 1, 1) IN ('N')
                                   and cargcaca not in
                                       (20, 23, 46, 50, 51, 56, 73)
                                 group by cargnuse) NOTAS,
                               concepto
                          from (select 'PROD_MIGRADOS' TIPO,
                                       CEBE,
                                       (select g.geo_loca_father_id
                                          from open.ge_geogra_location g
                                         where g.geograp_location_id = loca) DEPA,
                                       LOCA,
                                       (select g.description
                                          from open.ge_geogra_location g
                                         where g.geograp_location_id = loca) DESCRIPCION,
                                       invmsesu NUSE,
                                       sesucate CATE,
                                       EST_TECNICO,
                                       DES_TECNICO,
                                       invmconc CONCEPTO, --o.concdesc,
                                       decode(invmconc,  19, 'CAR_X_CON.',
                                                         30, 'INT_RESID.',
                                                        758, 'INT_RESID.',
                                                        291, 'INT_INDUS.',
                                                        674, 'REV_PREVIA',
                                                        754, 'REV_PREVIA',
                                                             'NO_EXISTE') concdesc,
                                       invmvain VR_INGRESO,
                                       (select distinct mo.package_id
                                          from open.or_order_activity at,
                                               open.mo_packages       mo
                                         where at.product_id = invmsesu
                                           and at.package_id = mo.package_id
                                           and mo.package_type_id = 100271) Solicitud,
                                       100271 TIPO_SOLICITUD,
                                       null fec_cargo,
                                       ING_REPORTADO
                                  from (select (select l.celocebe
                                                  from open.GE_GEOGRA_LOCATION t,
                                                       open.ldci_centbenelocal l
                                                 where geograp_location_id =
                                                       (select GEOGRAP_LOCATION_ID
                                                          from OPEN.AB_ADDRESS
                                                         where address_id =
                                                               susciddi)
                                                   and t.geo_loca_father_id =
                                                       l.celodpto
                                                   and t.geograp_location_id =
                                                       celoloca) CEBE,
                                               (select GEOGRAP_LOCATION_ID
                                                  from OPEN.AB_ADDRESS
                                                 where address_id = susciddi) LOCA,
                                               m.invmsesu,
                                               m.invmconc,
                                               m.invmvain,
                                               sesucate,
                                               96 EST_TECNICO,
                                               st.escodesc DES_TECNICO,
                                               decode((SELECT 1
                                                        FROM open.OR_related_order,
                                                             open.OR_order_activity,
                                                             open.or_order,
                                                             open.mo_packages
                                                       WHERE OR_related_order.rela_order_type_id in (4, 13)
                                                            -- Tipo de Orden, de Apoyo o Relacionada
                                                         AND OR_related_order.related_order_id = OR_order_activity.order_id
                                                         AND OR_order_activity.Status = 'F'
                                                         AND OR_order_activity.package_id = mo_packages.package_id
                                                         AND OR_order.task_type_id in (10622, 10624)
                                                         AND mo_packages.package_type_id in (100271)
                                                         AND OR_order.order_id = OR_related_order.related_order_id
                                                         AND OR_order.legalization_date >= '09-02-2015' --FECHA FIJA
                                                         AND OR_order.legalization_date <= '31-03-2017 23:59:59'
                                                         AND OR_order_activity.product_id = m.invmsesu
                                                         AND m.invmconc = 30
                                                         AND ROWNUM = 1),
                                                      1,
                                                      -m.invmvain,
                                                      0) ING_REPORTADO
                                          from open.ldci_ingrevemi m,
                                               open.servsusc       v,
                                               open.suscripc       s,
                                               open.estacort       st
                                         where m.invmsesu not in
                                               (select h.hcecnuse
                                                  from open.hicaesco h
                                                 where h.hcececan = 96
                                                   and h.hcececac = 1
                                                   and hcecserv = 7014
                                                   and h.hcecfech <= '31-03-2017 23:59:59'
                                                   and h.hcecnuse = m.invmsesu)
                                           and m.invmsesu = v.sesunuse
                                           and v.sesususc = s.susccodi
                                           and 96 = st.escocodi)
                                union
                                -- VENTAS CON PRODUCTOS CREADOS
                                -- VENTAS CON PRODUCTOS CREADOS
                                select TIPO,
                                       CEBE,
                                       DEPA,
                                       LOCA,
                                       DESCRIPCION,
                                       NUSE,
                                       CATE,
                                       EST_TECNICO,
                                       DES_TECNICO,
                                       CONCEPTO,
                                       CONCDESC,
                                       VR_INGRESO,
                                       SOLICITUD,
                                       TIPO_SOLICITUD,
                                       FEC_CARGO,
                                       ING_REPORTADO
                                  from (select 'CON_PRODUCTOS' TIPO,
                                               cebe,
                                               (select g.geo_loca_father_id
                                                  from open.ge_geogra_location g
                                                 where g.geograp_location_id = loca) DEPA,
                                               loca,
                                               (select g.description
                                                  from open.ge_geogra_location g
                                                 where g.geograp_location_id = loca) DESCRIPCION,
                                               product_id NUSE,
                                               sesucate CATE,
                                               EST_TECNICO,
                                               (select st.escodesc
                                                  from open.estacort st
                                                 where st.escocodi = EST_TECNICO) DES_TECNICO,
                                               cargconc CONCEPTO, --o.concdesc,
                                               decode(cargconc,  19, 'CAR_X_CON.',
                                                                 30, 'INT_RESID.',
                                                                758, 'INT_RESID.',
                                                                291, 'INT_INDUS.',
                                                                674, 'REV_PREVIA',
                                                                754, 'REV_PREVIA',
                                                                     'NO_EXISTE') concdesc,
                                               sum((cargvalo / ventas)) VR_INGRESO,
                                               TO_NUMBER(SOLICITUD) SOLICITUD,
                                               TIPO_SOLICITUD,
                                               fec_cargo,
                                               (decode((SELECT 'X'
                                                         FROM open.OR_related_order,
                                                              open.OR_order_activity,
                                                              open.or_order,
                                                              open.mo_packages
                                                        WHERE OR_related_order.rela_order_type_id in (4, 13) --Tipo de Orden, de Apoyo o Relacionada
                                                          AND OR_related_order.related_order_id = OR_order_activity.order_id
                                                          AND OR_order_activity.Status = 'F'
                                                          AND OR_order_activity.package_id = mo_packages.package_id
                                                          AND OR_order.task_type_id in (10622, 10624)
                                                          AND mo_packages.package_type_id in (323)
                                                          AND OR_order.order_id = OR_related_order.related_order_id
                                                          AND OR_order.legalization_date >= '09-02-2015' --FECHA FIJA
                                                          AND OR_order.legalization_date <= '31-03-2017 23:59:59'
                                                          AND OR_order_activity.product_id =  xx.product_id
                                                          AND cargconc in (select conccodi from open.concepto co where co.concclco in (19)) -- in (30, 291)
                                                          AND ROWNUM = 1),
                                                       'X',
                                                       ((cargvalo / ventas) * -1),
                                                       0)) ING_REPORTADO
                                          from (select distinct ort.product_id,
                                                                cargnuse,
                                                                cargconc,
                                                                cargcaca,
                                                                cargvalo,
                                                                ventas,
                                                                SOLICITUD,
                                                                (select l.celocebe
                                                                   from open.GE_GEOGRA_LOCATION t,
                                                                        open.ldci_centbenelocal l
                                                                  where geograp_location_id =
                                                                        (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS
                                                                          where address_id = susciddi)
                                                                    and t.geo_loca_father_id = l.celodpto
                                                                    and t.geograp_location_id = celoloca) CEBE,
                                                                (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS
                                                                  where address_id =  susciddi) LOCA,
                                                                (select h.hcececac
                                                                   from open.hicaesco h
                                                                  where h.hcecnuse = product_id
                                                                    and h.hcecfech =
                                                                        (select max(st.hcecfech)
                                                                           from open.hicaesco st
                                                                          where st.hcecnuse = product_id
                                                                            and st.hcecfech <= '31-03-2017 23:59:59')) est_tecnico,
                                                                sesucate,
                                                                mo.package_type_id TIPO_SOLICITUD,
                                                                fec_cargo
                                                  from (select cargnuse,
                                                               cargconc,
                                                               cargcaca,
                                                               sum(cargvalo) cargvalo,
                                                               substr(cargdoso, 4, 8) SOLICITUD,
                                                               trunc(cargfecr) fec_cargo,
                                                               (select count(*)
                                                                  from open.or_order_activity act,
                                                                       open.or_order          oo
                                                                 where act.package_id = substr(cargdoso, 4, 8)
                                                                   and act.order_id = oo.order_id
                                                                   and oo.created_date <= '31-03-2017 23:59:59'
                                                                   and (oo.task_type_id in (12150, 12152, 12153) OR
                                                                       (oo.task_type_id = 12149 and
                                                                       act.package_id not in
                                                                       (select att.package_id
                                                                          from open.or_order_activity att,
                                                                               open.or_order          ot
                                                                         where att.package_id = act.package_id --substr(cargdoso,4,8)
                                                                           and att.order_id = ot.order_id
                                                                           and ot.task_type_id in (12150, 12152, 12153))))
                                                                   and act.order_id not in
                                                                       (select oro.related_order_id
                                                                          from open.or_related_order oro
                                                                         where oro.related_order_id = act.order_id)) VENTAS,
                                                               (select count(distinct(act.product_id))
                                                                  from open.or_order_activity act,
                                                                       open.or_order          oo
                                                                 where act.package_id = substr(cargdoso, 4, 8)
                                                                   and act.order_id = oo.order_id
                                                                   and oo.created_date <= '31-03-2017 23:59:59'
                                                                   and (oo.task_type_id in (12150, 12152, 12153) OR
                                                                       (oo.task_type_id = 12149 and
                                                                       act.package_id not in
                                                                       (select att.package_id
                                                                            from open.or_order_activity att,
                                                                                 open.or_order          ot
                                                                           where att.package_id = act.package_id --substr(cargdoso,4,8)
                                                                             and att.order_id = ot.order_id
                                                                             and ot.task_type_id in (12150, 12152, 12153))))
                                                                   and act.order_id not in
                                                                       (select oro.related_order_id
                                                                          from open.or_related_order oro
                                                                         where oro.related_order_id = act.order_id)) Productos
                                                          from open.cargos,
                                                               open.servsusc,
                                                               OPEN.CUENCOBR,
                                                               OPEN.FACTURA
                                                         where cargcuco != -1
                                                           and cargnuse = sesunuse
                                                           and sesuserv = 6121
                                                           and CARGCUCO = CUCOCODI
                                                           and factcodi = CUCOfact
                                                           and FACTFEGE BETWEEN to_date('09/02/2015 00:00:00', 'dd/mm/yyyy hh24:mi:ss') -- FECHA FIJA
                                                               and '31-03-2017 23:59:59'
                                                           and substr(cargdoso, 1, 3) = 'PP-'
                                                           and cargconc in (select conccodi from open.concepto co where co.concclco in (4,19,400)) -- in (19, 30, 674, 291)
                                                         group by cargnuse, cargconc, cargcaca, substr(cargdoso, 4, 8), trunc(cargfecr)),
                                                       open.or_order_activity ort,
                                                       open.suscripc c,
                                                       open.servsusc s,
                                                       open.mo_packages mo
                                                 where VENTAS > 0
                                                   AND VENTAS = PRODUCTOS
                                                   AND ort.package_id = solicitud
                                                   and ort.subscription_id = susccodi
                                                   and ort.product_id = sesunuse
                                                   and ort.task_type_id in (12149, 12150, 12152, 12153, 12162)
                                                   and mo.package_id = ort.package_id
                                                   --
                                                   AND (
                                                        mo.motive_status_id not in (5,26,32,40,45) 
                                                       OR
                                                        (mo.motive_status_id in (5,26,32,40,45) AND 
                                                          (select nvl(annul_date, '31-12-3000') from open.mo_motive mt
                                                            where mt.package_id  = mo.package_id
                                                              and mt.product_type_id = 6121) > '31-03-2017 23:59:59'
                                                        ) -- fecha final del mes de proceso
                                                       )
                                                   --
                                                   and ort.product_id not in (select h.hcecnuse
                                                                                from open.hicaesco h
                                                                               where h.hcecnuse = ort.product_id
                                                                                    --and h.hcececan = 96
                                                                                 and h.hcececac = 1
                                                                                 and h.hcecfech <= '31-03-2017 23:59:59')) xx
                                         group by cebe, loca, product_id, cargconc, cargvalo, ventas, EST_TECNICO, sesucate,
                                                  SOLICITUD, TIPO_SOLICITUD, fec_cargo)
                                --
                                UNION
                                -- VENTAS SIN PRODUCTOS CREADOS
                                -- VENTAS SIN PRODUCTOS CREADOS
                                select 'SIN_PRODUCTOS',
                                       CEBE,
                                       (select g.geo_loca_father_id
                                          from open.ge_geogra_location g
                                         where g.geograp_location_id = loca) DEPA,
                                       LOCA,
                                       (select g.description
                                          from open.ge_geogra_location g
                                         where g.geograp_location_id = loca) DESCRIPCION,
                                       cargnuse NUSE,
                                       CATE,
                                       -1 EST_TECNICO,
                                       DES_TECNICO,
                                       cargconc CONCEPTO,
                                       decode(cargconc,  19, 'CAR_X_CON.',
                                                         30, 'INT_RESID.',
                                                        758, 'INT_RESID.',
                                                        291, 'INT_INDUS.',
                                                        674, 'REV_PREVIA',
                                                        754, 'REV_PREVIA',
                                                             'NO_EXISTE')concdesc,
                                       sum(cargvalo) VR_INGRESO,
                                       SOLICITUD,
                                       TIPO_SOLICITUD,
                                       fec_cargo,
                                       --0              ING_REPORTADO
                                       (decode((SELECT 'X'
                                                 FROM open.OR_related_order,
                                                      open.OR_order_activity,
                                                      open.or_order,
                                                      open.mo_packages
                                                WHERE OR_related_order.rela_order_type_id in (4, 13) --Tipo de Orden, de Apoyo o Relacionada
                                                  AND OR_related_order.related_order_id = OR_order_activity.order_id
                                                  AND OR_order_activity.Status = 'F'
                                                  AND OR_order_activity.package_id = mo_packages.package_id
                                                  AND OR_order.task_type_id in (10622, 10624)
                                                  AND mo_packages.package_type_id in (323)
                                                  AND OR_order.order_id = OR_related_order.related_order_id
                                                  AND OR_order.legalization_date >= '09-02-2015' --FECHA FIJA
                                                  AND OR_order.legalization_date <= '31-03-2017 23:59:59'
                                                  AND OR_order_activity.product_id = cargnuse --xx.product_id
                                                  AND cargconc in (select conccodi from open.concepto co where co.concclco in (19)) -- (30, 291)
                                                  AND ROWNUM = 1),
                                               'X',
                                               ((sum(cargvalo) / ventas) * -1),
                                               0)) ING_REPORTADO
                                  from (select (select l.celocebe
                                                  from open.GE_GEOGRA_LOCATION t,
                                                       open.ldci_centbenelocal l
                                                 where geograp_location_id =
                                                       (select GEOGRAP_LOCATION_ID
                                                          from OPEN.AB_ADDRESS
                                                         where address_id = susciddi)
                                                   and t.geo_loca_father_id = l.celodpto
                                                   and t.geograp_location_id = celoloca) CEBE,
                                               (select GEOGRAP_LOCATION_ID
                                                  from OPEN.AB_ADDRESS
                                                 where address_id = susciddi) LOCA,
                                               trunc(cargfecr) fec_cargo,
                                               cargnuse,
                                               -1 CATE,
                                               'SIN CREAR PRODUCTOS' DES_TECNICO,
                                               cargconc,
                                               cargvalo,
                                               mo.package_id SOLICITUD,
                                               package_type_id TIPO_SOLICITUD,
                                               (select count(*)
                                                  from open.or_order_activity act,
                                                       open.or_order          oo
                                                 where act.package_id = substr(cargdoso, 4, 8)
                                                   and act.order_id = oo.order_id
                                                   and oo.created_date <= '31-03-2017 23:59:59'
                                                   and (oo.task_type_id in (12150, 12152, 12153) 
                                                      OR
                                                       (oo.task_type_id = 12149 and
                                                        act.package_id not in  (select att.package_id
                                                                                  from open.or_order_activity att,
                                                                                       open.or_order          ot
                                                                                 where att.package_id = substr(cargdoso, 4, 8)
                                                                                   and att.order_id = ot.order_id
                                                                                   and ot.task_type_id in (12150, 12152, 12153)))
                                                       )
                                                   and act.order_id not in
                                                       (select oro.related_order_id
                                                          from open.or_related_order oro
                                                         where oro.related_order_id =  act.order_id)) VENTAS,
                                               (select count(distinct(act.product_id))
                                                  from open.or_order_activity act,
                                                       open.or_order          oo
                                                 where act.package_id =  substr(cargdoso, 4, 8)
                                                   and act.order_id = oo.order_id
                                                   and oo.created_date <=  '31-03-2017 23:59:59'
                                                   and (oo.task_type_id in (12150, 12152, 12153) 
                                                      OR
                                                       (oo.task_type_id = 12149 and
                                                       act.package_id not in
                                                       (select att.package_id
                                                            from open.or_order_activity att,
                                                                 open.or_order          ot
                                                           where att.package_id = substr(cargdoso, 4, 8)
                                                             and att.order_id = ot.order_id
                                                             and ot.task_type_id in (12150, 12152, 12153))))
                                                   and act.order_id not in
                                                       (select oro.related_order_id
                                                          from open.or_related_order oro
                                                         where oro.related_order_id =
                                                               act.order_id)) Productos
                                          from open.cargos,
                                               open.servsusc,
                                               open.suscripc,
                                               open.mo_packages mo,
                                               OPEN.CUENCOBR,
                                               OPEN.FACTURA
                                         where cargcuco != -1
                                           and cargnuse = sesunuse
                                           and sesuserv = 6121
                                           and sesususc = susccodi
                                           and CARGCUCO = CUCOCODI
                                           and factcodi = CUCOfact
                                           and FACTFEGE BETWEEN to_date('09/02/2015 00:00:00', 'dd/mm/yyyy hh24:mi:ss') -- FECHA FIJA
                                               and '31-03-2017 23:59:59'
                                           and substr(cargdoso, 1, 3) = 'PP-'
                                           and cargconc in (select conccodi from open.concepto co where co.concclco in (4,19,400)) -- in (19, 30, 674, 291)
                                           and substr(cargdoso, 4, 8) = mo.package_id
                                           --
                                           AND (
                                                mo.motive_status_id not in (5,26,32,40,45) 
                                               OR
                                                (mo.motive_status_id in (5,26,32,40,45) AND 
                                                  (select nvl(annul_date, '31-12-3000') from open.mo_motive mt
                                                    where mt.package_id  = mo.package_id
                                                      and mt.product_type_id = 6121) > '31-03-2017 23:59:59'
                                                ) -- fecha final del mes de proceso
                                               )                                           
                                           --
                                           and mo.package_type_id in (323 /*, 100229*/))
                                 WHERE (VENTAS != PRODUCTOS or ventas = 0 or
                                       productos = 0)
                                 Group by CEBE, LOCA, cargnuse, CATE, -1, DES_TECNICO, cargconc, SOLICITUD, TIPO_SOLICITUD, fec_cargo, ventas)
                         where nuse not in
                               (select h.hcecnuse
                                  from open.hicaesco h
                                 where h.hcecfech <= '31-03-2017 23:59:59'
                                   and h.hcecnuse = nuse
                                   and h.hcececac in (1, 95, 110)))) /*PIVOT(MAX(VR_INGRESO) FOR CONCDESC IN('CAR_X_CON.',
                                                                                                             'INT_RESID.',
                                                                                                             'INT_INDUS.',
                                                                                                             'REV_PREVIA'))*/
        --where solicitud = 35920797
        -- order by cebe, loca, nuse
        --
        -- NOTAS DE CONSTRUCTORAS QUE YA TIENEN PRODUCTO
        --
        UNION ALL
        --
        --
        select tipo, cebe, descripcion_cebe, DEPA, DESCRIPCION_DEPA, loca, DESCRIPCION, 
               construct, null cate, null desc_cate, null tecn, null desc_tec, concdesc, null ingreso, null solicitud, 
               null t_soli, null desc_t_sol, null fec_v, null fec_c, null ing_r, notas
        from (
        select 'NOTAS_CONSTRUCT' TIPO, 
               (select cbl.celocebe from open.ldci_centbenelocal cbl where cbl.celoloca = Loca) CEBE, 
               (SELECT cb.cebedesc  FROM open.ldci_centrobenef cb
                 where cb.cebecodi in (select cbl.celocebe from open.ldci_centbenelocal cbl where cbl.celoloca = Loca)) descripcion_cebe,       
               (select gc.geo_loca_father_id from open.ge_geogra_location gc where gc.geograp_location_id = loca) DEPA, 
               (select gc.description from open.ge_geogra_location gc
                 where gc.geograp_location_id = (select gc.geo_loca_father_id from open.ge_geogra_location gc
                                                  where gc.geograp_location_id = loca)) DESCRIPCION_DEPA, 
               LOCA, (select gc.description from open.ge_geogra_location gc where gc.geograp_location_id = loca) DESCRIPCION,
               construct, NULL, NULL, NULL, NULL, concdesc,  NULL, NULL, NULL, NULL,  NULL, NULL, NULL, saldo notas
          from (
        select construct, loca, concepto, decode(concepto,  19, 'CAR_X_CON.',
                                                            30, 'INT_RESID.',
                                                           758, 'INT_RESID.',
                                                           291, 'INT_INDUS.',
                                                           674, 'REV_PREVIA',
                                                           754, 'REV_PREVIA',
                                                                'NO_EXISTE') concdesc,
               (nvl(total,0) + nvl(tot_fac,0)) saldo
          from (
        select construct, loca, concepto, total,  
               (select sum(decode(cargsign, 'DB', cargvalo, -cargvalo)) tot_gen
                  from open.cargos cc, open.cuencobr, open.factura
                 where cc.cargnuse = construct
                   AND cucocodi = cargcuco
                   AND factfege >= '01-09-2016 00:00:00' -- Fecha Fija..
                   AND factfege <= to_Date('31-03-2017 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
                   AND cucofact =  factcodi
                   AND cargfecr <= to_Date('31-03-2017 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
                   AND cargcuco >  0
                   AND cargtipr =  'A'
                   AND cargsign in ('DB','CR')
                   and cargconc in (select conccodi from open.concepto co where co.concclco in (4,19,400)) -- in (19,30,674)
                   and cargcaca = 15 -- Facturacion
                   and cargconc =concepto) tot_fac
        from 
            (
             select cargnuse construct, 
                    (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi) LOCA, 
                    cargconc concepto, sum(decode(cargsign, 'DB', cargvalo, -cargvalo)) Total
              from open.cargos c, open.servsusc sr, open.suscripc sc
             where cargcuco > 0
               and cargconc in (select conccodi from open.concepto co where co.concclco in (4,19,400)) -- in (19,30,674,291)
               and cargsign IN ('DB','CR')   
               and c.cargfecr between '01-09-2016 00:00:00' -- Fecha Fija
                                  and '31-03-2017 23:59:59'
               and cargtipr = 'P'
               and cargdoso LIKE ('N%')
               and cargcaca not in (20,23,46,50,51,56,73)
               and cargnuse = sesunuse
               and sesususc = susccodi
               and c.cargnuse in 
                       (select distinct cargnuse--, solicitud
                          from (
                                select cargnuse, substr(cargdoso, 4, 8) SOLICITUD,
                                       -- CALCULO DE NUMERO DE APTOS
                                       (select count(*) from open.or_order_activity act, open.or_order oo
                                         where act.package_id  =  substr(cargdoso, 4, 8)
                                           and act.order_id    =  oo.order_id
                                           and oo.created_date <= '31-03-2017 23:59:59' -- fecha final del mes de proceso
                                           and (oo.task_type_id in (12150, 12152, 12153)
                                                OR (oo.task_type_id = 12149
                                                    and act.package_id not in (select att.package_id
                                                                                 from open.or_order_activity att, open.or_order ot
                                                                                where att.package_id = substr(cargdoso,4,8)
                                                                                  and att.order_id = ot.order_id
                                                                                  and ot.task_type_id in (12150, 12152, 12153))
                                                   )
                                               )
                                           and act.order_id not in (select oro.related_order_id from open.or_related_order oro
                                                                    where oro.related_order_id = act.order_id)
                                       ) VENTAS,
                                       (select count(distinct(act.product_id))
                                          from open.or_order_activity act, open.or_order oo
                                         where act.package_id = substr(cargdoso, 4, 8)
                                           and act.order_id      =  oo.order_id
                                           and oo.created_date  <= '31-03-2017 23:59:59' -- fecha final del mes de proceso
                                           and oo.task_type_id in (12150, 12152, 12153)
                                           and act.order_id not in (select oro.related_order_id from open.or_related_order oro
                                                                     where oro.related_order_id = act.order_id)
                                       ) Productos
                                  from open.cargos, open.servsusc, OPEN.CUENCOBR, OPEN.FACTURA
                                 where cargcuco != -1
                                   and cargnuse = sesunuse
                                   and sesuserv = 6121
                                   and CARGCUCO = CUCOCODI
                                   and factcodi = CUCOfact
                                   and FACTFEGE BETWEEN '09-02-2015 00:00:00' -- fecha fija
                                                    and '31-03-2017 23:59:59' -- fecha final mes anterior
                                   and cargdoso like'PP%'
                                   and cargconc in (select conccodi from open.concepto co where co.concclco in (4,19,400)) -- in (19,30,674,291)
                               ), open.or_order_activity ort, open.mo_packages mo
                         where VENTAS > 0
                           AND VENTAS = PRODUCTOS
                           AND ort.package_id = solicitud
                           AND mo.package_id  = solicitud
                           AND (
                                mo.motive_status_id not in (5,26,32,40,45) 
                               OR
                                (mo.motive_status_id in (5,26,32,40,45) AND 
                                  (select nvl(annul_date, '31-12-3000') from open.mo_motive mt
                                     where mt.package_id  = solicitud
                                       and mt.product_type_id = 6121) > '31-03-2017 23:59:59'
                                ) -- fecha final del mes de proceso
                               )
                           and ort.task_type_id in (12149, 12150, 12152, 12153, 12162)
                          -- and ort.product_id not in (select h.hcecnuse from open.hicaesco h
                          --                             where h.hcecnuse = ort.product_id
                          --                               and h.hcececac in (1,110)
                          --                               and h.hcecfech <= '31-03-2017 23:59:59' -- fecha final del mes de proceso
                          --                               and rownum = 1)  
                       )
              group by cargnuse, cargconc, susciddi
             ) 
          )
          ) where saldo != 0
        )
        
        ) PIVOT(MAX(vr_ingreso) FOR concdesc IN('CAR_X_CON.',
                                                'INT_RESID.',
                                                'INT_INDUS.',
                                                'REV_PREVIA'))
 order by cebe, loca, nuse