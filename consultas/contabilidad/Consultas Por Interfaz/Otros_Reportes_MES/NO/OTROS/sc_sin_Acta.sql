SELECT hcecnuse, '0' acta, o.order_id orden , task_type_id titr, sum(value) Total
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
   and o.status = 'F'
   and o.order_id not in (select a.id_orden from OPEN.ge_detalle_Acta a where a.id_orden = o.order_id)
group by hcecnuse, o.order_id, task_type_id
order by hcecnuse, task_type_id, o.order_id
