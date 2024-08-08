select distinct ge.subscriber_id  "CLIENTE", 
       count(distinct s.susccodi)  "# DIRECCIONES"
from open.ge_subscriber ge
inner join open.suscripc s  on s.suscclie = ge.subscriber_id  
where exists (select null
              from open.pr_product prd2
              where prd2.subscription_id = s.susccodi
              and prd2.product_type_id = 7014
              and prd2.category_id = 1)
and not exists (select null
                from open.ge_subscriber  ge2
                where ge2.subscriber_id = ge.subscriber_id 
                and ge2.phone is null)
group by ge.subscriber_id