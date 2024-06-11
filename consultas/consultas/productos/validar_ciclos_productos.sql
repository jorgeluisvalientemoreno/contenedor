select p.product_id,product_status_id, sesuesco, sesucicl, sesucico, ciclcodi ,cicocodi 
from open.pr_product p
inner join open.servsusc su on su.sesunuse=p.product_id
inner join open.ab_address di on di.address_id=p.address_id
inner join open.ab_segments se on se.segments_id=di.segment_id
where p.product_type_id=7014
  and ((sesucico!=se.cicocodi ) or
       (sesucicl!=se.ciclcodi ) or
       (sesucico!=sesucicl) or
       (se.ciclcodi !=cicocodi  )
      )
