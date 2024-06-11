select pr.subscription_id ,
       pr.product_id ,
       pr.product_status_id EST_PROD,
       s.suspension_type_id, 
       s.active,
       ldc_getedadrp(s.product_id) as meses_RP
from  open.pr_prod_suspension s
inner join open.pr_product pr on pr.product_id = s.product_id
where s.active = 'Y'
and s.suspension_type_id in (2)
and ldc_getedadrp(s.product_id ) > 54