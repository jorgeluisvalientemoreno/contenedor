select *
from open.pr_product pr
where pr.product_status_id = 1
and pr.product_type_id!= 7014
and exists ( select null
             from open.pr_product pr1 
             inner join  open.ps_product_status ps on pr1.product_status_id = ps.product_status_id  
             where pr.subscription_id = pr1.subscription_id 
             and ps.is_active_product='N' 
             and ps.is_final_status='Y' 
             and pr1.product_type_id= 7014) 
             
 
select *
from open.pr_product pr
inner join  open.ps_product_status ps1 on pr.product_status_id = ps1.product_status_id  
where pr.product_status_id != 1 and ps1.is_final_status='N' and ps1.is_active_product='N' 
and pr.product_type_id = 7014
and exists ( select null
             from open.pr_product pr1 
             inner join  open.ps_product_status ps on pr1.product_status_id = ps.product_status_id  
             where pr.subscription_id = pr1.subscription_id 
             and ps.is_active_product='Y' 
             --and ps.is_final_status='Y' 
             and pr1.product_type_id!= 7014) ;
             
