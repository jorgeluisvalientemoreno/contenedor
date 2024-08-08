--cargos_por_producto_por_conceptos
select cargcuco "Cuenta de cobro",
       sesususc "Contrato",
       sesuserv "Tipo de producto",
       cargnuse "Producto",
       cargconc || '  -' || initcap(concdesc) as "Concepto",
       cargcaca || ' -' || initcap(cacadesc) "Causal",
       cargprog || ' -' || initcap(p.procdesc) "Programa",
       cargsign "Signo",
       cargtipr  "Tipo",
       cargdoso "Documento soporte",
       decode (cargsign, 'CR', - cargvalo, 'DB', cargvalo, 'SA', cargvalo, 'AS', - cargvalo, cargvalo)  "Valor",
       cargfecr "Fecha cargos",
       cargcodo "Consecutivo",
       concclco || '  - ' || initcap(clcodesc ) "Clasificador contable" ,
       cargpefa "Periodo fact",
       sesuesco || ' - ' ||  initcap(escodesc) "Estado_corte",
       pr.product_status_id || ' - ' || initcap(ps.description) "Estado_producto"
from cargos 
left  join servsusc on cargnuse = sesunuse
left join concepto on cargconc =  conccodi
left join IC_CLASCONT on concclco = CLCOCODI  
left join estacort on escocodi = sesuesco
left join CAUSCARG on cargcaca = cacacodi 
left join pr_product pr on cargnuse= product_id 
left join procesos  p on p.proccons = cargprog 
left join ps_product_status ps on ps.product_status_id = pr.product_status_id 
where sesususc  in (1129766)
and cargcuco in (2989540663)
and cargfecr <= '20/11/2023'
and cargconc in (31)
and cargsign = 'CR'
 order by cargfecr desc, cargcuco, cargconc 
--and cargprog = 5

--and cargcuco in (3017360976)
--and cargconc in (31, 130 , 196, 167)

--and cargsign = 'DB'



-- and cargsign = 'CR'

----
