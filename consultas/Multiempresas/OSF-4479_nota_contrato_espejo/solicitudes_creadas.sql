select  m.package_id,package_type_id ,m.request_date, m.motive_status_id , pr.subscription_id, pr.product_id , pr.product_status_id , ps.description,pr.product_type_id , sesucicl
from mo_packages m , mo_motive mo , pr_product pr  , ps_product_status ps , servsusc
where mo.package_id = m.package_id
and pr.product_id = mo.product_id  and pr.product_id = sesunuse
and pr.product_status_id  = ps.product_status_id
and   m.package_id = 224789111
order by m.request_date desc ;