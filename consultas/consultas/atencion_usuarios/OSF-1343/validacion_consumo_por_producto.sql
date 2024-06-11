select cargcuco "Cuenta de cobro",
       sesususc "Contrato",
       sesuserv "Tipo de producto",
       cargnuse "Producto",
       sesuesco || ' -' ||  initcap(escodesc) "Estado_corte",
       pr.product_status_id || ' -' || initcap(ps.description) "Estado_producto",
       cargconc || '  -' || initcap(concdesc) as "Concepto",
       cargcaca "Causal",
       cargsign "Signo",
       cargpefa "Periodo fact",
       cargvalo "Valor",
       cargdoso "Documento soporte",
       cargfecr "Fecha cargos"
from cargos 
left  join servsusc on cargnuse = sesunuse
left join concepto on cargconc =  conccodi 
left join estacort on escocodi = sesuesco
left join pr_product pr on cargnuse= product_id 
left join ps_product_status ps on ps.product_status_id = pr.product_status_id 
where sesususc  = 48000651
and cargpefa= 103689
and cargconc in (31, 130 , 196, 167 )
and cargcaca in (15,59)
