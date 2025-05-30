--productos_con_consumos_no_liquidados
select ss.sesususc  "Contrato",
       p.product_id  "Producto",
       ss.sesucicl  "Ciclo",
       p.product_status_id  "Estado Producto",
       ss.sesuesfn  "Estado Financiero",
       ss.sesuesco  "Estado Corte"
from servsusc ss 
left join pr_product  p  on p.product_id = ss.sesunuse
where  p.product_type_id = 7014
and  p.product_status_id not in (3, 16, 15)
and    ss.sesuesfn not in ('C')
and exists (select null 
             from conssesu c
             where c.cosssesu = ss.sesunuse
              and cossmecc = 4
              and cossflli = 'N')
and rownum <= 30                      

