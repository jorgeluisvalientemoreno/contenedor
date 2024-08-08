--ordenes_asignadas_a_unidades_con_material_transito_entrada
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
  from or_order o
 inner join or_task_type t on t.task_type_id = o.task_type_id
 inner join or_order_activity a on a.order_id = o.order_id
 Where o.order_status_id in (5,6,7)
   and exists
   (select 1
   from open.or_ope_uni_item_bala b
   where b.operating_unit_id = o.operating_unit_id
   and  b.transit_in  > 0)
   order by o.created_date desc;
