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
where cargnuse  in (6622491)
and   cargfecr >= '01/01/2024'
 ORDER BY cargfecr DESC 
