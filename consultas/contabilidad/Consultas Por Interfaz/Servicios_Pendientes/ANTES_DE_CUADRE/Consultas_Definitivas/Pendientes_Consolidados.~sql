select * /*CEBE, DEPA, DESC_DEPA, LOCA, DESCRIPCION, PRODUCTO, CATE, DESC_CATEGORIA, EST_TECNICO, DES_TECNICO, 
       CONCDESC, VR_INGRESO, ING_REPORTADO, TIPO_SOLICITUD, DESC_SOLICITUD*/
FROM 
(       
select CEBE, 
       DEPA, (select DESCRIPTION from open.ge_geogra_location g where g.geograp_location_id = DEPA) DESC_DEPA,
       LOCA, DESCRIPCION, NUSE PRODUCTO, 
       CATE, (select c.catedesc from open.categori c where c.catecodi = CATE) DESC_CATEGORIA,
       TIPO_SOLICITUD, (select o.description from open.PS_PACKAGE_TYPE o where o.package_type_id = TIPO_SOLICITUD) DESC_SOLICITUD,
       EST_TECNICO, DES_TECNICO, CONCDESC, VR_INGRESO, ING_REPORTADO
  from
(
-- VENTAS MIGRADAS
select CEBE, (select g.geo_loca_father_id from open.ge_geogra_location g where g.geograp_location_id = loca) DEPA, 
       LOCA, (select g.description from open.ge_geogra_location g where g.geograp_location_id = loca) DESCRIPCION,
       invmsesu NUSE,  sesucate CATE, EST_TECNICO, DES_TECNICO, --invmconc CONCEPTO, --o.concdesc,
       decode(invmconc,19,'C_X_C',
                       30,'INT_RES',
                       137,'IVA_SV_16',
                       287,'IVA_OC_R_INT',
                       291,'INT_INDUS',
                       674,'REV_PREVIA','NO_EXISTE') concdesc,
       invmvain VR_INGRESO, 100271 TIPO_SOLICITUD, ING_REPORTADO
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
                      WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                        AND OR_related_order.related_order_id = OR_order_activity.order_id
                        AND OR_order_activity.Status = 'F'
                        AND OR_order_activity.package_id = mo_packages.package_id
                        AND OR_order_activity.task_type_id in (10622, 10624)
                        AND mo_packages.package_type_id in (323, 100271, 100229) 
                        AND OR_order.order_id = OR_related_order.related_order_id
                        AND OR_order.legalization_date < '01-05-2015'                  
                        AND OR_order_activity.product_id = m.invmsesu
                        AND m.invmconc = 30
                        AND ROWNUM = 1), 1, m.invmvain, 0) ING_REPORTADO
        from open.ldci_ingrevemi m, open.servsusc v, open.suscripc s, open.estacort st
       where m.invmsesu not in (select h.hcecnuse from open.hicaesco h
                                 where h.hcececan = 96
                                   and h.hcececac = 1  and hcecserv = 7014
                                   /*and h.hcecfech >= '09-02-2015'*/ and h.hcecfech < '01-05-2015'
                                   and h.hcecnuse = m.invmsesu)
         and m.invmsesu  = v.sesunuse
         and v.sesususc  = s.susccodi
         and 96 = st.escocodi
     )
---
UNION
--- VENTAS CON PRODUCTOS CREADOS
select * from
(
select  cebe, (select g.geo_loca_father_id from open.ge_geogra_location g where g.geograp_location_id = loca) DEPA, 
        loca, (select g.description from open.ge_geogra_location g where g.geograp_location_id = loca) DESCRIPCION,
        product_id NUSE, sesucate CATE, EST_TECNICO, DES_TECNICO, --cargconc CONCEPTO, --o.concdesc,
        decode(cargconc,19,'C_X_C',
                        30,'INT_RES',
                        137,'IVA_SV_16',
                        287,'IVA_OC_R_INT',
                        291,'INT_INDUS',
                        674,'REV_PREVIA','NO_EXISTE') concdesc,
        sum((cargvalo/ventas)) VR_INGRESO, TIPO_SOLICITUD, ((int_reportada/ventas)*-1) REPORTADO
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
                   and cargfecr <  '01-05-2015'
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
                                         /*and hi.hcecfech >= '09-02-2015'*/ and hi.hcecfech < '01-05-2015'
                                         and hi.hcecserv = 7014)
           and 96 = st.escocodi
           and mo.package_id =  ort.package_id
       )
group by cebe, loca, product_id, cargconc, cargvalo, ventas, EST_TECNICO, DES_TECNICO, sesucate, --o.concdesc, 
         ((int_reportada/ventas)*-1), TIPO_SOLICITUD
)
--
UNION
-- VENTAS SIN PRODUCTOS CREADOS
select CEBE, (select g.geo_loca_father_id from open.ge_geogra_location g where g.geograp_location_id = loca) DEPA,
       LOCA, (select g.description from open.ge_geogra_location g where g.geograp_location_id = loca) DESCRIPCION,
       cargnuse NUSE, CATE, -1 EST_TECNICO, DES_TECNICO, 
       decode(cargconc,19,'C_X_C',
                       30,'INT_RES',
                       137,'IVA_SV_16',
                       287,'IVA_OC_R_INT',
                       291,'INT_INDUS',
                       674,'REV_PREVIA','NO_EXISTE') concdesc,
       cargvalo VR_INGRESO, TIPO_SOLICITUD, 0 REPORTADA
  from (
        select (select l.celocebe 
                  from open.GE_GEOGRA_LOCATION t, open.ldci_centbenelocal l
                 where geograp_location_id = (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi)
                   and t.geo_loca_father_id = l.celodpto 
                   and t.geograp_location_id = celoloca) CEBE, 
               (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi) LOCA,
               cargnuse, -1 CATE, 'SIN CREAR PRODUCTOS' DES_TECNICO, cargconc, cargvalo, package_type_id TIPO_SOLICITUD 
          from open.cargos, open.servsusc, open.suscripc, open.mo_packages mo
         where cargnuse = sesunuse
           and sesuserv = 6121
           and sesususc = susccodi
           and cargfecr >= '09-02-2015'
           and cargfecr <  '01-05-2015'
           and substr(cargdoso,1,3) = 'PP-'
           and cargconc in (19,30,674,291,137,287)
           and substr(cargdoso, 4, 8) not in (select act.package_id from open.or_order_activity act, open.mo_packages m
                                               where act.package_id = substr(cargdoso, 4, 8)
                                                 and act.task_type_id in (12149, 12150, 12152, 12153)
                                                 and act.package_id = m.package_id
                                                 and m.package_type_id in (323, 100229))
           and substr(cargdoso, 4, 8) = mo.package_id
           and mo.package_type_id in (323, 100229)
       )
)
--order by cebe, loca, nuse
)
PIVOT
(
MAX(VR_INGRESO)
FOR CONCDESC IN ('C_X_C',
'INT_RES',
'IVA_SV_16',
'IVA_OC_RED_INT',
'INT_INDUS',
'REV_PREVIA')
)
