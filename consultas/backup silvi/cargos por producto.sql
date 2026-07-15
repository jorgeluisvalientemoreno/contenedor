select cargcuco "Cuenta de cobro",
       sesususc "Contrato",
       sesuserv "Tipo de producto",
       cargnuse "Producto",
       sesuesco || ' - ' ||  initcap(escodesc) "Estado_corte",
       pr.product_status_id || ' - ' || initcap(ps.description) "Estado_producto",
       cargconc || '  -' || initcap(concdesc) as "Concepto",/*concclco || '  - ' || initcap(clcodesc ) "Clasificador contable" ,*/
       cargcaca "Causal",cargunid "unidades", 
       cargsign "Signo",
       cargtipr  "Tipo",cargvabl ,
       cargpefa "Periodo fact", cargpeco "Periodo cons" ,cargvalo,
     --  decode (cargsign, 'CR', - cargvalo, 'DB', cargvalo, 'SA', cargvalo, 'AS', - cargvalo, cargvalo) "Valor",
       -- decode (cargsign, 'CR', - cargunid, 'DB', cargunid, 'SA', cargunid, 'AS', - cargunid, cargunid) "Unidades",
       cargdoso "Documento soporte",cargprog "Programa cargos", 
       cargfecr "Fecha cargos",
       pc.pecsfeci 
from cargos 
left  join servsusc on cargnuse = sesunuse
left join concepto on cargconc =  conccodi
left join ic_clascont on concclco = clcocodi  
left join estacort on escocodi = sesuesco
left join pr_product pr on cargnuse= product_id 
left join ps_product_status ps on ps.product_status_id = pr.product_status_id 
left join pericose pc on cargpeco = pc.pecscons
where sesunuse   in (52757716)
 ORDER BY cargfecr  DESC 

--select * from concbali c where c.coblcoba in ( 980,201) for update 
