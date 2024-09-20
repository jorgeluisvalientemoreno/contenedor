select hcecnuse, sum(total) costo, 
      (select sum(invmvain) from open.ldci_ingrevemi i where i.invmsesu = hcecnuse) Ingre_Mig,
      (select sum((cargvalo/ventas)) Valor
         from ( select cargconc, cargvalo, package_id, u.product_id,
                       (select count(*) from open.or_order_activity
                        where or_order_activity.package_id = u.package_id
                         and task_type_id in (12150, 12152, 12153)) VENTAS
                  from open.cargos,
                       (SELECT distinct to_char(m.package_id) package_id, m.package_type_id, a.product_id
                          from open.or_order_activity a, open.mo_packages m
                         where a.product_id in (SELECT distinct hcecnuse 
                                                 FROM open.hicaesco h
                                                WHERE hcececan = 96
                                                  AND hcececac = 1
                                                  AND hcecserv = 7014
                                                  AND hcecfech >= '01-04-2015' and hcecfech < '01-05-2015'
                                                  AND open.dapr_product.fnugetproduct_status_id (h.hcecnuse) = 1)
                          and a.package_id = m.package_id and m.package_type_id in (323, 100229)) u
                 where cargdoso in 'PP-'||package_id
                   and cargconc in (30, 19, 674)
               ), open.concepto, open.servsusc, open.suscripc
          where product_id = hcecnuse
            and sesunuse = product_id
            and sesususc = susccodi
            and cargconc = conccodi
        group by product_id) Ingre_Otros,
      (select sum(cargvalo) from open.cargos 
        where cargnuse = hcecnuse and cargconc in (19,30,674) and cargcaca = 53 and cargsign = 'DB') Ingre_OSF
         
         
 from (
SELECT hcecnuse, id_acta acta , id_orden orden , task_type_id titr, sum(valor_total) Total
  FROM OPEN.ge_detalle_Acta a, open.or_order_activity o, open.hicaesco h, open.mo_packages m
 where hcececan =  96
   and hcececac =  1
   and hcecfech >= '01-04-2015'
   and hcecfech <  '01-05-2015'
   and hcecserv =  7014
   and hcecnuse = o.product_id
   and o.package_id = m.package_id
   and m.package_type_id in (323, 271, 100271, 100229)
   and o.order_id = a.id_orden
group by hcecnuse, id_acta, id_orden, task_type_id
union all
SELECT hcecnuse, 0 acta, o.order_id orden , task_type_id titr, sum(value) Total
  FROM open.or_order_activity o, open.hicaesco h, open.mo_packages m, open.or_order_items i 
 where hcececan =  96
   and hcececac =  1
   and hcecfech >= '01-04-2015'
   and hcecfech <  '01-05-2015'
   and hcecserv =  7014
   and hcecnuse = o.product_id
   and o.package_id = m.package_id
   and m.package_type_id in (323, 271, 100271, 100229)
   and o.order_id = i.order_id
   and value != 0   
   and o.order_id not in (select a.id_orden from OPEN.ge_detalle_Acta a where a.id_orden = o.order_id)
group by hcecnuse, o.order_id, task_type_id
order by hcecnuse, titr, orden
)
group by hcecnuse
