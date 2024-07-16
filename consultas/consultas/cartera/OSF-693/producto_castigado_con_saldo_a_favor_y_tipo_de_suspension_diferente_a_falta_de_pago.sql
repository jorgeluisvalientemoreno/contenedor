select servsusc.sesunuse  "Producto", 
       servsusc.sesususc  "Contrato", 
       servsusc.sesuserv ||'- '|| servicio.servdesc  "Tipo de producto", 
       case when servsusc.sesuesfn = 'C' then 'Castigado' end "Estado financiero", 
       servsusc.sesuesco ||'- '|| initcap(estacort.escodesc)  "Estado de corte",
       pr_product.product_status_id ||'- '|| ps_product_status.description  "Estado del producto",
       servsusc.sesusafa  "Saldo a favor",
       pr_prod_suspension.suspension_type_id ||'- '|| ge_suspension_type.description  "Tipo de suspension"
from open.servsusc
inner join open.servicio on servicio.servcodi = servsusc.sesuserv
inner join open.estacort on estacort.escocodi = servsusc.sesuesco  
inner join open.pr_product on pr_product.product_id = servsusc.sesunuse
inner join open.ps_product_status on ps_product_status.product_status_id = pr_product.product_status_id
inner join open.pr_prod_suspension on pr_prod_suspension.product_id = pr_product.product_id
inner join open.ge_suspension_type on ge_suspension_type.suspension_type_id = pr_prod_suspension.suspension_type_id
where servsusc.sesuesfn = 'C'
and servsusc.sesusafa > 0
and pr_prod_suspension.active = 'Y'
and pr_prod_suspension.inactive_date is null
and pr_prod_suspension.suspension_type_id not in (2)
order by servsusc.sesusafa desc;