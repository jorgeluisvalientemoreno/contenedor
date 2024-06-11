select *
from ps_product_status  pe
where pe.prod_status_type_id = 1
and   pe.is_active_product = 'N';

select *
from ps_prod_status_type
