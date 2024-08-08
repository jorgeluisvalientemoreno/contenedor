select product_id,
      subscription_id,
      product_type_id,
      commercial_plan_id,
      product_status_id,
      category_id , 
      subcategory_id 
from open.pr_product p
where product_type_id = 6121
and commercial_plan_id = 20 
and (select count(1)
     from open.cuencobr
     where cuconuse = p.product_id 
     and (nvl(cucosacu, 0) + nvl(cucovare, 0)) > 0 ) = 1
and (select count(1) 
     from open.or_order_activity a
     inner join open.or_order o on o.order_id = a.order_id 
     where a.product_id = p.product_id 
     and o.task_type_id in( 10786,10785)
     and o.order_status_id  in (8) ) = 0
and category_id = 12     