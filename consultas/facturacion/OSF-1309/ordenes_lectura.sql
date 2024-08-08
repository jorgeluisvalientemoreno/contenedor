select a.product_id,
       s.sesucicl,
       o.task_type_id,
       t.description,
       o.order_id,
       o.order_status_id,
       o.causal_id,
       c.description          desc_causal,
       c.class_causal_id      clase_causal,
       o.operating_unit_id,
       o.created_date,
       o.execution_final_date,
       o.legalization_date
  from or_order o
 inner join or_task_type t on o.task_type_id = t.task_type_id
  left join or_order_activity a on a.order_id = o.order_id
  left join or_requ_Data_value da on da.order_id = o.order_id
  left join open.ge_causal c on c.causal_id = o.causal_id
  left join or_order_person p on p.order_id = o.order_id
  left join servsusc s on s.sesunuse = a.product_id
 Where a.product_id = 1000867
   and o.task_type_id in (12617)
 order by o.created_date desc
