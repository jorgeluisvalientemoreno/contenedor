select distinct ge.subscriber_id,
                ge.subscriber_name,
                ge.subs_last_name,
                ge.identification,
                s.susccodi,
                pr.product_id,
                pr.product_type_id,
                s.servdesc,
                open.ldc_getedadrp(pr.product_id)edad,
                pr.product_status_id
  from open.ge_subscriber ge
left join open.suscripc s  on s.suscclie = ge.subscriber_id  
left join open.servsusc ss on ss.sesususc = s.susccodi 
left join open.pr_product pr on pr.product_id = ss.sesunuse 
left join open.ab_address ab on ab.address_id = pr.address_id 
left join open.servicio s on s.servcodi = pr.product_type_id
left join ldc_plazos_cert  pc  on pc.id_producto = pr.product_id
 where ge.subscriber_id = 50228
AND   pr.product_type_id = 7014
 and (select count(1)
             from open.mo_motive mm, mo_packages mp
             where mm.product_id = pr.product_id
             and mm.package_id = mp.package_id
             and mp.package_type_id in (100156, 100246)
             and mp.motive_status_id = 13) = 0
 and (select count(1)
             from  open.pr_prod_suspension sp   
             where sp.product_id = pr.product_id
        and sp.suspension_type_id in (101, 102, 103, 104)
        and sp.active = 'Y') = 0
and     (select count (1)
                from ldc_plazos_cert  pc
                where pc.id_producto = pr.product_id
                and (pc.is_notif not in ('YV', 'YR') OR pc.is_notif IS NULL)) > 0



--and   pr.product_id in (50648518,50648543,50648556,50648588,50648589,50648594,50648598,50648608,50648619,50648626,50648631,50648648,50648684,50648714,50648726,50648764,50648792,50648931,50648963,50649582,50649591,50649690,50649715,50649717,50649725,50649753,50649765,50649796,50649800,50649815,50649826,50649833,50649841,50649844,50649856,50649865,50649874,50649882,50649895,50649900,50649908,50649941,50649960,50649972,50649986,50650003,50650030,50650705,50650713,50650791,50650990,50651041,50651073,50705436,50705703,50705707,50705832,50705836,50705857,50705879,50705907,50705963,50706126,50706333,50706349)

