select pr_product.subscription_id  "Contrato", pr_product.product_id   "Producto", pr_product.product_type_id  "Tipo", 
       pr_product.product_status_id || '-  ' || ps_product_status.description as "Estado", 
       servsusc.sesuesco || '-  ' || initcap(estacort.escodesc) as "Estado de corte",
       case when servsusc.sesuesfn = 'C' then 'Castigado' 
         when servsusc.sesuesfn = 'A' then 'Al dia' 
          when servsusc.sesuesfn = 'M' then 'En mora' 
           when servsusc.sesuesfn = 'D' then 'En deuda' end  "Estado financiero"
from open.cuencobr
inner join open.pr_product on pr_product.product_id = cuencobr.cuconuse
inner join open.servsusc on servsusc.sesunuse = pr_product.product_id
inner join open.ps_product_status on ps_product_status.product_status_id = pr_product.product_status_id
inner join open.estacort on estacort.escocodi = servsusc.sesuesco
where cuencobr.cucosacu > 0
and (select count(distinct c.cucocodi)
    from cuencobr  c
    where c.cuconuse = pr_product.product_id
    and c.cucosacu > 0) > 2
and rownum <= 10;