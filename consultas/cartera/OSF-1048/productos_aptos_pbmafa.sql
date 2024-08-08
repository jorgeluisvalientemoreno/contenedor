select sesususc "Contrato",
       sesunuse "Producto",
       product_status_id "Estado producto", 
       sesuesco || ' -' || initcap(e.escodesc) "Estado corte",
   case when sesuesfn = 'A' THEN 'Al dia'
        when sesuesfn = 'M' THEN 'En Mora' 
        when sesuesfn = 'D' THEN 'En Deuda'
        when sesuesfn = 'C' THEN 'Castigado' end as  "Estado financiero",
       sesuserv "Tipo_producto",
       c.coecfact "Facturable",
       s.suscnupr "numero de proceso" 
from servsusc se
left join estacort e on e.escocodi = sesuesco
left join confesco c on c.coecserv = sesuserv and c.coeccodi= sesuesco 
left join suscripc s  on s.susccodi= se.sesususc
left join pr_product pr on product_id =sesunuse 
where sesuesco in (1,3)
and sesuesfn  in ('C')
and not exists (select null 
                from cargos
                where cargnuse = sesunuse
                and cargcuco = -1) 
and rownum <= 5;
