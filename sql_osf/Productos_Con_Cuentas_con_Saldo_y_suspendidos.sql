select b.subscription_id contrato, b.product_id
  from open.pr_product b
 where b.product_id in
       (select a.product_id
          from open.pr_prod_suspension a
         where a.suspension_type_id in (101, 102, 103, 104)
           and a.active = 'Y'
           and a.inactive_date is null
           and (select count(1)
                  from open.mo_motive mm, mo_packages mp
                 where mm.product_id = A.PRODUCT_ID
                   and mm.package_id = mp.package_id
                   and mp.package_type_id in (100156,
                                              100237,
                                              100246,
                                              100321,
                                              100294,
                                              100295,
                                              100306)
                   and mp.motive_status_id = 13) = 0
           and LDC_FNUCUENTASSALDOSPRODUCTO(A.PRODUCT_ID) >= 3
           and rownum <= 10group by a.product_id)
