select servsusc.sesunuse  "Producto",
       servsusc.sesususc  "Contrato", sesucate , sesusuca , sesucicl,
       servsusc.sesuserv ||'- '|| servicio.servdesc  "Tipo de producto",
       case when servsusc.sesuesfn = 'C' then 'Castigado'
         when servsusc.sesuesfn = 'A' then 'Al dia'
          when servsusc.sesuesfn = 'M' then 'En mora'
           when servsusc.sesuesfn = 'D' then 'En deuda' end  "Estado financiero",
       servsusc.sesuesco ||'- '|| initcap(estacort.escodesc)  "Estado de corte",
       pr_product.product_status_id ||'- '|| ps_product_status.description  "Estado del producto",
       servsusc.sesusafa  "Saldo a favor"
from open.servsusc
inner join open.servicio on servicio.servcodi = servsusc.sesuserv
inner join open.estacort on estacort.escocodi = servsusc.sesuesco
inner join open.pr_product on pr_product.product_id = servsusc.sesunuse
inner join open.ps_product_status on ps_product_status.product_status_id = pr_product.product_status_id
where sesusafa= 0 and sesucate in (2,3)
and  ( select count( distinct (cucocodi)) from cuencobr where cuconuse = sesunuse and cucosacu>0 )>3
and exists (select null from diferido d where difenuse = sesunuse and sesususc = difesusc and difesape = 0 and difeprog like 'GCNED')
order by servsusc.sesusafa desc