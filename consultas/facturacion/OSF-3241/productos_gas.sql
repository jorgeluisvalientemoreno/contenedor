--productos_gas
select p.product_id  producto,
       p.subscription_id  contrato,
       c.suscclie  cliente,
       p.product_type_id  tipo_producto,
       p.product_status_id  estado_producto,
       s.sesucate  categoria,
       s.sesuesfn  estado_financiero,
       s.sesuesco  estado_corte,
       s.sesucicl  ciclo
from pr_product  p
inner join servsusc  s  on s.sesunuse = p.product_id
inner join suscripc  c  on c.susccodi = s.sesususc
where p.product_type_id = 7014
and not exists (select 1
                 from clientes_estacionales  ce
                  where s.sesunuse = ce.producto) 

--and p.product_id = 17232000
--and p.product_status_id = 2
