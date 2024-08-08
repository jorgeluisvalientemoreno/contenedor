select open.dage_geogra_location.fsbgetdescription(open.dage_geogra_location.fnugetgeo_loca_father_id(di.geograp_location_id)),
       di.geograp_location_id,
       open.dage_geogra_location.fsbgetdescription(di.geograp_location_id),
       PR.PRODUCT_ID,
       su.subscriber_name,
       su.subs_last_name,
       product_status_id,
       pr.category_id,
       open.pktblcategori.fsbgetdescription(pr.category_id,null),
       pr.subcategory_id,
       open.pktblsubcateg.fsbgetdescription(pr.category_id, pr.subcategory_id, null),
       a.package_id,
       o.order_id,
       o.task_type_id,
       open.daor_task_type.fsbgetdescription(o.task_type_id,null),
       o.order_status_id,
       o.operating_unit_id,
       open.daor_operating_unit.fsbgetname(o.operating_unit_id,null),
       sesufein
  from open.or_order_Activity a,
       open.mo_packages       p,
       open.pr_product        pr,
       open.ge_subscriber     su,
       open.or_order          o,
       open.ab_address        di,
       open.servsusc          su
 where a.package_id = p.package_id
   and p.package_type_id in (323, 271, 100271, 329, 100229)
   and instance_id is not null
   and status = 'R'
   and o.task_type_id in (12149, 12151, 10495)
   and a.product_id = pr.product_id
   and pr.product_status_id = 1
   and a.address_id = pr.address_id
   and su.sesunuse=pr.product_id
   and su.subscriber_id =
       open.pktblsuscripc.fnugetsuscclie(pr.subscription_id)
   and a.order_id = o.order_id
   and pr.address_id = di.address_id
   and not exists (select null
          from open.or_order_activity a2
         where p.package_id = A2.package_id
           and a2.task_type_id in (12150, 12152, 12153)
           and a2.status = 'R');
