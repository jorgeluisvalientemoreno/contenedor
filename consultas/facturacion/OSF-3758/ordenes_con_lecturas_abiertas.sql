--ordenes_con_lecturas_abiertas
select a.subscription_id  "Contrato",
       a.product_id  "Producto",
       ss.sesucicl ||' : '|| initcap(c.cicldesc)  "Ciclo",
       p.product_status_id  "Estado Producto",
       ss.sesuesfn  "Estado Financiero",
       ss.sesuesco  "Estado Corte",
       o.order_id  "Orden",
       o.task_type_id ||' : '|| initcap(tt.description)  "Tipo de trabajo",
       a.activity_id ||' : '|| initcap(i.description)  "Actividad",
       o.order_status_id ||' : '|| oe.description  "Estado",
       o.created_date   "Fecha de creacion"
from open.or_order  o
left join open.or_order_activity a on a.order_id = o.order_id
left join open.or_task_type  tt on tt.task_type_id = o.task_type_id
left join open.ge_items i on i.items_id = a.activity_id
left join open.or_order_status oe on oe.order_status_id = o.order_status_id
left join open.servsusc ss on ss.sesunuse = a.product_id
left join pr_product  p  on p.product_id = ss.sesunuse
left join ciclo  c  on c.ciclcodi = ss.sesucicl
where o.task_type_id in (12130, 12134)
and    p.product_status_id not in (3, 16)
and    ss.sesuesfn not in ('C')
and exists (select null 
             from or_order_activity  a2,  or_order  o2
             where a2.product_id = ss.sesunuse
              and  o2.order_id = a2.order_id
              and  o2.task_type_id = 12617
              and  o2.order_status_id in (0,5))
and a.product_id = 17083035          
order by o.created_date desc
