--cargos_generados
select cargcuco "Cuenta de cobro",
       sesususc "Contrato",
       sesuserv "Tipo de producto",
       cargnuse "Producto",
       cargconc || '  -' || initcap(concdesc) as "Concepto",
       cargcaca || ' -' || initcap(cacadesc) "Causal",
       cargsign "Signo",
       cargtipr  "Tipo",
       cargdoso "Documento soporte",
       cargprog || ' -' || initcap(p.procdesc) "Programa",
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
left join procesos  p on p.proccons = cargprog 
left join pr_product pr on cargnuse= product_id 
left join ps_product_status ps on ps.product_status_id = pr.product_status_id 
where 1 = 1
and  sesususc  in (1000895)
and cargfecr >= '02/05/2025'
 ORDER BY cargcuco, cargconc, cargfecr DESC 

/*and cargsign = 'CR'
and cargfecr >= '27/11/2023'
and cargfecr <= '28/11/2023'*/



--and cargsign in ('DB', 'CR')
-- and cargcuco in (3048839564, 3047035282)

--and cargcuco in (3047716343)



