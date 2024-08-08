--validar_producto
select p.product_id,
       p.subscription_id,
       product_type_id,
       p.product_status_id,
       sesuesco,
       sesuesfn
  from open.pr_product p
 inner join open.servsusc s on s.sesunuse = p.product_id
 inner join open.suscripc c on c.susccodi = s.sesususc
 where p.product_id in (51877218)
   and not exists (select '1'
          from factura fa
         where fa.factsusc = c.susccodi
           and fa.factpefa = 111230
           and fa.factprog = 6)
and not exists
 (select null
          from open.mo_packages p, open.mo_motive mo
         where p.package_id = mo.package_id
           and mo.product_id = p.product_id
           and p.package_type_id in (100237, 100294, 100295, 100156, 100248, 100246, 100295, 100312,100101,59,265)
           and p.motive_status_id in (36,13))

--, (select m.suspension_type_id  from open.ldc_marca_producto m where m.id_producto = p.product_id)

--cp001 = 51864372,51864534,51911053,51864371,51934320,51864380,51864405,51864505,51864497,51864530,51864365,51864522,51836924,51718876,51718913
--cp002 = 1117063,50171811,1506393,1191722
--cp003 = 51877218
