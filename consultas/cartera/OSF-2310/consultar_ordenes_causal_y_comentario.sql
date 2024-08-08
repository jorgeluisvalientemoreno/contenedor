select o.order_id,
       o.task_type_id ||' : '|| initcap(tt.description) as "TIPO DE TRABAJO",
       o.order_status_id ||' : '|| eo.description as "ESTADO",
       o.causal_id ||' : '|| initcap(c.description) as "CAUSAL"
from open.or_order  o
inner join open.or_order_status eo on eo.order_status_id = o.order_status_id
inner join open.or_task_type  tt on tt.task_type_id = o.task_type_id
left join open.ge_causal  c on c.causal_id = o.causal_id
left join open.or_order_comment co on co.order_id = o.order_id
where o.order_id in (251502718) 
