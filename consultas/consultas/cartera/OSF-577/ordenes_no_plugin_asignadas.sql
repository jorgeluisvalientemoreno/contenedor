select a.product_id,
       a.subscription_id,
       o.task_type_id,
       t.description,
       a.package_id,
       a.activity_id,
       o.order_id,
       o.order_status_id,
       o.operating_unit_id,
       o.created_date
  from open.or_order o
 inner join open.or_task_type t on t.task_type_id = o.task_type_id
 inner join open.or_order_activity a on a.order_id = o.order_id
 Where o.task_type_id not in (10169, 10546, 10547, 10881, 10882, 10884, 10917, 10918, 12521, 12526, 12528)
   and o.order_status_id in (5)
   and exists (select null
          from open.or_task_type_causal tt
         where tt.task_type_id = o.task_type_id
           and tt.causal_id in (9777, 3316, 9821))
 order by o.created_date desc;
