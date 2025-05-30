--productos_con_lecturas_abiertas
select ss.sesususc  "Contrato",
       p.product_id  "Producto",
       ss.sesucicl  "Ciclo",
       p.product_status_id  "Estado Producto",
       ss.sesuesfn  "Estado Financiero",
       ss.sesuesco  "Estado Corte"
from servsusc ss 
left join pr_product  p  on p.product_id = ss.sesunuse
where  p.product_status_id not in (3, 16)
and    ss.sesuesfn not in ('C')
and exists (select null 
             from or_order_activity  a2,  or_order  o2
             where a2.product_id = ss.sesunuse
              and  o2.order_id = a2.order_id
              and  o2.task_type_id = 12617
              and  o2.order_status_id in (0,5))
--and p.product_id != 17153599         
and rownum <= 10                      
