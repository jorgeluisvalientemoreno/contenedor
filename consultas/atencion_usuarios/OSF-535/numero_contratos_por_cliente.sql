select distinct ge.subscriber_name,
                ge.subs_last_name,
                ge.identification,
                ge.phone,
                count(distinct s.susccodi)
  from open.ge_subscriber ge
 inner join open.suscripc s  on s.suscclie = ge.subscriber_id  
 where not exists (select null
          from pr_product prd2
         where prd2.subscription_id = s.susccodi
           and prd2.product_type_id in (7014))
 group by ge.subscriber_name,
          ge.subs_last_name,
          ge.identification,
          ge.phone
having count(distinct s.susccodi) = 1
