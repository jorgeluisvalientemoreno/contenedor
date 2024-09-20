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
   

   
