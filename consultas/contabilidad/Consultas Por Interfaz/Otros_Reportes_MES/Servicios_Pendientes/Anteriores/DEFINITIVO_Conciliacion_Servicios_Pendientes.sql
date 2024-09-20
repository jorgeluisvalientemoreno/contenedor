-- CONCILIACION MES ANTERIOR
SELECT SALDO, TIPO, DEPA,
       (SELECT de.description FROM open.ge_geogra_location de WHERE de.geograp_location_id = DEPA) descripcion_departamento,
       LOCA,
       (SELECT lo.description FROM open.ge_geogra_location lo WHERE lo.geograp_location_id = loca) descripcion,
       NUSE
       ,CONCEPTO, (select co.concdesc from open.concepto co where co.conccodi = concepto) CONCDESC
       ,SOLICITUD,
       TIPO_SOLICITUD,(SELECT ts.description FROM open.ps_package_type ts WHERE ts.package_type_id = TIPO_SOLICITUD) descripcion_tipo_solicitud
       ,FEC_VENTA, FEC_CARGO, nvl(TOTAL,0) TOTAL,
       CONECTADO, DECODE(NVL(ING_REPORT_MES,0), 0, (DECODE(CONECTADO, 1,-TOTAL))) VR_CONECTADO,
       (DECODE(CONECTADO, 110, -TOTAL)) VR_ANULADO,
       (DECODE(CONECTADO, 110, 0, NOTAS_MES)) NOTAS_MES,
       (CASE WHEN nvl(TOTAL,0) > 0 THEN
           ING_REPORT_MES
         ELSE
           0
           END) ING_REPORT_MES
 FROM
      (
       select SALDO, TIPO, DEPA, LOCA, NUSE, CONCEPTO, /*CONCDESC,*/  SOLICITUD,
       TIPO_SOLICITUD,
       FEC_VENTA, FEC_CARGO, TOTAL,
       -- PRODUCTOS CONECTADOS O ANULADOS EN EL MES DE PROCESO
       (select hcececac from open.hicaesco h
         where h.hcecnuse = nuse
           and h.hcececac in (1,110)
           and h.hcecfech >= '01-03-2017 00:00:00' -- fecha inicial del mes de proceso
           and h.hcecfech <= '31-03-2017 23:59:59' -- fecha final del mes de proceso
           and rownum = 1) CONECTADO,
       -- NOTAS DEL MES DE PROCESO
       (select sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo,cargvalo*-1)) valor
          from open.cargos c
         where c.cargnuse = nuse
           and c.cargconc = concepto
           and c.cargfecr between '01-03-2017 00:00:00' -- fecha inicial del mes de proceso
                              and '31-03-2017 23:59:59' -- fecha final del mes de proceso
           and CARGCUCO > 0
           and cargtipr = 'P'
           and cargsign NOT IN ('PA','AP')
           and substr(cargdoso,1,1) IN ('N')
           and cargcaca not in (20,23,46,50,51,56,73)
        group by cargnuse) NOTAS_MES, ING_REPORT_MES
from

