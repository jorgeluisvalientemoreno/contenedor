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
 Where o.task_type_id in
       (select p.task_type_id
          from open.ldc_procedimiento_obj p
         where p.procedimiento = 'LDC_PRUSUARIOS_SUSP_CART'
           and p.activo = 'S')
   and o.order_status_id in (5)
   and rownum <= 5
 order by o.created_date desc;
