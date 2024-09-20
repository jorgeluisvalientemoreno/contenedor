select pefacicl, cargtipr, clcocodi, clcodesc,       
       cargprog, procdesc,       
       CausadeCargo,       
       NombreCausadeCargo,       
       Concepto,       
       Nombreconcepto,       
       cargsign, Categoria, 
       servicio,      
       fecha, localidad, sum(valor) valor,    
       SUM(M3)   
        from (       
select pefacicl, cargtipr, clcocodi, clcodesc,       
       cargprog, upper(procdesc) procdesc,       
       CARGCACA CausadeCargo,       
       csc.cacadesc NombreCausadeCargo,       
       CARGCONC    Concepto,       
       co.concdesc Nombreconcepto,       
       cargsign,SESUCATE Categoria,       
       sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, 'TS', cargvalo, 'DV', cargvalo, cargvalo*-1)) valor,   
       sum(cargunid) M3,   
       (select servdesc from open.servicio where servcodi=sesuserv) servicio,
       trunc(c.cargfecr) fecha,       
       (select description from open.GE_GEOGRA_LOCATION where geograp_location_id = (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = (select address_id from OPEN.GE_SUBSCRIBER where subscriber_id = (select suscclie from OPEN.SUSCRIPC where susccodi = ss.sesususc)))) localidad       
from open.cargos c,open.SERVSUSC ss,       
     open.CONCEPTO CO,       
     open.CAUSCARG csc, open.procesos, open.ic_clascont, open.perifact       
where c.cargcaca = csc.cacacodi       
  and c.cargnuse = ss.sesunuse       
  and c.CARGCONC = CO.CONCCODI   
  and c.cargfecr between to_date('10/01/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')        
                     and to_date('17/01/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')       
  and cargprog = proccons       
  and clcocodi(+) = concclco       
  and cargpefa = pefacodi       
  and pefaano=2015
  and pefames=1
  AND CARGCUCO > 0       
  and cargtipr = 'P'       
  and cargsign NOT IN ('PA','AP')       
  AND substr(cargdoso,1,2) NOT IN ('PA','AP')    
  

group by  pefacicl, cargtipr, clcocodi, clcodesc, cargprog, upper(procdesc), CARGCACA,csc.cacadesc,       
          CARGCONC,co.concdesc, cargsign,SESUCATE,trunc(c.cargfecr), ss.sesususc , sesuserv     
union all       
select pefacicl, cargtipr, clcocodi, clcodesc,       
       cargprog, upper(procdesc),       
       CARGCACA CausadeCargo,       
       csc.cacadesc NombreCausadeCargo,       
       CARGCONC    Concepto,       
       co.concdesc Nombreconcepto,       
       cargsign,CUCOCATE Categoria,       
       sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, cargvalo*-1)) valor ,    
       sum(cargunid) M3,   
        (select servdesc from open.servicio where servcodi=sesuserv) servicio,
       trunc(FACTFEGE) fecha,       
       (select description from open.GE_GEOGRA_LOCATION where geograp_location_id = (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = (select address_id from OPEN.GE_SUBSCRIBER where subscriber_id = (select suscclie from OPEN.SUSCRIPC where susccodi = ss.sesususc)))) localidad       
from open.cargos c,       
     OPEN.CUENCOBR,       
     OPEN.FACTURA,       
     open.CONCEPTO CO,       
     open.CAUSCARG csc,       
     open.procesos,       
     open.ic_clascont, open.perifact, OPEN.SERVSUSC ss       
where c.cargcaca = csc.cacacodi       
  and c.CARGCONC = CO.CONCCODI       
  and c.cargnuse = ss.sesunuse   
  AND factcodi = CUCOfact       
  AND CARGCUCO = CUCOCODI       
  and clcocodi(+) = concclco       
  and cargpefa = pefacodi     
  and pefaano=2015
  and pefames=1
  AND FACTFEGE BETWEEN to_date('10/02/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')        
                   and to_date('17/02/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')       
  and cargprog = proccons       
  and cargtipr = 'A'       
  and cargsign NOT IN ('PA','AP')      
group by  ss.sesususc,pefacicl, cargtipr, clcocodi, clcodesc, cargprog, upper(procdesc), CARGCACA,csc.cacadesc,CARGCONC,co.concdesc, CARGSIGN,CUCOCATE, trunc(FACTFEGE), sesuserv)       
group by pefacicl, cargtipr, clcocodi, clcodesc,       
       cargprog, procdesc,       
       CausadeCargo,       
       NombreCausadeCargo,       
       Concepto,       
       Nombreconcepto,       
       cargsign,Categoria,       
       fecha,       
       localidad,
       servicio
