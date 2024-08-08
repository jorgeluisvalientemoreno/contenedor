--Cargos por servicio
select sesususc contrato,
       cc.cucofact FACTURA,
       (select p.proccons || ' - ' || p.procdesc
          from open.procesos p
         where p.proccons = f.factprog) Programa,
       cargcuco "Cuenta de cobro",
       sesususc "Contrato",
       sesuserv "Tipo de producto",
       cargnuse "Producto",
       sesuesco || ' - ' || initcap(escodesc) "Estado_corte",
       pr.product_status_id || ' - ' || initcap(ps.description) "Estado_producto",
       cargconc || '  -' || initcap(concdesc) as "Concepto", /*concclco || '  - ' || initcap(clcodesc ) "Clasificador contable" ,*/
       cargcaca "Causal",
       cargunid "unidades",
       cargsign "Signo",
       cargtipr "Tipo",
       cargpefa "Periodo fact",
       cargpeco "Periodo cons",
       cargvalo
       --decode (cargsign, 'CR', - cargvalo, 'DB', cargvalo, 'SA', cargvalo, 'AS', - cargvalo, cargvalo) "Valor",
       --decode (cargsign, 'CR', - cargunid, 'DB', cargunid, 'SA', cargunid, 'AS', - cargunid, cargunid) "Unidades"
       ,
       cargcodo    "Consecutivo",
       cargdoso    "Documento soporte",
       cargprog    "Programa cargos",
       cargfecr    "Fecha cargos",
       pc.pecsfeci
--cargos.*--suscripc
  from open.cargos
  left join open.servsusc
    on cargnuse = sesunuse
  left join open.concepto
    on cargconc = conccodi
  left join open.ic_clascont
    on concclco = clcocodi
  left join open.estacort
    on escocodi = sesuesco
  left join open.pr_product pr
    on cargnuse = product_id
  left join open.ps_product_status ps
    on ps.product_status_id = pr.product_status_id
  left join open.pericose pc
    on cargpeco = pc.pecscons
  left join open.cuencobr cc
    on cc.cucocodi = cargos.cargcuco
  left join open.factura f
    on f.factcodi = cc.cucofact
 where sesususc in (703475
)
   and trunc(cargfecr) >= '30/07/2024' --sysdate - 10
 ORDER BY cargfecr DESC;
