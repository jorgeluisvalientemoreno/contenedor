select pr.component_id , pr.component_type_id,ps.description  , pr.product_id , pr.component_status_id ,s.description 
from pr_component pr 
left join PS_COMPONENT_TYPE ps on ps.COMPONENT_TYPE_ID = pr.COMPONENT_TYPE_ID
left join PS_PRODUCT_STATUS s on s.PRODUCT_STATUS_ID = pr.COMPONENT_STATUS_ID 
where product_id = 6133716;

select PR.PRODUCT_ID ,pr.product_status_id , s.description 
from pr_product pr
left join PS_PRODUCT_STATUS s on s.PRODUCT_STATUS_ID = pr.product_status_id
where pr.product_id =6133716 ;  
