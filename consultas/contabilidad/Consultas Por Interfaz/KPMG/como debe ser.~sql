select perifact, ic.clcocodi, ic.clcodesc, sum(capital) capital, ii.clcocodi, ii.clcodesc, sum(modivain) modivain
  from open.concepto cc, open.concepto ci, open.ic_clascont ic, open.ic_clascont ii,
       (select perifact, diferido, difeconc, concinte, difevatd, difesape, (difesape + capital) capital, modivacu, 
               modicuap, modivain
        from   (select perifact, diferido, d.difevatd, difesape, difeconc, concinte,
                      (select sum(modivacu) from open.movidife mo
                       where mo.modidife = diferido and mo.modicuap >= m.modicuap and modisign = 'CR') capital,
                      modivacu, modicuap, modivain
                 from open.movidife m, open.diferido d,
                      (select trunc(cargfecr) cargfecr, cargconc concinte, to_char(factfege,'YYYYMM') perifact, 
                               substr(c.cargdoso,4,8) Diferido
                       from   open.cargos c, OPEN.CUENCOBR cu, OPEN.FACTURA fa
                       where  c.CARGCUCO = cu.CUCOCODI
                       AND    fa.factcodi = cu.CUCOfact
                       and    fa.FACTFEGE BETWEEN to_date('01/06/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')
                                              and to_date('30/06/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')
                       and    c.cargtipr = 'A'
                       and    c.cargsign NOT IN ('PA','AP','SA')
                       and    c.cargcaca in ('51')
                       and    substr(c.cargdoso, 1, 2) = 'ID')
                 where d.difecodi = diferido
                   and m.modidife = d.difecodi
                   and trunc(m.modifech) = cargfecr)) U
 where u.difeconc  = cc.conccodi
   and cc.concclco = ic.clcocodi
   and u.concinte  = ci.conccodi
   and ci.concclco = ii.clcocodi
group by perifact, ic.clcocodi, ic.clcodesc, ii.clcocodi, ii.clcodesc
