select o.task_type_id,
       t.description,
       p.product_status_id,
       o.order_id,
       o.order_status_id,
       o.causal_id,
       c.description  desc_causal,
       c.class_causal_id  clase_causal,
       o.operating_unit_id,
       pe.person_id,
       gp.name_,
       o.created_date,
       o.execution_final_date,
       o.legalization_date,
       co.order_comment,
       a.value1,
       da.name_1,
       da.value_1,
       da.name_2,
       da.value_2,
       da.name_3,
       da.value_3
  from or_order o
 inner join or_task_type t on o.task_type_id = t.task_type_id
 left join or_order_activity a on a.order_id = o.order_id
 left join pr_product  p on p.product_id = a.product_id
 left join or_requ_Data_value da on da.order_id = o.order_id
 left join open.ge_causal c on c.causal_id = o.causal_id
 left join or_order_person pe on pe.order_id= o.order_id
 left join ge_person gp on gp.person_id = pe.person_id
 left join or_order_comment co on co.order_id= o.order_id
 Where o.order_id in (323378465)
