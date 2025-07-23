select distinct pp.product_id, pp.category_id, pp.subcategory_id
  from OPEN.SUSCRIPC a
 inner join pr_product pp
    on pp.subscription_id = a.susccodi
   and pp.category_id = 2
 inner join servsusc ss
    on ss.sesuesco in
      --(select a.coeccodi from OPEN.CONFESCO a where a.coecserv = 7014 and a.coecfact = 'S')
       (1, 2, 3, 4, 6, 91, 93, 96, 99, 100)
   and ss.sesunuse = pp.product_id
 where (select count(1)
          from mo_packages mp, mo_motive mm
         where mp.package_id = mm.package_id
           and mp.motive_status_id = 13
           and mm.product_id = pp.product_id) = 0
   and rownum <= 10;
