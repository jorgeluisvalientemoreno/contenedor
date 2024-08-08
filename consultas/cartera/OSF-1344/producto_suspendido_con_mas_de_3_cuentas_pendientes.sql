select pr_product.subscription_id  "Contrato", 
       pr_product.product_id   "Producto", 
       pr_product.product_type_id  "Tipo", 
       pr_product.product_status_id || '-  ' || ps_product_status.description as "Estado", 
       servsusc.sesuesco || '-  ' || initcap(estacort.escodesc) as "Estado de corte",
       case when servsusc.sesuesfn = 'C' then 'Castigado' 
         when servsusc.sesuesfn = 'A' then 'Al dia' 
          when servsusc.sesuesfn = 'M' then 'En mora' 
           when servsusc.sesuesfn = 'D' then 'En deuda' end  "Estado financiero",
       count(distinct cuencobr.cucocodi)  "# de cuentas",
       servsusc.sesucicl  "Ciclo"
from open.pr_product
inner join open.cuencobr on pr_product.product_id = cuencobr.cuconuse
inner join open.servsusc on servsusc.sesunuse = pr_product.product_id
inner join open.ps_product_status on ps_product_status.product_status_id = pr_product.product_status_id
inner join open.estacort on estacort.escocodi = servsusc.sesuesco
inner join open.perifact on perifact.pefacicl = servsusc.sesucicl
where cuencobr.cucosacu > 0
and servsusc.sesucate = 1
and pr_product.product_status_id = 1
--and sesuesco = 5
and pr_product.product_type_id = 7055
and servsusc.sesucicl = 1601
and exists(select null 
from open.perifact  pf
where pf.pefaactu = 'S'
and pf.pefaffmo >= sysdate
and pf.pefacicl = servsusc.sesucicl)
group by pr_product.subscription_id, pr_product.product_id, pr_product.product_type_id,
         pr_product.product_status_id || '-  ' || ps_product_status.description, 
         servsusc.sesuesco || '-  ' || initcap(estacort.escodesc), servsusc.sesuesfn,
         servsusc.sesucicl, servsusc.sesunuse
         
         
         

--and servsusc.sesunuse = 1062715
