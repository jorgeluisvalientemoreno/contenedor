select c.* ,product_id ,  p.address_id  , a.address_parsed , a.geograp_location_id , p.product_type_id , suscclie
from contrato c , pr_product p , ab_address a , suscripc s
where contrato=48107668
and contrato= subscription_id 
and p.address_id   = a.address_id 
and s.susccodi= subscription_id ;