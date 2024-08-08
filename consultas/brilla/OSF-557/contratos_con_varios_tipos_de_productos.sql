select sesususc,sesunuse,sesuserv,sesuesco,sesufein    
from servsusc
where ( select count(distinct(product_type_id ))
from open.pr_product pr 
where subscription_id =sesususc 
and product_status_id  = 1 ) > 3
and rownum <= 15