(
--
-- ------------------------------------
-- CONSULTA PARA HAYAR EL SALDO ANTERIOR.
-- ------------------------------------
--
SELECT *
  FROM
       (
        SELECT 'SALDO_INICIAL' SALDO, TIPO, DEPA, LOCA, NUSE, CONCEPTO, --CONCDESC,
               SOLICITUD, TIPO_SOLICITUD,
               trunc(FEC_VENTA) FEC_VENTA, FEC_CARGO,
               (NVL(VR_INGRESO,0)+NVL(ING_REPORTADO,0)+NVL(NOTAS,0)) TOTAL, ING_REPORTADO,  ING_REPORT_MES
          from
               (
                select TIPO, DEPA, LOCA, NUSE, CONCEPTO, /*CONCDESC,*/ VR_INGRESO, SOLICITUD,
                TIPO_SOLICITUD,
                (select distinct mo.request_date from open.or_order_activity at,open.mo_packages mo
                  where at.product_id = nuse and at.package_id = mo.package_id and mo.package_type_id = tipo_solicitud) Fec_Venta,
                fec_cargo, ING_REPORTADO,
                (select sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, cargvalo*-1)) valor
                   from open.cargos c
                  where c.cargnuse = nuse
                    and c.cargconc = concepto
                    and c.cargfecr between '09-02-2015'          -- fecha fija
                                       and '28-02-2017 23:59:59' -- fecha final mes anterior
                    and CARGCUCO > 0
                    and cargtipr = 'P'
                    and cargsign NOT IN ('PA','AP')
                    and substr(cargdoso,1,1) IN ('N')
                    and cargcaca not in (20,23,46,50,51,56,73)
                 group by cargnuse) NOTAS, ING_REPORT_MES
            from
                 (
                   select 'PROD_MIGRADOS' TIPO,
                          CEBE, (select g.geo_loca_father_id from open.ge_geogra_location g
                                  where g.geograp_location_id = loca) DEPA,
                          LOCA, (select g.description from open.ge_geogra_location g
                                  where g.geograp_location_id = loca) DESCRIPCION,
                          invmsesu NUSE,  sesucate CATE, EST_TECNICO, DES_TECNICO,
                          invmconc CONCEPTO, --o.concdesc,
                          --decode(invmconc,19, 'CAR_X_CON.',
                          --                30, 'INT_RESID.',
                          --                291,'INT_INDUS.',
                          --                674,'REV_PREVIA',
                          --                    'NO_EXISTE') concdesc,
                          invmvain VR_INGRESO,
                          (select distinct mo.package_id from open.or_order_activity at, open.mo_packages mo
                            where at.product_id = invmsesu
                              and at.package_id = mo.package_id
                              and mo.package_type_id = 100271) Solicitud,
                          100271 TIPO_SOLICITUD, null fec_cargo, ING_REPORTADO,
                          -- INGRESO REPORTADO MES DE PROCESO
                          decode((SELECT 1
                                    FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                                   WHERE OR_related_order.rela_order_type_id in (4, 13) --Tipo de Orden, de Apoyo o Relacionada
                                     AND OR_related_order.related_order_id = OR_order_activity.order_id
                                     AND OR_order_activity.Status = 'F'
                                     AND OR_order_activity.package_id = mo_packages.package_id
                                     AND OR_order.task_type_id in (10622, 10624)
                                     AND mo_packages.package_type_id in (100271)
                                     AND OR_order.order_id = OR_related_order.related_order_id
                                     AND OR_order.legalization_date >= '01-03-2017 00:00:00' -- fecha inicial del mes de proceso
                                     AND OR_order.legalization_date <= '31-03-2017 23:59:59' -- fecha final del mes de proceso
                                     AND OR_order_activity.product_id = invmsesu
                                     AND invmconc = 30
                                     AND ROWNUM = 1), 1, -invmvain , 0) ING_REPORT_MES
                    from (
                          select (select l.celocebe
                                    from open.GE_GEOGRA_LOCATION t, open.ldci_centbenelocal l
                                   where geograp_location_id = (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS
                                                                 where address_id = susciddi)
                                     and t.geo_loca_father_id = l.celodpto
                                     and t.geograp_location_id = celoloca) CEBE,
                                 (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi) LOCA,
                                 m.invmsesu, m.invmconc , m.invmvain, sesucate, 96 EST_TECNICO, st.escodesc DES_TECNICO,
                                 decode((SELECT 1
                                           FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                                          WHERE OR_related_order.rela_order_type_id in (4, 13)-- Tipo de Orden, de Apoyo o Relacionada
                                            AND OR_related_order.related_order_id = OR_order_activity.order_id
                                            AND OR_order_activity.Status = 'F'
                                            AND OR_order_activity.package_id = mo_packages.package_id
                                            AND OR_order.task_type_id in (10622, 10624)
                                            AND mo_packages.package_type_id in (100271)
                                            AND OR_order.order_id = OR_related_order.related_order_id
                                            AND OR_order.legalization_date >= '09-02-2015' -- fecha fija
                                            AND OR_order.legalization_date <= '28-02-2017 23:59:59' -- fecha final mes anterior
                                            AND OR_order_activity.product_id = m.invmsesu
                                            AND m.invmconc = 30
                                            AND ROWNUM = 1), 1, -m.invmvain, 0) ING_REPORTADO
                            from open.ldci_ingrevemi m, open.servsusc v, open.suscripc s, open.estacort st
                           where m.invmsesu  not in (select h.hcecnuse from open.hicaesco h
                                                      where h.hcececan =  96
                                                        and h.hcececac =  1 and hcecserv = 7014
                                                        and h.hcecfech <= '28-02-2017 23:59:59' -- fecha final mes anterior
                                                        and h.hcecnuse = m.invmsesu)
                             and m.invmsesu  = v.sesunuse
                             and v.sesususc  = s.susccodi
                             and 96 = st.escocodi
                           )

--
--
UNION ALL
--
-- VENTAS CON PRODUCTOS CREADOS
--
select TIPO, CEBE, DEPA, LOCA, DESCRIPCION, NUSE, CATE, EST_TECNICO,
       DES_TECNICO, CONCEPTO, /*CONCDESC,*/ VR_INGRESO,
       SOLICITUD, TIPO_SOLICITUD, FEC_CARGO, ING_REPORTADO, INGRESO_MES --
 from (
       select 'CON_PRODUCTOS' TIPO, cebe,
              (select g.geo_loca_father_id from open.ge_geogra_location g where g.geograp_location_id = loca) DEPA,
              loca, (select g.description from open.ge_geogra_location g
                      where g.geograp_location_id = loca) DESCRIPCION,
              product_id NUSE, sesucate CATE,
              EST_TECNICO, (select st.escodesc from open.estacort st where st.escocodi = EST_TECNICO) DES_TECNICO,
              cargconc CONCEPTO, --o.concdesc,
              --decode(cargconc,19, 'CAR_X_CON.',
              --                30, 'INT_RESID.',
              --               291,'INT_INDUS.',
              --               674,'REV_PREVIA','NO_EXISTE') concdesc,
              sum((cargvalo/ventas)) VR_INGRESO, TO_NUMBER(SOLICITUD) SOLICITUD,
              TIPO_SOLICITUD, fec_cargo,
              (decode((SELECT 'X'
                         FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                        WHERE OR_related_order.rela_order_type_id in (4, 13) --Tipo de Orden, de Apoyo o Relacionada
                          AND OR_related_order.related_order_id = OR_order_activity.order_id
                          AND OR_order_activity.Status = 'F'
                          AND OR_order_activity.package_id = mo_packages.package_id
                          AND OR_order.task_type_id in (10622, 10624)
                          AND mo_packages.package_type_id in (323)
                          AND OR_order.order_id = OR_related_order.related_order_id
                          AND OR_order.legalization_date >= '09-02-2015' -- fecha fija
                          AND OR_order.legalization_date <= '28-02-2017 23:59:59' -- Fecha cierre mes anterior
                          AND OR_order_activity.product_id = xx.product_id
                          AND cargconc in (select conccodi from open.concepto co where co.concclco in (19)) -- in (30,291)
                          AND ROWNUM = 1), 'X', ((cargvalo/ventas)*-1), 0)) ING_REPORTADO,
               -- NUevo
              (decode((SELECT 'X'
                         FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                        WHERE OR_related_order.rela_order_type_id in (4, 13) --Tipo de Orden, de Apoyo o Relacionada
                          AND OR_related_order.related_order_id = OR_order_activity.order_id
                          AND OR_order_activity.Status = 'F'
                          AND OR_order_activity.package_id = mo_packages.package_id
                          AND OR_order.task_type_id in (10622, 10624)
                          AND mo_packages.package_type_id in (323)
                          AND OR_order.order_id = OR_related_order.related_order_id
                          AND OR_order.legalization_date >= '01-03-2017' -- fecha fija
                          AND OR_order.legalization_date <= '31-03-2017 23:59:59'
                          AND OR_order_activity.product_id = xx.product_id
                          AND cargconc in (select conccodi from open.concepto co where co.concclco in (19)) -- in (30,291)
                          AND ROWNUM = 1), 'X', ((cargvalo/ventas)*-1), 0)) INGRESO_MES
  from
       (
        select distinct ort.product_id, cargnuse, cargconc, cargcaca,
               cargvalo, ventas, SOLICITUD,
               (select l.celocebe
                  from open.GE_GEOGRA_LOCATION t, open.ldci_centbenelocal l
                 where geograp_location_id = (select GEOGRAP_LOCATION_ID
                                               from OPEN.AB_ADDRESS where address_id = susciddi)
                   and t.geo_loca_father_id = l.celodpto
                   and t.geograp_location_id = celoloca) CEBE,
               (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi) LOCA,
               (select h.hcececac from open.hicaesco h
                 where h.hcecnuse = product_id
                   and h.hcecfech = (select max(st.hcecfech) from open.hicaesco st
                                      where st.hcecnuse = product_id
                                        and st.hcecfech <= '28-02-2017 23:59:59')) est_tecnico,
               sesucate, mo.package_type_id TIPO_SOLICITUD, fec_cargo
          from
               (select cargnuse, cargconc, cargcaca, cargvalo, substr(cargdoso, 4, 8) SOLICITUD, trunc(cargfecr) fec_cargo,
                       -- CALCULO DE NUMERO DE APTOS
                       (select count(*) from open.or_order_activity act, open.or_order oo
                         where act.package_id = substr(cargdoso, 4, 8)
                           and act.order_id      =  oo.order_id
                           and oo.created_date  <= '31-03-2017 23:59:59' -- fecha final del mes de proceso
                           and (oo.task_type_id in (12150, 12152, 12153)
                                OR (oo.task_type_id = 12149
                                    and act.package_id not in (select att.package_id 
                                                                from open.or_order_activity att, open.or_order oo
                                                                where att.package_id = substr(cargdoso,4,8)
                                                                  and att.order_id = oo.order_id
                                                                  and oo.task_type_id in (12150, 12152, 12153))
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
                                                     where oro.related_order_id = act.order_id)) Productos
                  from open.cargos, open.servsusc, OPEN.CUENCOBR, OPEN.FACTURA
                 where cargcuco != -1
                   and cargnuse = sesunuse
                   and sesuserv =  6121
                   and CARGCUCO = CUCOCODI
                   and factcodi = CUCOfact
                   and FACTFEGE BETWEEN '09-02-2015 00:00:00' -- fecha fija
                                    and '28-02-2017 23:59:59' -- fecha final mes anterior
                   and substr(cargdoso,1,3) = 'PP-'
                   and cargconc in (select conccodi from open.concepto co where co.concclco in (4,19,400)) --(19,30,674,291)
               ), open.or_order_activity ort, open.suscripc c, open.servsusc s, open.mo_packages mo
         where VENTAS > 0
           AND VENTAS = PRODUCTOS
           AND ort.package_id = solicitud
           and ort.subscription_id = susccodi
           and ort.product_id = sesunuse
           and ort.task_type_id in (12149, 12150, 12152, 12153, 12162)
           and mo.package_id =  ort.package_id
           AND (
                mo.motive_status_id not in (5,26,32,40,45) 
               OR
                (mo.motive_status_id in (5,26,32,40,45) AND 
                  (select nvl(annul_date, '31-12-3000') from open.mo_motive mt
                     where mt.package_id  = solicitud
                       and mt.product_type_id = 6121) > '31-03-2017 23:59:59'
                ) -- fecha final del mes de proceso
               )       
           and ort.product_id not in (select h.hcecnuse from open.hicaesco h
                                       where h.hcecnuse = ort.product_id
                                         and h.hcececac = 1 and h.hcecfech <= '28-02-2017 23:59:59') -- fecha final mes anterior
       ) xx
group by cebe, loca, product_id, cargconc, cargvalo, ventas, EST_TECNICO, sesucate, SOLICITUD, TIPO_SOLICITUD, fec_cargo
)
--
--
UNION
--
-- VENTAS SIN PRODUCTOS CREADOS
select 'SIN_PRODUCTOS' TIPO,
       CEBE, (select g.geo_loca_father_id from open.ge_geogra_location g
               where g.geograp_location_id = loca) DEPA,
       LOCA, (select g.description from open.ge_geogra_location g where g.geograp_location_id = loca) DESCRIPCION,
       cargnuse NUSE, CATE, -1 EST_TECNICO, DES_TECNICO, cargconc CONCEPTO,
       --decode(cargconc,19, 'CAR_X_CON.',
       --                30, 'INT_RESID.',
       --                291,'INT_INDUS.',
       --                674,'REV_PREVIA','NO_EXISTE') concdesc,
       cargvalo VR_INGRESO, SOLICITUD, TIPO_SOLICITUD, fec_cargo, 
       -- NUevo
      (decode((SELECT 'X'
                 FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                WHERE OR_related_order.rela_order_type_id in (4, 13) --Tipo de Orden, de Apoyo o Relacionada
                  AND OR_related_order.related_order_id = OR_order_activity.order_id
                  AND OR_order_activity.Status = 'F'
                  AND OR_order_activity.package_id = mo_packages.package_id
                  AND OR_order.task_type_id in (10622, 10624)
                  AND mo_packages.package_type_id in (323, 100229)
                  AND OR_order.order_id = OR_related_order.related_order_id
                  AND OR_order.legalization_date >= '09-02-2015' -- fecha fija
                  AND OR_order.legalization_date <= '31-03-2017 23:59:59'
                  AND OR_order_activity.product_id = cargnuse
                  AND cargconc in (select conccodi from open.concepto co where co.concclco in (19)) -- in (30,291)
                  AND ROWNUM = 1), 'X', ((cargvalo/ventas)*-1), 0)) ING_REPORTADO,
                  0 INGRESO_MES
       --
       --, ventas
  from (
        select (select l.celocebe
                  from open.GE_GEOGRA_LOCATION t, open.ldci_centbenelocal l
                 where geograp_location_id = (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi)
                   and t.geo_loca_father_id = l.celodpto
                   and t.geograp_location_id = celoloca) CEBE,
               (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi) LOCA,
               trunc(cargfecr) fec_cargo,
               cargnuse, -1 CATE, 'SIN CREAR PRODUCTOS' DES_TECNICO,
               cargconc, cargvalo,
               mo.package_id SOLICITUD, package_type_id TIPO_SOLICITUD,
               -- NUMERO DE APTOS
               (select count(*) from open.or_order_activity act, open.or_order oo
                 where act.package_id = substr(cargdoso, 4, 8)
                   and act.order_id      = oo.order_id
                   and oo.created_date  <= '31-03-2017 23:59:59' -- fecha final del mes de proceso
                   and (oo.task_type_id in (12150, 12152, 12153)
                        OR (oo.task_type_id = 12149
                            and act.package_id not in (select att.package_id from open.or_order_activity att, open.or_order oo
                                                        where att.package_id = substr(cargdoso,4,8)
                                                          and att.order_id = oo.order_id
                                                          and oo.task_type_id in (12150, 12152, 12153))
                           )
                       )
                   and act.order_id not in (select oro.related_order_id from open.or_related_order oro
                                             where oro.related_order_id = act.order_id)
               ) VENTAS,
               --
               (select count(distinct(act.product_id))
                  from open.or_order_activity act, open.or_order oo
                 where act.package_id = substr(cargdoso, 4, 8)
                   and act.order_id      =  oo.order_id
                   and oo.created_date  <= '31-03-2017 23:59:59' -- fecha final del mes de proceso
                   and (oo.task_type_id in (12150, 12152, 12153)
                        OR (oo.task_type_id = 12149
                            and act.package_id not in (select att.package_id from open.or_order_activity att, open.or_order oo
                                                        where att.package_id = substr(cargdoso,4,8)
                                                          and att.order_id = oo.order_id
                                                          and oo.task_type_id in (12150, 12152, 12153))
                           )
                       )
                   and act.order_id not in (select oro.related_order_id from open.or_related_order oro
                                             where oro.related_order_id = act.order_id)
               ) Productos
          from open.cargos, open.servsusc, open.suscripc, open.mo_packages mo, OPEN.CUENCOBR, OPEN.FACTURA
         where cargcuco != -1
           and cargnuse =  sesunuse
           and sesuserv =  6121
           and sesususc =  susccodi
           and CARGCUCO = CUCOCODI
           and factcodi = CUCOfact
           and FACTFEGE BETWEEN '09-02-2015 00:00:00' -- fecha fija
                            and '28-02-2017 23:59:59' -- fecha final mes anterior
           and substr(cargdoso,1,3) = 'PP-'
           and cargconc in (select conccodi from open.concepto co where co.concclco in (4,19,400)) --in (19,30,674,291)
           and substr(cargdoso, 4, 8) = mo.package_id
           AND (
                mo.motive_status_id not in (5,26,32,40,45) 
               OR
                (mo.motive_status_id in (5,26,32,40,45) AND 
                  (select nvl(annul_date, '31-12-3000') from open.mo_motive mt
                    where mt.package_id  = mo.package_id
                      and mt.product_type_id = 6121) > '31-03-2017 23:59:59'
                ) -- fecha final del mes de proceso
               )    
           and mo.package_type_id in (323/*, 100229*/)
       )
WHERE (VENTAS != PRODUCTOS or ventas = 0 or productos = 0)


)
where nuse not in (select h.hcecnuse from open.hicaesco h
                    where h.hcecfech <= '28-02-2017 23:59:59' -- fecha final mes anterior
                      and h.hcecnuse = nuse and h.hcececac  in (1,95,110))
)
)
--
UNION ALL
-- NOTAS DE CONSTRUCTORAS QUE YA TIENEN PRODUCTO SALDO ANTERIOR

