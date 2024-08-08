select a.product_id,
       a.subscription_id,
       o.task_type_id,
       t.description,
       o.order_id,
       o.order_status_id,
       o.created_date,
       o.causal_id,
       ge.description descripcion_causal,
       ge.class_causal_id        
 from open.or_order o
 inner join open.or_task_type t on t.task_type_id = o.task_type_id
 inner join open.or_order_activity a on a.order_id = o.order_id
 left join open.ge_causal ge on  o.causal_id =  ge.causal_id
 Where o.task_type_id in (10784,10785,10786)
 and o.order_status_id in (0,5,8)
 and a.product_id =1467137  
 and a.subscription_id = 1203519
order by o.created_date desc;