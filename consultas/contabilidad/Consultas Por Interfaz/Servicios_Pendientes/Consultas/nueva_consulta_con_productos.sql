select hcecnuse, cargconc, cargvalo, ventas, (cargvalo/ventas) valor
 from (
        select hcecnuse, cargconc, cargvalo,  
               (select count(*) from open.or_order_activity act
                  where act.package_id = uu.package_id
                    and act.task_type_id in (12150, 12152, 12153)
                    and act.order_id not in (select oro.related_order_id from open.or_related_order oro 
                                              where oro.related_order_id = act.order_id)) VENTAS,
                (select count(distinct(act.product_id))
                   from open.or_order_activity act, open.or_order oo
                  where act.package_id   =  uu.package_id
                    and act.order_id     =  oo.order_id
                    and oo.created_date  <= '&FECHA_FINAL 23:59:59'              
                    and act.task_type_id in (12150, 12152, 12153)
                    and act.order_id not in (select oro.related_order_id from open.or_related_order oro 
                                              where oro.related_order_id = act.order_id)) Productos                                       
                                              
          from open.cargos, open.servsusc,
               (select distinct h.hcecnuse, m.package_id
                  from open.hicaesco h, open.or_order_Activity a, open.mo_packages m
                 where h.hcececan = 1
                   and h.hcececac = 96 
                   and h.hcecfech <= '&FECHA_FINAL 23:59:59'
                   and h.hcecnuse = a.product_id 
                   and a.package_id = m.package_id
                   and m.package_type_id = 323) uu
         where cargcuco != -1
           and cargnuse = sesunuse
           and sesuserv =  6121
           and cargfecr >= '09-02-2015'
           and cargfecr <= '&FECHA_FINAL 23:59:59'
           and cargdoso = 'PP-'||uu.package_id
           and cargconc in (19,30,674,291)
        )
where ventas = productos
