-- CONSTRUCTORAS CONECTADAS
SELECT DISTINCT  AC.PRODUCT_ID, cargnuse, cargconc, cargcaca, cargvalo, SOLICITUD, VENTAS, PRODUCTOS, 
       (CARGVALO/VENTAS) PENDIENTE, P.PACKAGE_TYPE_ID,
       (SELECT (CARGVALO/VENTAS)
          FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
         WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
           AND OR_related_order.related_order_id = OR_order_activity.order_id
           AND OR_order_activity.Status = 'F'
           AND OR_order_activity.package_id = mo_packages.package_id
           AND OR_order_activity.task_type_id in (10622, 10624)
           AND mo_packages.package_type_id in (323,100229)
           AND OR_order.legalization_date >= '09-02-2015'
           AND OR_order.legalization_date <  '01-06-2015'
           AND OR_order.order_id = OR_related_order.related_order_id
           AND OR_order_activity.product_id = AC.PRODUCT_ID
           and CARGconc IN (30,291)
           and rownum = 1) Reportado
 FROM (
        select cargnuse, cargconc, cargcaca, SUM(cargvalo) CARGVALO, substr(cargdoso, 4, 8) SOLICITUD,
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
           and cargfecr >= '09-02-2015'
           and cargfecr <= '&FECHA_FINAL 23:59:59'
           and substr(cargdoso,1,3) = 'PP-'
           and cargconc in (19,30,674,291)
       GROUP BY cargnuse, cargconc, cargcaca, substr(cargdoso, 4, 8)
      ), OPEN.OR_ORDER_aCTIVITY AC, OPEN.MO_PACKAGES P
 WHERE VENTAS > 0
   AND VENTAS = PRODUCTOS
   AND SOLICITUD = AC.PACKAGE_ID
   AND AC.PACKAGE_ID = P.PACKAGE_ID
   AND AC.PRODUCT_ID IN (SELECT distinct hcecnuse FROM open.hicaesco h
                          WHERE hcececan = 96
                            AND hcececac = 1
                            AND hcecserv = 7014
                            AND hcecfech >= '01-05-2015' and hcecfech < '01-06-2015')
   
