-- OTRA PRUEBA 24/03/2015
select cargnuse, cargconc,cargvalo, (select count(*) from open.or_order_activity
                                      where or_order_activity.package_id = ATENCION
                                        and task_type_id in (12150, 12152, 12153)) /*Numero de CXC de la Venta*/ VENTAS,
       decode((SELECT 1
                 FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                  AND OR_related_order.related_order_id = OR_order_activity.order_id
                  AND OR_order_activity.Status = 'F'
                  AND OR_order_activity.package_id = mo_packages.package_id
                  AND OR_order_activity.task_type_id in (10622, 10624)
                  AND mo_packages.package_type_id in (323, 100271) 
                  AND OR_order.order_id = OR_related_order.related_order_id
                  AND OR_order_activity.product_id = cargnuse
                  AND cargconc = 30
                  AND ROWNUM = 1), 1, cargvalo, 0) Int_Reportada
  from open.cargos, 
       (
          select distinct /*'PP-' || */or_order_activity.package_id ATENCION
            from open.mo_packages, open.or_order_activity, open.pr_product 
           where mo_packages.package_type_id    in (323, 100229)
             and mo_packages.package_id         =  OR_order_activity.package_id
             and or_order_activity.task_type_id in (12150, 12152, 12153)
             and OR_order_activity.product_id   =  pr_product.product_id
             and pr_product.product_status_id   =  15
             and or_order_activity.order_activity_id not in (4000050, 4000051)
       ) u
where cargdoso = 'PP-' || atencion
  and cargconc in (19, 30, 674)
  and cargsign = 'DB'
