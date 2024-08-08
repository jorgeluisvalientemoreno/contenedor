select or_order.order_id,
       or_order.order_status_id ||' : '|| or_order_status.description as "ESTADO",
       or_order.task_type_id ||' : '|| initcap(or_task_type.description) as "TIPO DE TRABAJO",
       or_order.causal_id ||' : '|| initcap(ge_causal.description) as "CAUSAL",
       or_order_comment.order_comment as "COMENTARIO",
       or_order_comment.comment_type_id as "TIPO",
       or_order_comment.register_date as "FECHA DE REGISTRO"
from open.or_order
inner join open.or_order_status on or_order_status.order_status_id = or_order.order_status_id
inner join open.or_task_type on or_task_type.task_type_id = or_order.task_type_id
left join open.ge_causal on ge_causal.causal_id = or_order.causal_id
left join open.or_order_comment on or_order_comment.order_id = or_order.order_id;
