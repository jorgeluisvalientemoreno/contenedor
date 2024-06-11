select sesususc, sesucicl "ciclo", c.*
        /*sesucate "Categoria" , sesusuca "Subcategoria" ,
       cargconc || '  -' || initcap(concdesc) as "Concepto",
       cargcaca "Causal",
       cargsign "Signo",
       sesucicl "ciclo",
       cargfecr "Fecha cargos",cargvalo, decode (cargsign, 'CR', - cargvalo, 'DB', cargvalo, 'SA', cargvalo, 'AS', - cargvalo, cargvalo) "Valor"*/
from cargos c
left  join servsusc on cargnuse = sesunuse
left join concepto on cargconc =  conccodi 
left join estacort on escocodi = sesuesco
left join pr_product pr on cargnuse= product_id 
left join ps_product_status ps on ps.product_status_id = pr.product_status_id 
where /*sesususc in (48040637,48040637,1129766,17110115,48040637,48054395,48054396,17110115,48054393,48054395,48055545,1129766,1129766,48006569,
48006569,48006569,48055545,48007639,48007639,1129766,1129766,5160520,48054397,48054391,48054391,1129766,17110115,48085409,48085611,48054397,22000194,48055633,48041269,
48006877,48054391,17110115,17110115,1129766,48083761,48083761,66247084,6202086,6202086,17110115,1129766,17138177,17138177,17138177,48010371,48035401) 
and */cargfecr between '01/12/2023 0:00:00' and '02/12/2023 23:59:59' --and cargcaca in (4,50)
and sesucicl = 1301
ORDER BY cargfecr DESC 
