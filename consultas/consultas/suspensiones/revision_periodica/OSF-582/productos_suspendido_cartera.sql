select p.product_id,
       p.product_status_id,
       sesuesco,
       open.ldc_getedadrp(p.product_id) edad_rp,
       m.suspension_type_id,
       pc.is_notif
  from open.pr_product p
 inner join  open.servsusc s on s.sesunuse = p.product_id
 left join open.ldc_marca_producto m on m.id_producto = p.product_id
 left join open.ldc_plazos_cert pc on pc.id_producto = p.product_id
 left join open.pr_prod_suspension ps on ps.product_id = p.product_id
 where p.product_status_id in (2)
   and product_type_id = 7014
   and s.sesucate != 7
   and ldc_getedadrp(p.product_id) > 60
   and pc.is_notif in ('YV', 'YR')
   and ps.suspension_type_id = 2
   and ps.active = 'Y'
   and not exists
  (select null from open.or_order_Activity a2, open.or_order o2
   where o2.order_id=a2.order_id 
   and o2.task_type_id in (10062, 10063, 10559, 10597, 10598, 10883, 10919, 12525, 12527, 12529, 12530, 10169,10884,10918,12521) 
   and a2.product_id=p.product_id 
   and o2.order_Status_id in (0,5,7,11 ))
   and not exists
    (select null
          from open.mo_packages p
         inner join open.mo_motive mo on p.package_id = mo.package_id
         where mo.product_id = p.product_id
           and p.package_type_id in (100237, 100294,100295, 100156, 100248, 100246, 100295, 100312)
           and p.motive_status_id in (36, 13))
           and  rownum < 10
