select /*+ leading (vwrc_payments) index(vwrc_payments.pagos_norm IX_PAGO_SUSC)
            use_nl_with_index(cupon pk_cupon)
            use_nl_with_index(banco pk_banco)
            use_nl_with_index(sucubanc pk_sucubanc)*/
 pagocupo pagocupo,
 pagofegr pagofegr,
 pagofepa pagofepa,
 pagobanc || ' - ' || bancnomb pagobanc,
 pagosuba || ' - ' || subanomb pagosuba,
 pagovapa pagovapa,
 pagousua pagousua,
 pagotipa pagotipa,
 pagosusc pagosusc,
 pagopref pagopref,
 pagonufi pagonufi,
 RC_BCInformacionPagos.fsbGetTipoComp(pagocupo) pagotico,
 pagonutr pagonutr,
 pagoconc pagoconc,
 (SELECT NVL(sum(crcdvacu), 0) FROM curechde WHERE crcdcupo = pagocupo) ValorReactivado,
 cupotipo cupotipo,
 pagocupo || ';' || pagosusc Id
  from /*vwrc_payments*/ pagos, banco, sucubanc, cupon
 where pagobanc = banccodi
   and pagobanc = subabanc
   and pagosuba = subacodi
   and pagocupo = cuponume
   and pagosusc = 48155525;

select /*+ leading (cargos) index(cargos IX_CARG_CODO)
        use_nl_with_index(cuencobr PK_CUENCOBR)
        use_nl_with_index(servsusc PK_SERVSUSC)
        use_nl_with_index(perifact PK_PERIFACT)
        use_nl_with_index(factura PK_FACTURA)
        use_nl_with_index(ta_tariconc PK_TA_TARICONC)*/
 --cargos.rowid rowid_,
 cargos.cargcuco cargcuco,
 servsusc.sesususc cargsusc,
 cargos.cargnuse cargnuse,
 cargos.cargvalo cargvalo,
 cargos.cargfecr cargfech,
 --cuencobr.cucofact cargfact,
 --perifact.pefacicl || ' - ' || cc_bobssdescription.fsbCicle(perifact.pefacicl) cicle,
 --cargos.cargpefa || ' - ' || perifact.pefadesc period,
 --factura.factfege cucofege,
 --cuencobr.cucofeve cucofeve,
 --factura.factpref factpref,
 --factura.factnufi factnufi,
 cargos.cargtaco cargtaco,
 --ta_tariconc.tacotimo tacotimo,
 cargos.cargdoso cargdoso,
 --cuencobr.cucocodi cucocodi,
 cargos.cargsign cargsign
  from cargos
  left join servsusc
    on servsusc.sesunuse = cargos.cargnuse
  --left join cuencobr on cuencobr.cucocodi = cargos.cargcuco
  --left join factura on factura.factcodi = cuencobr.cucofact
  --left join perifact on perifact.pefacodi = cargos.cargpefa
  --left join ta_tariconc on ta_tariconc.tacocons = cargos.cargtaco
 where cargos.cargfecr > '01/01/2024'
-- cargsign IN ('PA', 'SA')
--and cargcodo = 729199141
--and 
 sesususc = 48155525
 
