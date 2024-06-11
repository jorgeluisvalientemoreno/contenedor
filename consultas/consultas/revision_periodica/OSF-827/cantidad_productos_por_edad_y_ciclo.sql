select s.sesucicl,
       open.ldc_getedadrp(p.product_id)edad,
       count(1)
  from open.pr_product p
 inner join open.servsusc s on s.sesunuse = p.product_id
 left join ldc_marca_producto  m  on m.id_producto = p.product_id 
 where s.sesuesco = 1
   and p.product_status_id = 1
   and product_type_id = 7014
   and open.ldc_getedadrp(p.product_id) in (53, 56)
   and s.sesucicl = 521
  
   and not exists
 (select null
          from open.mo_packages p, open.mo_motive mo
         where p.package_id = mo.package_id
           and mo.product_id = p.product_id
           and p.package_type_id in (100237, 100294, 100295, 100156, 100248, 100246, 100295,100312)
           and p.motive_status_id in (36, 13))
   and not exists
    (select null
           from open.ldc_infoprnorp  j
           where j.inpnsesu = s.sesunuse)
   group by  s.sesucicl, open.ldc_getedadrp(p.product_id)
   order by  s.sesucicl, open.ldc_getedadrp(p.product_id)        


