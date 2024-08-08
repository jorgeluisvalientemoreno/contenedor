select p.product_id,
       s.sesususc,
       p.product_status_id,
       sesuesco,
       m.suspension_type_id  marca,
       open.ldc_getedadrp(p.product_id) edad_rp,
       s.sesucicl
  from open.pr_product p
 inner join open.servsusc s on s.sesunuse=p.product_id 
 left join open.ldc_marca_producto m on m.id_producto = p.product_id
 where p.product_status_id = 1
   and product_type_id = 7014
   and ldc_getedadrp(p.product_id) > 55
   and m.suspension_type_id in (101, 102, 103, 104)
   and exists
 (select null
          from open.mo_packages p, open.mo_motive mo, or_order_activity  oa, or_order  ot
         where p.package_id = mo.package_id
           and mo.product_id = p.product_id
           and oa.package_id = p.package_id
           and ot.order_id = oa.order_id and ot.task_type_id in (10444,10795) and ot.order_status_id = 5 and ot.operating_unit_id = 4205
           and p.package_type_id in (100237, 100294, 100295, 100156, 100248, 100246, 100295, 100312)
           and p.motive_status_id in (36, 13))
           
  and  p.product_id=   50106618
   and rownum < 10
   
--/*and ot.task_type_id in (10444,10795,10450)*/
 /*and ot.task_type_id not in (10444,10795) */
