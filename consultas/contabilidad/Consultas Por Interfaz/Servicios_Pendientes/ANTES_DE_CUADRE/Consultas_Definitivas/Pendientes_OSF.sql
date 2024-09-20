select CEBE, (select g.geo_loca_father_id from open.ge_geogra_location g where g.geograp_location_id = loca) DEPA, 
       LOCA, (select g.description from open.ge_geogra_location g where g.geograp_location_id = loca) DESCRIPCION,
       product_id NUSE, sesucate CATE, EST_TECNICO, DES_TECNICO, cargconc CONCEPTO, o.concdesc,
       (cargvalo/ventas) VR_iNGRESO, 
       ((int_reportada/ventas)*-1) REPORTADO, TIPO_SOLICITUD --package_id SOLICITUD
from (select (select l.celocebe 
                from open.GE_GEOGRA_LOCATION t, open.ldci_centbenelocal l
               where geograp_location_id = (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS
                                             where address_id = susciddi)
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
                         AND OR_order.legalization_date >= '09-02-2015' AND OR_order.legalization_date < '01-03-2015'
                         AND OR_order_activity.product_id = cargnuse --act.product_id
                         AND cargconc = 30
                         AND ROWNUM = 1), 1, cargvalo, 0)) Int_Reportada
        from open.mo_packages, open.or_order_activity act, OPEN.CARGOS C, open.servsusc, open.suscripc, open.or_order ord,
             open.hicaesco hi, open.estacort st
       where mo_packages.package_type_id    in (323, 100229)
         and mo_packages.package_id         =  act.package_id
         and act.task_type_id in (12150, 12152, 12153)
         and open.dapr_product.fnugetproduct_status_id (act.product_id) = 15
         and act.order_activity_id not in (4000050, 4000051) -- Actividades residenciales
         and act.order_id = ord.order_id
         and cargdoso = 'PP-' || act.package_id
         and cargconc in (19,30,674,291,137,287)
         and cargfecr >= '09-02-2015' and cargfecr < '01-03-2015'
         and sesunuse = act.product_id 
         and sesususc = susccodi
         and sesunuse  = hi.hcecnuse
         and hi.hcececac != 1 
         and hi.hcececac = st.escocodi         
      ) U, open.concepto o
WHERE cargconc = o.conccodi
order by cebe, product_id, sesucate
