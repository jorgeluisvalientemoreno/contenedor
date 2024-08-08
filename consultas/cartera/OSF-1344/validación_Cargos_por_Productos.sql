select sesucate "Categoria" , sesusuca "Subcategoria" ,
       cargconc || '  -' || initcap(concdesc) as "Concepto",
       cargcaca "Causal",
       cargsign "Signo",
       sesucicl "ciclo",
       cargfecr "Fecha cargos",
       decode (cargsign, 'CR', - cargvalo, 'DB', cargvalo, 'SA', cargvalo)  "Valor"
from cargos 
left  join servsusc on cargnuse = sesunuse
left join concepto on cargconc =  conccodi 
left join estacort on escocodi = sesuesco
left join pr_product pr on cargnuse= product_id 
left join ps_product_status ps on ps.product_status_id = pr.product_status_id 
where sesususc in (1117400, 1156800,1157700, 1117714) 
and cargfecr >= '30/08/2023' --and cargcaca in (4,50)
and cargsign != 'PA'
and cargcaca != 53
order by cargfecr desc 
