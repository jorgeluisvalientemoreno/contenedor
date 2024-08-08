select cargcuco "Cuenta de cobro",
       sesususc "Contrato",
       sesuserv "Tipo de producto",
       cargnuse "Producto",sesucate "Categoria" , sesusuca "Subcategoria" ,
       cargconc || '  -' || initcap(concdesc) as "Concepto",
       cargcaca "Causal",
       cargsign "Signo",
       cargtipr  "Tipo",
       sesucicl "ciclo",
       cargvalo "Valor",cargcodo "Consecutivo",
       cargdoso "Documento soporte",
       cargfecr "Fecha cargos"
from cargos 
left  join servsusc on cargnuse = sesunuse
left join concepto on cargconc =  conccodi 
left join estacort on escocodi = sesuesco
left join pr_product pr on cargnuse= product_id 
left join ps_product_status ps on ps.product_status_id = pr.product_status_id 
where sesususc in (67347586) 
and cargfecr >'1/08/2023' 
ORDER BY cargfecr DESC 
