select sesuserv, CARGCACA, csc.cacadesc, 
       sum(decode(cargsign, 'AP',  1, 'SA',  1, 'DB',  1, 0) * cargvalo) valor_db,
       sum(decode(cargsign, 'PA', -1, 'AS', -1, 'CR', -1, 0) * cargvalo) valor_cr
from open.cargos c, open.SERVSUSC ss, open.CONCEPTO CO, open.CAUSCARG csc, open.procesos, open.ic_clascont, open.perifact    
where c.cargcaca = csc.cacacodi    
  and c.cargnuse = ss.sesunuse    
  and c.CARGCONC = CO.CONCCODI    
  and c.cargfecr between to_date(to_char('01/12/2015 00:00:00'),'dd/mm/yyyy hh24:mi:ss')    
                     AND to_date(to_char('31/12/2015 23:59:59'),'dd/mm/yyyy hh24:mi:ss')    
  and cargprog = proccons    
  and clcocodi(+) = concclco    
  and cargpefa = pefacodi    
  AND CARGCUCO > 0    
  and cargtipr = 'P'
  and cargsign not in (/*'NS',*/ 'TS', 'ST', 'DV') -- DV = devolucion saldo a favor
group by sesuserv, CARGCACA, csc.cacadesc
UNION ALL   
select sesuserv, CARGCACA, csc.cacadesc,
       sum(decode(cargsign, 'AP',  1, 'SA',  1, 'DB',  1, 0) * cargvalo) valor_db,
       sum(decode(cargsign, 'PA', -1, 'AS', -1, 'CR', -1, 0) * cargvalo) valor_cr
from open.cargos c, OPEN.CUENCOBR, OPEN.FACTURA, open.CONCEPTO CO,  open.CAUSCARG csc,    
     open.procesos, open.ic_clascont, open.perifact, OPEN.SERVSUSC ss    
where c.cargcaca = csc.cacacodi    
  and c.CARGCONC = CO.CONCCODI    
  and c.cargnuse = ss.sesunuse    
  AND factcodi   = CUCOfact    
  AND CARGCUCO   = CUCOCODI    
  and clcocodi(+) = concclco    
  and cargpefa   = pefacodi    
  AND FACTFEGE BETWEEN to_date('01/12/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')     
                   and to_date('31/12/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')    
  and cargprog = proccons    
  and cargtipr = 'A'    
  and cargsign not in (/*'NS',*/ 'TS', 'ST', 'DV')
group by sesuserv, CARGCACA, csc.cacadesc
