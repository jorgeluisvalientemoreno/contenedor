select cuconuse, open.ldc_getedadrp(cuconuse) edad_rp, m.suspension_type_id  marca,  nvl(sum(cucosacu), 0) Valor_Total
  from open.cuencobr
  inner join open.pr_product  p on p.product_id = cuconuse and p.product_type_id = 7014 and p.product_status_id = 1
  left join open.ldc_marca_producto m on m.id_producto = cuconuse
 where nvl(cucosacu, 0) > 0
   and nvl(cucovare, 0) = 0
   and nvl(cucovrap, 0) = 0
      and ldc_getedadrp(cuconuse) > 60
   and rownum = 20
   and not exists
 (select null
          from open.mo_packages p
         inner join open.mo_motive mo on p.package_id = mo.package_id
         where mo.product_id = cuconuse
           and p.package_type_id in (100237, 100294,100295, 100156, 100248, 100246, 100295, 100312)
           and p.motive_status_id in (36, 13))
   group by cuconuse,ldc_getedadrp(cuconuse), suspension_type_id
   
