select a.subscription_id  "Contrato",
       a.product_id  "Producto",
       ss.sesucicl  "Ciclo",
       o.order_id  "Orden",
       o.task_type_id ||' : '|| initcap(tt.description)  "Tipo de trabajo",
       a.activity_id ||' : '|| initcap(i.description)  "Actividad",
       o.order_status_id ||' : '|| oe.description  "Estado",
       o.created_date   "Fecha de creacion",
       o.legalization_date  "Fecha de legalizacion"
from open.or_order  o
left join open.or_order_activity a on a.order_id = o.order_id
left join open.or_task_type  tt on tt.task_type_id = o.task_type_id
left join open.ge_items i on i.items_id = a.activity_id
left join open.or_order_status oe on oe.order_status_id = o.order_status_id
left join open.servsusc ss on ss.sesunuse = a.product_id
where sesunuse is not null 
and o.task_type_id in (12130, 12134)
and a.product_id = 17248594
order by o.legalization_date desc

