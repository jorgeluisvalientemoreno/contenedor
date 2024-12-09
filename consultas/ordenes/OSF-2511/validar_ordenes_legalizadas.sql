select o.task_type_id,
       t.description,
       o.order_id,
       o.order_status_id,
       o.causal_id,
       c.description  desc_causal,
       c.class_causal_id  clase_causal,
       o.operating_unit_id,
       p.person_id,
       pe.name_,
       o.created_date,
       o.legalization_date,
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
 left join or_requ_Data_value da on da.order_id = o.order_id
 left join open.ge_causal c on c.causal_id = o.causal_id
 left join or_order_person p on p.order_id= o.order_id
 left join ge_person pe on pe.person_id = p.person_id
 Where o.order_id in (336982402,337122721);
