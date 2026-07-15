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
where sesususc in (14218626,17176484,17174395,38000904,14218165,14218870,38000911,14218163,17176070,14219327,14218407,2174649,2184441,14218166,36000023) 
and cargfecr >'11/07/2023' --and cargcaca in (4,50)
ORDER BY cargfecr DESC 
