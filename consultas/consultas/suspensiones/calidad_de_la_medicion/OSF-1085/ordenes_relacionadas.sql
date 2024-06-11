select o.order_id,
       o1.task_type_id,
       o.related_order_id,
       o1.order_status_id,
       o1.operating_unit_id,
       o.rela_order_type_id
  from open.or_related_order o
  inner join open.or_order o1 on o1.order_id = o.related_order_id
 Where o.order_id in (280212383);