--
select 'SALDO_INICIAL' SALDO, 'NOTAS_CONSTRUCT' TIPO, 
       (select gc.geo_loca_father_id from open.ge_geogra_location gc where gc.geograp_location_id = loca) DEPA, 
       --(select gc.description from open.ge_geogra_location gc
       --  where gc.geograp_location_id = (select gc.geo_loca_father_id from open.ge_geogra_location gc
       --                                   where gc.geograp_location_id = loca)) DESCRIPCION_DEPA, 
       LOCA, --(select gc.description from open.ge_geogra_location gc where gc.geograp_location_id = loca) DESCRIPCION,
       construct, concepto, --(select o.concdesc from open.concepto o where conccodi = concepto) desc_concepto,
       NULL, NULL, NULL, NULL, saldo, 0, 0
  from (
select construct, loca, concepto, (nvl(total,0) + nvl(tot_fac,0)) saldo
  from (
select construct, loca, concepto, total,  
       (select sum(decode(cargsign, 'DB', cargvalo, -cargvalo)) tot_gen
          from open.cargos cc, open.cuencobr, open.factura
         where cc.cargnuse = construct
           AND cucocodi = cargcuco
           AND factfege >= '01/09/2016' -- FECHA FIJA
           AND factfege <= to_Date('28-02-2017 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
           AND cucofact =  factcodi
           AND cargfecr <= to_Date('28-02-2017 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
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
       and cargconc in (select conccodi from open.concepto co where co.concclco in (4,19,400)) --in (19,30,674,291)
       and cargsign IN ('DB','CR')   
       and c.cargfecr between '01-09-2016 00:00:00' -- Fecha Fija
                          and '28-02-2017 23:59:59'
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
                                 where act.package_id = substr(cargdoso, 4, 8)
                                   and act.order_id      =  oo.order_id
                                   and oo.created_date  <= '28-02-2017 23:59:59' -- fecha final del mes de proceso
                                   and (oo.task_type_id in (12150, 12152, 12153)
                                        OR (oo.task_type_id = 12149
                                            and act.package_id not in (select att.package_id 
                                                                         from open.or_order_activity att, open.or_order oo
                                                                        where att.package_id = substr(cargdoso,4,8)
                                                                          and att.order_id = oo.order_id
                                                                          and oo.task_type_id in (12150, 12152, 12153))
                                           )
                                       )
                                   and act.order_id not in (select oro.related_order_id from open.or_related_order oro
                                                            where oro.related_order_id = act.order_id)
                               ) VENTAS,
                               (select count(distinct(act.product_id))
                                  from open.or_order_activity act, open.or_order oo
                                 where act.package_id = substr(cargdoso, 4, 8)
                                   and act.order_id      =  oo.order_id
                                   and oo.created_date  <= '28-02-2017 23:59:59' -- fecha final del mes de proceso
                                   and OO.task_type_id in (12150, 12152, 12153)
                                   and act.order_id not in (select oro.related_order_id from open.or_related_order oro
                                                             where oro.related_order_id = act.order_id)
                               ) Productos
                          from open.cargos, open.servsusc, OPEN.CUENCOBR, OPEN.FACTURA
                         where cargcuco != -1
                           and cargnuse = sesunuse
                           and sesuserv =  6121
                           and CARGCUCO = CUCOCODI
                           and factcodi = CUCOfact
                           and FACTFEGE BETWEEN '09-02-2015 00:00:00' -- fecha fija
                                            and '28-02-2017 23:59:59' -- fecha final mes anterior
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
                   and ort.product_id not in (select h.hcecnuse from open.hicaesco h
                                               where h.hcecnuse = ort.product_id
                                                 and h.hcececac in (/*1,*/110)
                                                 --and h.hcecfech >= '01-03-2017 00:00:00' -- fecha inicial del mes de proceso
                                                 and h.hcecfech <= '28-02-2017 23:59:59' -- fecha final del mes de proceso
                                                 and rownum = 1)                   
              )
      group by cargnuse, cargconc, susciddi
     ) 
  )
  ) where saldo != 0
