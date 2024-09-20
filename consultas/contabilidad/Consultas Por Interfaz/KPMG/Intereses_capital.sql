select perinte, ic.clcocodi capital, ic.clcodesc descripcion, sum(t_capital), ii.clcocodi, ii.clcodesc, sum(T_interes)
  from open.concepto cc, open.ic_clascont ic, open.ic_clascont ii,  open.concepto ci,
       ( select perinte, ca.cargnuse, cargdoso, diferido, cargconc, concinte, sum(cargvalo) T_Capital, T_interes
          from open.cargos ca, OPEN.CUENCOBR, OPEN.FACTURA,
               (select to_char(c.cargfecr, 'YYYYMM') perinte, c.cargcuco, c.cargnuse, c.cargconc concinte, c.cargsign, 
                       substr(c.cargdoso,4,8) Diferido, sum(cargvalo) t_interes
                 from  open.cargos c, OPEN.CUENCOBR cu, OPEN.FACTURA fa
                 where c.CARGCUCO = cu.CUCOCODI
                 AND fa.factcodi = cu.CUCOfact
                 and fa.FACTFEGE BETWEEN to_date('09/02/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')     
                                     and to_date('30/06/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')    
                 and c.cargtipr = 'A'    
                 and c.cargsign NOT IN ('PA','AP','SA') 
                 and c.cargcaca in ('51')
                 and substr(c.cargdoso, 1, 2) = 'ID'
                group by to_char(c.cargfecr, 'YYYYMM'), c.cargcuco, c.cargnuse, c.cargconc, c.cargsign, substr(c.cargdoso,4,8)) u
         where ca.cargcuco = u.cargcuco
           and ca.cargnuse = u.cargnuse
           and ca.CARGCUCO = CUCOCODI
           AND factcodi = CUCOfact
           and FACTFEGE BETWEEN to_date('09/02/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')     
                            and to_date('30/06/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')    
           and ca.cargtipr = 'A'    
           and ca.cargsign NOT IN ('PA','AP','SA') 
           and ca.cargcaca in ('51')
           and substr(ca.cargdoso, 1, 2) = 'DF'
           and substr(ca.cargdoso, 4, 8) = diferido
           and to_char(ca.cargfecr, 'YYYYMM') = perinte
        group by perinte, ca.cargnuse, cargdoso, diferido, cargconc, concinte, T_interes)
 where cargconc = cc.conccodi
   and cc.concclco = ic.clcocodi
   and concinte = ci.conccodi
   and ci.concclco = ii.clcocodi
group by perinte, ic.clcocodi, ic.clcodesc, ii.clcocodi, ii.clcodesc
