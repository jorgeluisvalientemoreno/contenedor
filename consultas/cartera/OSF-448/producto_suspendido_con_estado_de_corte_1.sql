select pr.subscription_id  Contrato, 
       pr.product_id  Producto, 
       s.sesucicl  Ciclo, 
       pr.product_type_id  Tipo_Producto, 
       pr.product_status_id || '-  ' || ps.description as Estado_Producto, 
       s.sesuesco || '-  ' || escodesc as Estado_Corte,
       s.sesucate || '-  ' || c.catedesc as Categoria
from open.pr_product  pr
inner join open.servsusc  s on s.sesunuse = pr.product_id
inner join open.ps_product_status  ps on ps.product_status_id = pr.product_status_id
inner join open.categori  c on c.catecodi = s.sesucate
inner join open.estacort  ec on ec.escocodi = s.sesuesco
where pr.product_status_id = 2
and s.sesucate = 1
and s.sesuesco = 1
and product_type_id = 7014