--
-- FIN SALDO ANTERIOR
--------
--------
UNION
--------
--------
--
-- CONSULTA PARA HAYAR LAS VENTAS DEL MES.
--
select 'VENTAS_MES' SALDO, TIPO, DEPA, LOCA, NUSE, CONCEPTO, /*CONCDESC,*/ SOLICITUD, TIPO_SOLICITUD,
       FEC_CARGO FEC_VENTA, FEC_CARGO, VR_INGRESO TOTAL, ING_REPORTADO, INGRESO_MES
 from (
       -- CON PRODUCTOS CREADOS
       select  'CON_PRODUCTOS' TIPO,
               cebe, (select g.geo_loca_father_id from open.ge_geogra_location g
                       where g.geograp_location_id = loca) DEPA,
               loca, (select g.description from open.ge_geogra_location g where g.geograp_location_id = loca) DESCRIPCION,
               product_id NUSE, sesucate CATE,
               EST_TECNICO, (select st.escodesc from open.estacort st where st.escocodi = EST_TECNICO) DES_TECNICO,
               cargconc CONCEPTO, --o.concdesc,
               --decode(cargconc,19, 'CAR_X_CON.',
               --                30, 'INT_RESID.',
               --               291, 'INT_INDUS.',
               --               674, 'REV_PREVIA','NO_EXISTE') concdesc,
               sum((cargvalo/ventas)) VR_INGRESO, TO_NUMBER(SOLICITUD) SOLICITUD,
               TIPO_SOLICITUD, fec_cargo,
              (decode((SELECT 'X'
                         FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                        WHERE OR_related_order.rela_order_type_id in (4, 13) --Tipo de Orden, de Apoyo o Relacionada
                          AND OR_related_order.related_order_id = OR_order_activity.order_id
                          AND OR_order_activity.Status = 'F'
                          AND OR_order_activity.package_id = mo_packages.package_id
                          AND OR_order.task_type_id in (10622, 10624)
                          AND mo_packages.package_type_id in (323/*, 100229*/)
                          AND OR_order.order_id = OR_related_order.related_order_id
                          AND OR_order.legalization_date >= '09-02-2015' -- fecha fija
                          AND OR_order.legalization_date <= '28-02-2017 23:59:59' -- Fecha cierre anterior
                          AND OR_order_activity.product_id = xx.product_id
                          AND cargconc in (select conccodi from open.concepto co where co.concclco in (4,19,400)) -- in (30,291)
                          AND ROWNUM = 1), 'X', ((cargvalo/ventas)*-1), 0)) ING_REPORTADO,
               -- NUevo
              (decode((SELECT 'X'
                         FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                        WHERE OR_related_order.rela_order_type_id in (4, 13) --Tipo de Orden, de Apoyo o Relacionada
                          AND OR_related_order.related_order_id = OR_order_activity.order_id
                          AND OR_order_activity.Status = 'F'
                          AND OR_order_activity.package_id = mo_packages.package_id
                          AND OR_order.task_type_id in (10622, 10624)
                          AND mo_packages.package_type_id in (323, 100229)
                          AND OR_order.order_id = OR_related_order.related_order_id
                          AND OR_order.legalization_date >= '01-03-2017'
                          AND OR_order.legalization_date <= '31-03-2017 23:59:59'
                          AND OR_order_activity.product_id = xx.product_id
                          AND cargconc in (select conccodi from open.concepto co where co.concclco in (4,19,400)) -- in (30,291)
                          AND ROWNUM = 1), 'X', ((cargvalo/ventas)*-1), 0)) INGRESO_MES
               --
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
                                      where st.hcecnuse = product_id
                                        and st.hcecfech <= '31-03-2017 23:59:59')) -- fecha final del mes de proceso
               est_tecnico,
               sesucate, mo.package_type_id TIPO_SOLICITUD, fec_cargo
          from
               (select cargnuse, cargconc, cargcaca, cargvalo,
                       substr(cargdoso, 4, 8) SOLICITUD, trunc(cargfecr) fec_cargo,
                       -- NUMERO DE APTOS
                       (select count(*) from open.or_order_activity act, open.or_order oo
                         where act.package_id = substr(cargdoso, 4, 8)
                           and act.order_id      =  oo.order_id
                           and oo.created_date  <= '31-03-2017 23:59:59' -- fecha final del mes de proceso
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
                       ---
                       (select count(distinct(act.product_id))
                          from open.or_order_activity act, open.or_order oo
                        where act.package_id = substr(cargdoso, 4, 8)
                           and act.order_id  =  oo.order_id
                           and oo.created_date  <= '31-03-2017 23:59:59' -- fecha final del mes de proceso
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
                                                     where oro.related_order_id = act.order_id)) Productos
                  from open.cargos, open.servsusc, OPEN.CUENCOBR, OPEN.FACTURA
                 where cargcuco != -1
                   and cargnuse =  sesunuse
                   and sesuserv =  6121
                   and CARGCUCO =  CUCOCODI
                   and factcodi =  CUCOfact
                   and FACTFEGE BETWEEN '01-03-2017 00:00:00' -- fecha incial del mes de proceso
                                    and '31-03-2017 23:59:59' -- fecha final del mes de proceso
                   and cargconc in (select conccodi from open.concepto co where co.concclco in (4,19,400)) -- in (19,30,674,291)
                   and cargtipr =  'A'
                   and cargsign NOT IN ('PA','AP','SA')
                   and cargcaca in (41,53)
               ), open.or_order_activity ort, open.suscripc c, open.servsusc s, open.mo_packages mo
         where VENTAS         > 0
           AND VENTAS         = PRODUCTOS
           AND ort.package_id = solicitud
           and ort.subscription_id = susccodi
           and ort.product_id = sesunuse
           and ort.task_type_id in (12149, 12150, 12152, 12153, 12162)
           and mo.package_id  =  ort.package_id
           AND (
                mo.motive_status_id not in (5,26,32,40,45) 
               OR
                (mo.motive_status_id in (5,26,32,40,45) AND 
                  (select nvl(annul_date, '31-12-3000') from open.mo_motive mt
                     where mt.package_id  = mo.package_id
                       and mt.product_type_id = 6121) > '31-03-2017 23:59:59'
                ) -- fecha final del mes de proceso
               )         
           and ort.product_id not in (select h.hcecnuse from open.hicaesco h
                                       where h.hcecfech <= '28-02-2017 23:59:59' -- fecha final mes anterior
                                         and h.hcecnuse = ort.product_id and h.hcececac in (1))
       ) xx
