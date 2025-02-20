--identificar_productos_para_castigo
select sesunuse  producto,
       sesususc  contrato,
       sesuesfn  estado_financiero,
       sesuesco  estado_corte
from servsusc
inner join pr_product  on product_id = sesunuse
where product_type_id = 7014
and   sesuesfn = 'C'
and   sesuesco = 5
and   product_status_id = 2



--update servsusc  set sesuesco = 1 where sesunuse = 50041430
--update servsusc  set sesuesfn = 'A' where sesunuse = 38000956
