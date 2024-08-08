with base as(
select distinct ge.subscriber_id,
                ge.subscriber_name,
                ge.subs_last_name,
                ge.identification,
                ge.phone,
                s3.sesucate,
                count(distinct s2.susccodi)
  from open.ge_subscriber ge
 inner join open.suscripc s2 on s2.suscclie = ge.subscriber_id
 inner join open.servsusc s3 on s3.sesususc = s2.susccodi
 where s3.sesucate = 1
 and exists (select null
          from open.suscripc s
         inner join pr_product prd
            on prd.subscription_id = s.susccodi
         where s.suscclie = ge.subscriber_id
           and prd.product_type_id in (6121))
   and not exists (select null
          from open.suscripc s
         inner join pr_product prd
            on prd.subscription_id = s.susccodi
         where s.suscclie = ge.subscriber_id
           and prd.product_type_id in (7014))

 group by ge.subscriber_id,
          ge.subscriber_name,
          ge.subs_last_name,
          ge.identification,
          ge.phone,
          s3.sesucate)
select base.*,
       (select count(1) from open.suscripc s, open.pr_product p  where s.suscclie=base.subscriber_id and p.subscription_id=s.susccodi and p.product_type_id=7014)
from base 