group by cebe, loca, product_id, cargconc, cargvalo, ventas, EST_TECNICO, sesucate, SOLICITUD, TIPO_SOLICITUD, fec_cargo
--
--
UNION
--
-- VENTAS SIN PRODUCTOS CREADOS
select 'SIN_PRODUCTOS' TIPO,
       CEBE, (select g.geo_loca_father_id from open.ge_geogra_location g
               where g.geograp_location_id = loca) DEPA,
       LOCA, (select g.description from open.ge_geogra_location g where g.geograp_location_id = loca) DESCRIPCION,
       cargnuse NUSE, CATE, -1 EST_TECNICO, DES_TECNICO, cargconc CONCEPTO,
       --decode(cargconc,19, 'CAR_X_CON.',
       --                30, 'INT_RESID.',
       --                291,'INT_INDUS.',
       --                674,'REV_PREVIA','NO_EXISTE') concdesc,
       cargvalo VR_INGRESO, SOLICITUD, TIPO_SOLICITUD, fec_cargo,
      (decode((SELECT 'X'
                 FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                WHERE OR_related_order.rela_order_type_id in (4, 13) --Tipo de Orden, de Apoyo o Relacionada
                  AND OR_related_order.related_order_id = OR_order_activity.order_id
                  AND OR_order_activity.Status = 'F'
                  AND OR_order_activity.package_id = mo_packages.package_id
                  AND OR_order.task_type_id in (10622, 10624)
                  AND mo_packages.package_type_id in (323/*, 100229*/)
                  AND OR_order.order_id = OR_related_order.related_order_id
                  AND OR_order.legalization_date >= '09-02-2015' -- fecha fija
                  AND OR_order.legalization_date <= '28-02-2017 23:59:59' -- Fecha Cierre Anterior
                  AND OR_order_activity.product_id = cargnuse
                  AND cargconc in (select conccodi from open.concepto co where co.concclco in (4,19,400)) -- in (30,291)
                  AND ROWNUM = 1), 'X', ((cargvalo/ventas)*-1), 0)) ING_REPORTADO,
       -- NUevo
      (decode((SELECT 'X'
                 FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                WHERE OR_related_order.rela_order_type_id in (4, 13) --Tipo de Orden, de Apoyo o Relacionada
                  AND OR_related_order.related_order_id = OR_order_activity.order_id
                  AND OR_order_activity.Status = 'F'
                  AND OR_order_activity.package_id = mo_packages.package_id
                  AND OR_order.task_type_id in (10622, 10624)
                  AND mo_packages.package_type_id in (323/*, 100229*/)
                  AND OR_order.order_id = OR_related_order.related_order_id
                  AND OR_order.legalization_date >= '01-03-2017'
                  AND OR_order.legalization_date <= '31-03-2017 23:59:59'
                  AND OR_order_activity.product_id = cargnuse
                  AND cargconc in (select conccodi from open.concepto co where co.concclco in (4,19,400)) -- in (30,291)
                  AND ROWNUM = 1), 'X', ((cargvalo/ventas)*-1), 0)
      ) INGRESO_MES
       --0 ING_REPORTADO
 from (
        select (select l.celocebe
                  from open.GE_GEOGRA_LOCATION t, open.ldci_centbenelocal l
                 where geograp_location_id = (select GEOGRAP_LOCATION_ID
                                               from OPEN.AB_ADDRESS where address_id = susciddi)
                   and t.geo_loca_father_id = l.celodpto
                   and t.geograp_location_id = celoloca) CEBE,
               (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi) LOCA,
               trunc(cargfecr) fec_cargo,
               cargnuse, -1 CATE, 'SIN CREAR PRODUCTOS' DES_TECNICO, cargconc, cargvalo,
               mo.package_id SOLICITUD, package_type_id TIPO_SOLICITUD,
               -- NUMERO DE APTOS
               (select count(*) from open.or_order_activity act, open.or_order oo
                 where act.package_id = substr(cargdoso, 4, 8)
                   and act.order_id      = oo.order_id
                   and oo.created_date  <= '31-03-2017 23:59:59' -- fecha final del mes de proceso
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
               --
               (select count(distinct(act.product_id))
                  from open.or_order_activity act, open.or_order oo
                 where act.package_id = substr(cargdoso, 4, 8)
                   and act.order_id      =  oo.order_id
                   and oo.created_date  <= '31-03-2017 23:59:59' -- fecha final del mes de proceso
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
                   ) Productos
              from open.cargos, open.servsusc, open.suscripc, open.mo_packages mo, OPEN.CUENCOBR, OPEN.FACTURA
             where cargcuco != -1
               and cargnuse =  sesunuse
               and sesuserv =  6121
               and sesususc =  susccodi
               and CARGCUCO =  CUCOCODI
               and factcodi =  CUCOfact
               and FACTFEGE BETWEEN '01-03-2017 00:00:00' -- fecha inicial del mes de proceso
                                and '31-03-2017 23:59:59' -- fecha final del mes de proceso
               and cargconc in (select conccodi from open.concepto co where co.concclco in (4,19,400)) -- in (19,30,674,291)
               and substr(cargdoso, 4, 8) = mo.package_id
               AND (
                    mo.motive_status_id not in (5,26,32,40,45) 
                   OR
                    (mo.motive_status_id in (5,26,32,40,45) AND 
                      (select nvl(annul_date, '31-12-3000') from open.mo_motive mt
                         where mt.package_id  = mo.package_id
                           and mt.product_type_id = 6121) > '31-03-2017 23:59:59'
                    ) -- fecha final del mes de proceso
                   )
               and cargtipr =  'A'
               and cargsign NOT IN ('PA','AP','SA')
               and cargcaca in (41,53)
       )
WHERE (VENTAS != PRODUCTOS or ventas = 0 or productos = 0)
)
)
)
--
UNION ALL
--
-- NOTAS DE CONSTRUCTORAS QUE YA TIENEN PRODUCTO MES ACTUAL
--
select 'NOTAS_MES' SALDO, 'NOTAS_CONSTRUCT' TIPO, 
       (select gc.geo_loca_father_id from open.ge_geogra_location gc where gc.geograp_location_id = loca) DEPA, 
       (select gc.description from open.ge_geogra_location gc
         where gc.geograp_location_id = (select gc.geo_loca_father_id from open.ge_geogra_location gc
                                          where gc.geograp_location_id = loca)) DESCRIPCION_DEPA, 
       LOCA, (select gc.description from open.ge_geogra_location gc where gc.geograp_location_id = loca) DESCRIPCION,
       construct, concepto, (select o.concdesc from open.concepto o where conccodi = concepto) desc_concepto,
       NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, saldo, 0
  from (
select construct, loca, concepto, (nvl(total,0) + nvl(tot_fac,0)) saldo
  from (
select construct, loca, concepto, total,  
       (select sum(decode(cargsign, 'DB', cargvalo, -cargvalo)) tot_gen
          from open.cargos cc, open.cuencobr, open.factura
         where cc.cargnuse = construct
           AND cucocodi = cargcuco
           AND factfege >= '01/09/2016' -- FECHA FIJA
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
       and c.cargfecr between '01-03-2017 00:00:00' -- Fecha Fija
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
                                 where act.package_id   = substr(cargdoso, 4, 8)
                                   and act.order_id     =  oo.order_id
                                   and oo.created_date <= '31-03-2017 23:59:59' -- fecha final del mes de proceso
                                   and (oo.task_type_id in (12150, 12152, 12153)
                                        OR (oo.task_type_id = 12149
                                            and act.package_id not in (select att.package_id 
                                                                         from open.or_order_activity att, open.or_order oo
                                                                        where att.package_id = substr(cargdoso,4,8)
                                                                          and att.order_id   = oo.order_id
                                                                          and oo.task_type_id in (12150, 12152, 12153))
                                           )
                                       )
                                   and act.order_id not in (select oro.related_order_id from open.or_related_order oro
                                                            where oro.related_order_id = act.order_id)
                               ) VENTAS,
                               (select count(distinct(act.product_id))
                                  from open.or_order_activity act, open.or_order oo
                                 where act.package_id  = substr(cargdoso, 4, 8)
                                   and act.order_id    =  oo.order_id
                                   and oo.created_date <= '31-03-2017 23:59:59' -- fecha final del mes de proceso
                                   and OO.task_type_id in (12150, 12152, 12153)
                                   and act.order_id not in (select oro.related_order_id from open.or_related_order oro
                                                             where oro.related_order_id = act.order_id)
                               ) Productos
                          from open.cargos, open.servsusc, OPEN.CUENCOBR, OPEN.FACTURA
                         where cargcuco != -1
                           and cargnuse =  sesunuse
                           and sesuserv =  6121
                           and CARGCUCO =  CUCOCODI
                           and factcodi =  CUCOfact
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
                   and ort.product_id not in (select h.hcecnuse from open.hicaesco h
                                               where h.hcecnuse = ort.product_id
                                                 and h.hcececac in (1,110)
                                                 --and h.hcecfech >= '01-03-2017 00:00:00' -- fecha inicial del mes de proceso
                                                 and h.hcecfech <= '31-03-2017 23:59:59' -- fecha final del mes de proceso
                                                 and rownum = 1)                   
              )
      group by cargnuse, cargconc, susciddi
     ) 
  )
  ) where saldo != 0
