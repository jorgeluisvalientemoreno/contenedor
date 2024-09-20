-- FINANCIACION FACTURADA NUEVA
select substr(cargdoso, 1, 2) Tipo, cargcaca, cargsign, cargconc, concdesc, sum(cargvalo)
from open.cargos c, OPEN.CUENCOBR, OPEN.FACTURA, open.CONCEPTO CO, open.CAUSCARG csc,    
     open.procesos, open.ic_clascont, open.perifact, OPEN.SERVSUSC ss    
where c.cargcaca = csc.cacacodi    
  and c.CARGCONC = CO.CONCCODI    
  and concclco in (56,57,58,59,86,87,88,98,102,103,120,121,126)
  and c.cargnuse = ss.sesunuse    
  and sesuserv   = 7056
  AND factcodi   = CUCOfact    
  AND CARGCUCO   = CUCOCODI    
  and clcocodi(+) = concclco    
  and cargpefa   = pefacodi    
  AND FACTFEGE BETWEEN to_date('01/05/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')     
                   and to_date('31/05/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')    
  and cargprog = proccons    
  and cargtipr = 'A'    
  and cargsign not in (/*'NS',*/ 'TS', 'ST', 'DV')
  and (cargcaca in (51) and cargdoso like 'ID%')
group by substr(cargdoso, 1, 2), cargcaca, cargsign, cargconc, concdesc
