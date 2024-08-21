--Cargos 
select f.factcodi "Factura",
       c.cargcuco "Cuenta de cobro",
       c.cargconc || ' - ' || initcap(concdesc) as "Concepto",
       c.cargfecr "Fecha Creacion",
       c.cargcaca || ' - ' || causalc.cacadesc "Causal",
       c.cargunid "unidades",
       c.cargsign || ' - ' || signo.signdesc "Signo",
       c.cargtipr "Tipo",
       c.cargpefa "Periodo facturacion",
       c.cargpeco "Periodo consumo",
       pc.pecsfeci "Fecha incial Periodo consumo",
       c.cargvalo "Valor",
       c.cargvabl "Base Liquidacion",
       c.cargcodo "Consecutivo",
       c.cargdoso "Documento soporte",
       c.cargprog "Programa cargos",
       c.cargfecr "Fecha cargos",
       s.sesususc "Contrato",
       pr.product_id "Producto",
       pr.product_type_id "Tipo de producto",
       pr.product_status_id || ' - ' || initcap(ps.description) "Estado_producto",
       s.sesunuse "Servicio",
       s.sesuserv "Tipo de servicio",
       s.sesuesco || ' - ' || initcap(ec.escodesc) "Estado_corte",
       s.sesucicl "Ciclo"
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
 where sesususc in (67536778)
   and trunc(cargfecr) >= '30/01/2024' --sysdate - 10
 ORDER BY cargfecr DESC;
