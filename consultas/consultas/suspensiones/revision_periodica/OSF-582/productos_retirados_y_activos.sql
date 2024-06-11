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
 where p.product_status_id in (1,3,16)
   and product_type_id = 7014
   and ldc_getedadrp(p.product_id) > 55
   and not exists
 (select null
          from open.mo_packages p
         inner join open.mo_motive mo on p.package_id = mo.package_id
         where mo.product_id = p.product_id
           and p.package_type_id in (100237, 100294,100295, 100156, 100248, 100246, 100295, 100312)
           and p.motive_status_id in (36, 13))
