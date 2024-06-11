select distinct ge.subscriber_id,
                ge.subscriber_name,
                ge.subs_last_name,
                ge.identification,
                s.susccodi,
                pr.product_id,
                pr.product_type_id,
                s.servdesc,
                pr.product_status_id,
                pr.address_id,
                ab.address,
                ss.sesucate,
                ge.phone
  from open.ge_subscriber ge
left join open.suscripc s  on s.suscclie = ge.subscriber_id  
left join open.servsusc ss on ss.sesususc = s.susccodi 
left join open.pr_product pr on pr.product_id = ss.sesunuse 
left join open.ab_address ab on ab.address_id = pr.address_id 
left join open.servicio s on s.servcodi = pr.product_type_id
