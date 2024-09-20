-- DETALLE CARTERA DIFERIDA
select *
  from ( select csc.cacadesc, c.* 
           from open.cargos c, open.SERVSUSC ss, open.CONCEPTO CO,    
                open.CAUSCARG csc, open.procesos, open.ic_clascont, open.perifact    
          where c.cargcaca = csc.cacacodi    
            and c.cargnuse = ss.sesunuse
            AND cargnuse in (50188258 )                     
            and sesuserv = 7056
            and c.CARGCONC = CO.CONCCODI    
            and c.cargfecr between to_date(to_char('01/08/2015 00:00:00'),'dd/mm/yyyy hh24:mi:ss')    
                               AND to_date(to_char('31/08/2015 23:59:59'),'dd/mm/yyyy hh24:mi:ss')    
            and cargprog = proccons    
            and clcocodi(+) = concclco    
            and cargpefa = pefacodi    
            AND CARGCUCO > 0    
            and cargtipr = 'P'
          UNION
          select csc.cacadesc, c.*
          from open.cargos c, OPEN.CUENCOBR, OPEN.FACTURA, open.CONCEPTO CO, open.CAUSCARG csc,    
               open.procesos, open.ic_clascont, open.perifact, OPEN.SERVSUSC ss    
          where c.cargcaca  =  csc.cacacodi    
            and c.CARGCONC  =  CO.CONCCODI    
            and c.cargnuse  =  ss.sesunuse    
            AND cargnuse    in (50188258 )                    
            and sesuserv    =  7056
            AND factcodi    =  CUCOfact    
            AND CARGCUCO    =  CUCOCODI    
            and clcocodi(+) = concclco    
            and cargpefa    = pefacodi    
            AND FACTFEGE BETWEEN to_date('01/08/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')     
                             and to_date('31/08/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')    
            and cargprog    = proccons    
            and cargtipr    = 'A');

SELECT md.*
  FROM open.movidife md, open.servsusc, open.diferido d
 WHERE modifeca >= to_date('01/08/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')
   AND modifeca <= to_date('31/08/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')
   AND modinuse =  sesunuse
   AND sesuserv =  7056
   AND md.modidife = d.difecodi
   AND modivacu > 0
   AND modinuse in (50188258 )






