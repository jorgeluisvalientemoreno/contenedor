
SELECT cargnuse, cargconc, cargcaca, cargvalo, SOLICITUD, VENTAS, PRODUCTOS
 FROM (
        select cargnuse, cargconc, cargcaca, cargvalo, substr(cargdoso, 4, 8) SOLICITUD,
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
           and cargnuse =  sesunuse
           and sesuserv =  6121
           and cargfecr >= '09-02-2015'
           and cargfecr <= '&FECHA_FINAL 23:59:59'
           and substr(cargdoso,1,3) = 'PP-'
           and cargconc in (19,30,674,291)
--       GROUP BY cargnuse, cargconc, cargcaca, substr(cargdoso, 4, 8)
      )
 WHERE (VENTAS = 0 OR VENTAS != PRODUCTOS OR PRODUCTOS = 0)
