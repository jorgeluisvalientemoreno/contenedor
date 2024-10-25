--Cargos 
select f.factcodi "Factura",
       c.cargcuco "Cuenta de cobro",
       c.cargconc || ' - ' || initcap(concdesc) as "Concepto",
       c.cargfecr "Fecha Creacion",
       c.cargcaca || ' - ' || causalc.cacadesc "Causal",
       c.cargunid "unidades",
       c.cargsign || ' - ' || signo.signdesc "Signo",
       decode(c.cargtipr, 'A', 'A - Automatico', 'M - Manual') "Tipo Programa",
       c.cargpefa "Periodo facturacion",
       c.cargpeco "Periodo consumo",
       pc.pecsfeci "Fecha incial Periodo consumo",
       c.cargvalo "Valor",
       c.cargvabl "Base Liquidacion",
       c.cargcodo "Consecutivo",
       c.cargdoso "Documento soporte",
       c.cargprog || ' - ' || p.procdesc "Programa cargos",
       c.cargfecr "Fecha cargos",
       s.sesususc "Contrato",
       pr.product_id "Producto",
       pr.product_type_id || ' - ' || sp.servdesc "Tipo de producto",
       pr.product_status_id || ' - ' || initcap(ps.description) "Estado_producto",
       s.sesunuse "Servicio",
       s.sesuserv || ' - ' || ssv.servdesc "Tipo de servicio",
       s.sesuesco || ' - ' || initcap(ec.escodesc) "Estado_corte",
       s.sesucicl "Ciclo",
       c.cargpefa || ' - ' || pf.pefadesc "Periodo Facturacion"
  from open.cargos c
  left join open.servsusc s
    on c.cargnuse = s.sesunuse
  left join open.estacort ec
    on ec.escocodi = s.sesuesco
  left join open.concepto co
    on c.cargconc = co.conccodi
  left join open.cuencobr cc
    on cc.cucocodi = c.cargcuco
  left join open.factura f
    on f.factcodi = cc.cucofact
  left join open.pr_product pr
    on c.cargnuse = pr.product_id
  left join open.ps_product_status ps
    on ps.product_status_id = pr.product_status_id
  left join open.pericose pc
    on c.cargpeco = pc.pecscons
  left join open.CAUSCARG causalc
    on causalc.cacacodi = c.cargcaca
  left join open.SIGNO
    on signo.signcodi = c.cargsign
  left join OPEN.PERIFACT pf
    on pf.pefacodi = c.cargpefa
  left join OPEN.PROCESOS p
    on p.proccons = c.cargprog
  left join OPEN.SERVICIO ssv
    on ssv.servcodi = s.sesuserv
  left join OPEN.SERVICIO sp
    on sp.servcodi = pr.product_type_id
 where sesususc in (67569881)
   and trunc(cargfecr) >= '12/08/2024' --sysdate - 10
   --and c.cargdoso = 'PP-214849930'
   and c.cargconc in (291,991)
 ORDER BY cargfecr DESC;
