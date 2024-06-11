select pr.product_id  Producto, 
       pr.subscription_id  Contrato, 
       pr.product_type_id  Tipo_Producto, 
       pr.product_status_id || '-  ' || ps.description  Estado_Producto, 
       s.sesuesco || '-  ' || escodesc  Estado_Corte, 
       s.sesuesfn  Estado_Financiero
from open.pr_product  pr
inner join open.servsusc  s on s.sesunuse = pr.product_id
inner join open.ps_product_status  ps on ps.product_status_id = pr.product_status_id
inner join open.estacort  ec on ec.escocodi = s.sesuesco
where pr.product_id = 1110264