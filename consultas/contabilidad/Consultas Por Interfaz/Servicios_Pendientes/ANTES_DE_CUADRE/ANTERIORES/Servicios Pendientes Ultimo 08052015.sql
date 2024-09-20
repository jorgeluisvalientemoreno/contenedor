-- Consolidado SERVICIOS PENDIENTES
SELECT * FROM (
select cebe,  
       DEPA, (select g.description from open.ge_geogra_location g
               where g.geograp_location_id = (select g.geo_loca_father_id from open.ge_geogra_location g 
                                               where g.geograp_location_id = loca)) DESC_DEPA,
       LOCA, DESCRIPCION, nuse, 
       cate, (select c.catedesc from open.categori c where c.catecodi = cate) DESC_CATEGORIA,
       est_tecnico, DES_TECNICO, 
       TIPO_SOLICITUD, (select o.description from open.PS_PACKAGE_TYPE o where o.package_type_id = TIPO_SOLICITUD) DESC_SOLICITUD,
       concdesc, vr_ingreso, ING_REPORTADO from
(
select CEBE, (select g.geo_loca_father_id from open.ge_geogra_location g where g.geograp_location_id = loca) DEPA,
       LOCA, (select g.description from open.ge_geogra_location g where g.geograp_location_id = loca) DESCRIPCION,
       invmsesu NUSE,  sesucate CATE, EST_TECNICO, DES_TECNICO, invmconc CONCEPTO,
       decode(invmconc,19,'C_X_C',30,'INT_RESID',137,'IVA_S_V_16',
                       287,'IVA_O_C_RED_INT',291,'INT_INDUS',
                       674,'REV_PREVIA','NO_EXISTE') concdesc,
       invmvain VR_iNGRESO, ING_REPORTADO, 100271 TIPO_SOLICITUD
from (
      select (select l.celocebe
                from open.GE_GEOGRA_LOCATION t, open.ldci_centbenelocal l
              where geograp_location_id = (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS
                                                    where address_id = susciddi)
                and t.geo_loca_father_id = l.celodpto
                and t.geograp_location_id = celoloca) CEBE,
             (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi) LOCA,
             m.invmsesu, m.invmconc , m.invmvain, sesucate, hi.hcececac EST_TECNICO, st.escodesc DES_TECNICO,
             decode((SELECT 1
                       FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                      WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                        AND OR_related_order.related_order_id = OR_order_activity.order_id
                        AND OR_order_activity.Status = 'F'
                        AND OR_order_activity.package_id = mo_packages.package_id
                        AND OR_order_activity.task_type_id in (10622, 10624)
                        AND mo_packages.package_type_id in (323, 100271, 100229)
                        AND OR_order.order_id = OR_related_order.related_order_id
                        --AND OR_order.legalization_date >= '09-02-2015' --to_date(&Fecha_Inicial)
                        AND OR_order.legalization_date <  '01-05-2015' --to_date(&Fecha_Final)
                        AND OR_order_activity.product_id = m.invmsesu
                        AND m.invmconc = 30
                        AND ROWNUM = 1), 1, m.invmvain, 0) ING_REPORTADO
        from open.ldci_ingrevemi m, open.servsusc v, open.suscripc s, open.hicaesco hi, open.estacort st
       where m.invmsesu  not in (select h.hcecnuse from open.hicaesco h
                                 where h.hcececan = 96
                                   and h.hcececac = 1 and hcecserv = 7014
                                   --and h.hcecfech >= '01-03-2015' --to_date(&Fecha_Inicial)
                                   and h.hcecfech <  '01-05-2015' --to_date(&Fecha_Final)
                                   and h.hcecnuse = m.invmsesu)
         and m.invmsesu  = v.sesunuse
         and v.sesususc  = s.susccodi
         and v.sesunuse  = hi.hcecnuse
         and hi.hcecfech < '01-05-2015' --to_date(&Fecha_Final)
         and hi.hcececac != 1
         and hi.hcececac = st.escocodi
     )
union
select CEBE, (select g.geo_loca_father_id from open.ge_geogra_location g where g.geograp_location_id = loca) DEPA,
       LOCA, (select g.description from open.ge_geogra_location g where g.geograp_location_id = loca) DESCRIPCION,
       product_id NUSE, sesucate CATE, EST_TECNICO, DES_TECNICO, cargconc CONCEPTO, 
       decode(cargconc,19,'C_X_C',30,'INT_RESID',137,'IVA_S_V_16',
                       287,'IVA_O_C_RED_INT',291,'INT_INDUS',
                       674,'REV_PREVIA','NO_EXISTE') concdesc,
       (cargvalo/ventas) VR_iNGRESO,
       ((int_reportada/ventas)*-1) REPORTADO, TIPO_SOLICITUD --package_id SOLICITUD
from (select (select l.celocebe
                from open.GE_GEOGRA_LOCATION t, open.ldci_centbenelocal l
               where geograp_location_id = (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi)
                 and t.geo_loca_father_id = l.celodpto
                 and t.geograp_location_id = celoloca) CEBE,
             (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi) LOCA,
             act.product_id, sesucate, hi.hcececac EST_TECNICO, st.escodesc DES_TECNICO,
             cargconc, cargvalo, act.task_type_id, act.package_id, mo_packages.package_type_id TIPO_SOLICITUD,
             (select count(*) from open.or_order_activity
               where or_order_activity.package_id = mo_packages.package_id
                 and task_type_id in (12150, 12152, 12153)) VENTAS,  /*Numero de CXC de la Venta*/
             (decode((SELECT 1
                        FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                       WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                         AND OR_related_order.related_order_id = OR_order_activity.order_id
                         AND OR_order_activity.Status = 'F'
                         AND OR_order_activity.package_id = mo_packages.package_id
                         AND OR_order_activity.task_type_id in (10622, 10624)
                         AND mo_packages.package_type_id in (323, 100229)
                         AND OR_order.order_id = OR_related_order.related_order_id
                         --AND OR_order.legalization_date >= '09-02-2015' --to_date(&Fecha_Inicial) 
                         AND OR_order.legalization_date <  '01-05-2015' --to_date(&Fecha_Final)
                         AND OR_order_activity.product_id = cargnuse --act.product_id
                         AND cargconc = 30
                         AND ROWNUM = 1), 1, cargvalo, 0)) Int_Reportada
        from open.mo_packages, open.or_order_activity act, OPEN.CARGOS C, open.servsusc, open.suscripc, open.or_order ord,
             open.hicaesco hi, open.estacort st
       where mo_packages.package_type_id   in (323, 100229)
         and mo_packages.package_id         =  act.package_id
         and act.task_type_id in (12150, 12152, 12153)
         and act.order_id = ord.order_id
         and cargdoso = 'PP-' || act.package_id
         and cargconc in (19,30,674,291,137,287)
         and cargfecr >= '01-04-2015' --to_date(&Fecha_Inicial)
         and cargfecr <  '01-05-2015' --to_date(&Fecha_Final)
         and cargcaca = 53
         and sesunuse = act.product_id
         and sesususc = susccodi
         and sesunuse  = hi.hcecnuse
         and hi.hcececac != 1
         and hi.hcececac = st.escocodi
      ) U))
PIVOT
(
MAX(VR_INGRESO)
FOR CONCDESC IN ('C_X_C',
'INT_RESID',
'IVA_S_V_16',
'IVA_O_C_RED_INT',
'INT_INDUS',
'REV_PREVIA'
)

)

order by cebe, loca, nuse
