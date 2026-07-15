select subscription_id,
        product_id ,
        product_type_id , 
        category_id ,
         subcategory_id ,
         sesucico
from pr_product p
left join servsusc on sesunuse = product_id and subscription_id = sesususc
where (select count(1) 
       from  open.mo_packages pp 
       left join open.or_order_activity a on pp.package_id = a.package_id
       left join open.or_order o on a.order_id = o.order_id
       where a.product_id =  p.product_id 
       and pp.package_type_id   = 100101 
       and  pp.motive_status_id =13
       and    a.activity_id  = 4001004 )  = 0      
and rownum <= 10
and sesucico in (1850,2050,5550,9050,2401,2402)

48361079
4001004
