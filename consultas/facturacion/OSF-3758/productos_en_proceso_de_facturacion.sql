--productos_en_proceso_de_facturacion
select ss.sesususc  "Contrato",
       p.product_id  "Producto",
       ss.sesucicl  "Ciclo",
       p.product_status_id  "Estado Producto",
       ss.sesuesfn  "Estado Financiero",
       ss.sesuesco  "Estado Facturacion",
       sc.suscnupr "En Facturacion"
from servsusc ss 
left join pr_product  p  on p.product_id = ss.sesunuse
left join suscripc  sc  on sc.susccodi = ss.sesususc
where  p.product_type_id = 7014
and  p.product_status_id not in (3, 16, 15)
and    ss.sesuesfn not in ('C')
and    sc.suscnupr = 2
and exists (select null 
             from conssesu c, procejec pp
             where c.cosssesu = ss.sesunuse
              and   c.cosspefa = pp.prejcope
              and cossmecc = 4
              and cossflli = 'S'
              and pp.prejprog = 'FGCC'
              and pp.prejespr != 'T')
and rownum <= 10                      
