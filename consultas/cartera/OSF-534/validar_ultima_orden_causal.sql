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
where o.order_id in
       (select max(b.order_id)
        from open.or_order_activity b
        where b.product_id = 1334587
        and b.subscription_id = 1093798
        and b.task_type_id in
       (dald_parameter.fnugetNumeric_Value('LDC_TT_NOTI_CONST', 0),
        dald_parameter.fnugetNumeric_Value('LDC_TT_SUSP_CONST', 0),
        dald_parameter.fnugetNumeric_Value('LDC_TT_RECON_CONST', 0)))
and o.order_status_id in (0,5,8);
				