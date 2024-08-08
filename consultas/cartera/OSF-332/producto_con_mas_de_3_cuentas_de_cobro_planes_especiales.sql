select c.cuconuse  Producto, 
       p.subscription_id  Contrato,
       s.sesucicl  Ciclo, 
       ps.description  Estado_Producto, 
       s.sesuesfn Estado_Financiero, 
       ec.escodesc  Estado_Corte, 
       s.sesucate  Categoria, 
       count (distinct c.cucocodi)  Cuenta_Cobro_Pendiente
from open.cuencobr  c  
inner join open.servsusc  s on s.sesunuse = c.cuconuse
inner join open.pr_product  p on p.product_id = c.cuconuse
inner join open.ps_product_status  ps on ps.product_status_id = p.product_status_id
inner join open.estacort  ec on ec.escocodi = s.sesuesco
inner join open.diferido  d on d.difesusc = p.subscription_id
where c.cucosacu > 0
and s.sesucate = 1
and c.cuconuse = 1115621
and s.sesuesco = 3
and p.product_status_id = 2
and d.difepldi in (3,68,94,95,96,98,99,100,102,103,104,105,106,107,121,115,135,136,143,144,145,146,148,149,153,154,155,156)
and s.sesuesfn = 'M'
having count (distinct c.cucocodi) > 3
Group by c.cuconuse, p.subscription_id, s.sesucicl, ps.description, s.sesuesfn, ec.escodesc, s.sesucate;