select a.product_id,
       o.task_type_id,
       t.description,
       a.activity_id,
       o.order_id,
       o.created_date,
       o.order_status_id,      
       o.legalization_date,
       o.causal_id,
       cc.class_causal_id  || ' ' || cc.description as clase,
       da.name_1,
        da.value_1   
  from or_order o
left join or_task_type t on t.task_type_id = o.task_type_id
left join or_order_activity a on a.order_id = o.order_id
left join  open.ge_causal c on o.causal_id = c.causal_id 
left join open.ge_class_causal cc on cc.class_causal_id = c.class_causal_id
left join or_requ_Data_value da on da.order_id = o.order_id
Where/* o.task_type_id = 12620
and *//* o.order_status_id in (0,5)
and*/ a.product_id =50604737
--and o.order_id =263205920
order by o.created_date desc;
--a.package_id,
-- o.created_date,
