select cargcuco "Cuenta de cobro",
       sesususc "Contrato",
       sesuserv "Tipo de producto",
       cargnuse "Producto",
       sesuesco || ' - ' ||  initcap(escodesc) "Estado_corte",
       pr.product_status_id || ' - ' || initcap(ps.description) "Estado_producto",
       cargconc || '  -' || initcap(concdesc) as "Concepto",concclco || '  - ' || initcap(clcodesc ) "Clasificador contable" ,
       cargcaca || ' -' || initcap(cacadesc) "Causal",
       cargsign "Signo",
       cargtipr  "Tipo",
       cargpefa "Periodo fact",
       cargvalo "Valor",cargcodo "Consecutivo",
       cargdoso "Documento soporte",
       cargfecr "Fecha cargos"
from cargos 
left  join servsusc on cargnuse = sesunuse
left join concepto on cargconc =  conccodi
left join IC_CLASCONT on concclco = CLCOCODI  
left join estacort on escocodi = sesuesco
left join CAUSCARG on cargcaca = cacacodi 
left join pr_product pr on cargnuse= product_id 
left join ps_product_status ps on ps.product_status_id = pr.product_status_id 
where sesunuse  in (1129766)
and cargcuco in (2989540663)
--and cargconc in (31, 130 , 196, 167 )
 ORDER BY cargcuco, cargfecr desc 

