select sum(capital), sum(modivain)
from   (select perifact, diferido, difevatd, difesape, (difesape + capital) capital, modivacu, modicuap, modivain
        from   (select perifact, diferido, d.difevatd, difesape, 
                       (select sum(modivacu) from open.movidife mo
                        where mo.modidife = diferido and mo.modicuap >= m.modicuap and modisign = 'CR') capital,
                       modivacu, modicuap, modivain
                  from open.movidife m, open.diferido d,
                       (select trunc(cargfecr) cargfecr, to_char(factfege,'YYYYMM') perifact, substr(c.cargdoso,4,8) Diferido
                        from   open.cargos c, OPEN.CUENCOBR cu, OPEN.FACTURA fa
                        where  c.CARGCUCO  = cu.CUCOCODI
                        and    fa.factcodi = cu.CUCOfact
                        and    fa.FACTFEGE BETWEEN to_date('01/06/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')     
                                               and to_date('30/06/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')    
                        and    c.cargtipr = 'A'    
                        and    c.cargsign NOT IN ('PA','AP','SA')
                        and    c.cargcaca in ('51')
                        --and    c.cargdoso = 'ID-8074379'
                        and    substr(c.cargdoso, 1, 2) = 'ID')
                 where d.difecodi = diferido
                   and m.modidife = d.difecodi
                   and trunc(m.modifech) = cargfecr))