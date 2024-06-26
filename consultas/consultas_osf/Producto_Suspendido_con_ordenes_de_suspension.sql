select oo.*
  from open.or_order oo, or_order_activity ooa, pr_product pp
 where oo.task_type_id = 10833
   and oo.order_status_id = 5
   and oo.order_id = ooa.order_id
   and ooa.product_id = pp.product_id
   and pp.product_status_id = 2;
