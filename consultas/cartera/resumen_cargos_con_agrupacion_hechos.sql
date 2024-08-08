select sesucate "Categoria" , sesusuca "Subcategoria" ,
       cargconc || '  -' || initcap(concdesc) as "Concepto",
       cargcaca "Causal",
       cargsign "Signo",
       sesucicl "ciclo",
       cargfecr "Fecha cargos",cargvalo "Valor"
from cargos 
left  join servsusc on cargnuse = sesunuse
left join concepto on cargconc =  conccodi 
left join estacort on escocodi = sesuesco
left join pr_product pr on cargnuse= product_id 
left join ps_product_status ps on ps.product_status_id = pr.product_status_id 
ORDER BY cargfecr DESC 
