select pr_product.subscription_id,
        pr_product.product_id ,
        pr_product.product_type_id , 
        pr_product.category_id ,
        pr_product.subcategory_id ,
        servsusc.sesucico
from open.pr_product 
left join open.servsusc on servsusc.sesunuse = pr_product.product_id and pr_product.subscription_id = servsusc.sesususc
where (select count(1) 
       from  open.mo_packages 
       left join open.or_order_activity  on mo_packages.package_id = or_order_activity.package_id
       left join open.or_order on or_order_activity.order_id = or_order.order_id
       where or_order_activity.product_id =  p.product_id 
       and mo_packages.package_type_id   = 100101 
       and  mo_packages.motive_status_id =13
       and or_order_activity.activity_id  = 4000868 )  = 0      
and rownum <= 10
