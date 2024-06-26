select distinct ge.subscriber_id,
                ge.subscriber_name,
                ge.subs_last_name,
                ge.identification,
                s.susccodi,
                pr.product_id,
                pr.product_type_id,
                s.servdesc,
                --    open.ldc_getedadrp(pr.product_id)edad,
                pc.is_notif,
                pr.product_status_id
  from open.ge_subscriber ge
  left join open.suscripc s
    on s.suscclie = ge.subscriber_id
  left join open.servsusc ss
    on ss.sesususc = s.susccodi
  left join open.pr_product pr
    on pr.product_id = ss.sesunuse
  left join open.ab_address ab
    on ab.address_id = pr.address_id
  left join open.servicio s
    on s.servcodi = pr.product_type_id
  left join open.ldc_plazos_cert pc
    on pc.id_producto = pr.product_id
 where ab.way_number = 87
   and ab.cross_way_number = 53
   and ab.house_number = 62
--ab.address like '%Calle 87 # 53 - 62%'
