select SS.SESUSERV, SE.SERVDESC, decode(cargtipr,'A','FACTURACION','P','NOTAS') TIPO, pefacicl, cargtipr, clcocodi, clcodesc, 
       cargprog, upper(procdesc), 
       CARGCACA CausadeCargo, 
       csc.cacadesc NombreCausadeCargo, 
       CARGCONC    Concepto, 
       co.concdesc Nombreconcepto, 
       cargsign,CUCOCATE Categoria, 
       substr(cargdoso, 0, 2) doso, 
       sum(cargvalo) 
from open.cargos c, 
     OPEN.CUENCOBR, 
     OPEN.FACTURA, 
     open.CONCEPTO CO, 
     open.CAUSCARG csc, 
     open.procesos, 
     open.ic_clascont,  
     open.perifact,  
     OPEN.SERVSUSC SS, 
     OPEN.SERVICIO SE 
where c.cargcaca = csc.cacacodi 
  and c.CARGCONC = CO.CONCCODI 
  AND C.CARGNUSE = SS.SESUNUSE 
  AND SS.SESUSERV = SE.SERVCODI 
  AND factcodi = CUCOfact 
  AND CARGCUCO = CUCOCODI 
  and clcocodi(+) = concclco 
  and cargpefa = pefacodi 
  AND FACTFEGE BETWEEN to_date('01/04/2015 00:00:00','dd/mm/yyyy hh24:mi:ss') 
                   and to_date('30/04/2015 23:59:59','dd/mm/yyyy hh24:mi:ss') 
  and cargprog = proccons 
  and cargtipr = 'A' 
  and cargsign NOT IN ('PA','AP') 
group by  SS.SESUSERV, SE.SERVDESC, pefacicl, cargtipr, clcocodi, clcodesc, cargprog, upper(procdesc), CARGCACA,csc.cacadesc,CARGCONC,co.concdesc, CARGSIGN,CUCOCATE, substr(cargdoso, 0, 2)
