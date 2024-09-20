select act.package_id, count(distinct(act.product_id)), count(*)
  from open.or_order_activity act, open.or_order oo
 where act.package_id   in (17995698,12579102,16464200,16588808,18001214,17542824,18430312,15028171,18560101)
   and act.order_id      =  oo.order_id
   and oo.created_date  <= '31-05-2015 23:59:59'
   and act.task_type_id in (12150, 12152, 12153)
   and act.order_id not in (select oro.related_order_id from open.or_related_order oro
                             where oro.related_order_id = act.order_id)
group by act.package_id
