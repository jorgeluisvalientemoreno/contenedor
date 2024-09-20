-- NUEVO 24/03/2015
select CEBE, b.cebedesc DESCRIPCION, product_id NUSE, sesucate CATE, cargconc CONCEPTO, o.concdesc,
       (cargvalo/ventas) VR_iNGRESO, 
       ((int_reportada/ventas)*-1) REPORTADO
from (
      select (select l.celocebe 
                from open.GE_GEOGRA_LOCATION t, open.ldci_centbenelocal l
               where geograp_location_id = (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS
                                                    where address_id = susciddi)
                and t.geo_loca_father_id = l.celodpto 
                and t.geograp_location_id = celoloca) CEBE,
             act.product_id, sesucate, cargconc, cargvalo, act.task_type_id, act.package_id,
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
                  AND mo_packages.package_type_id in (323, 100271, 100229) 
                  AND OR_order.order_id = OR_related_order.related_order_id
                  AND OR_order_activity.product_id = act.product_id
                  AND cargconc = 30
                  AND ROWNUM = 1), 1, cargvalo, 0)) Int_Reportada
        from open.mo_packages, open.or_order_activity act, open.pr_product, OPEN.CARGOS C, open.servsusc, open.suscripc 
       where mo_packages.package_type_id    in (323, 100229)
         and mo_packages.package_id         =  act.package_id
         and act.task_type_id in (12150, 12152, 12153)
         and act.product_id   =  pr_product.product_id
         and pr_product.product_status_id   =  15
         and act.order_activity_id not in (4000050, 4000051) -- Actividades residenciales
         and cargdoso = 'PP-' || act.package_id
         and cargconc in (19, 30, 674)
         and sesunuse = act.product_id 
         and sesususc = susccodi
      ) U, OPEN.LDCI_centrobenef b, open.concepto o
 WHERE cebe = b.cebecodi 
   AND cargconc = o.conccodi
