select clcocodi, clcodesc, difeconc, difecoin, concdesc, sum(inte.valointe)  
from open.diferido, open.concepto, open.ic_clascont,  
     ( 
      select cargnuse NUSE, substr(cargdoso, 4) dife, sum(decode(cargsign,'DB',CARGVALO,'CR',-CARGVALO,0)) VALOINTE
        from open.cargos, open.cuencobr, open.factura, open.concepto 
       where cargconc = conccodi 
         AND factcodi = CUCOfact 
         AND CARGCUCO = CUCOCODI 
         and cargtipr = 'A' 
         AND FACTFEGE BETWEEN to_date('09/02/2015 00:00:00','dd/mm/yyyy hh24:mi:ss') 
                          and to_date('28/02/2015 23:59:59','dd/mm/yyyy hh24:mi:ss') 
         AND CONCCLCO IN (102, 103, 56, 57, 58, 59, 86, 87, 88, 120, 121) 
         AND substr(cargdoso, 0, 2) = 'ID'                                                              
       GROUP BY cargnuse, substr(cargdoso, 4)
      ) inte 
where difeconc  = conccodi 
  and clcocodi  = concclco 
  and inte.nuse = difenuse 
  and inte.dife = difecodi 
group by clcocodi, clcodesc, difeconc, concdesc, difecoin
