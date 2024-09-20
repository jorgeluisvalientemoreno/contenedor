select ss.sesuserv, servdesc, cargnuse, cargdoso, pefacicl, cargtipr, clcocodi, clcodesc,
       cargprog, upper(procdesc),
       CARGCACA CausadeCargo,
       csc.cacadesc NombreCausadeCargo,
       CARGCONC    Concepto,
       co.concdesc Nombreconcepto,
       cargsign,SESUCATE Categoria,
       sum(cargvalo), c.cargfecr fecha_creacion, cargusua,
       (SELECT name_ FROM open.ge_person WHERE user_id = cargusua) usuario,
       (SELECT (SELECT name_ FROM open.ge_organizat_area 
                 WHERE organizat_area_id = p.organizat_area_id) 
          FROM open.ge_person p WHERE user_id = cargusua) area
from open.cargos c,open.SERVSUSC ss,
     open.CONCEPTO CO,
     open.CAUSCARG csc, open.procesos, open.ic_clascont, open.perifact, OPEN.SERVICIO
where c.cargcaca = csc.cacacodi
  and c.cargnuse = ss.sesunuse
  and c.CARGCONC = CO.CONCCODI
  and c.cargfecr between to_date('01/04/2015 00:00:00','dd/mm/yyyy hh24:mi:ss') 
                     and to_date('30/04/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')
  and cargprog = proccons
  and clcocodi(+) = concclco
  and cargpefa = pefacodi
  and ss.sesuserv = servcodi
  AND CARGCUCO > 0
  and cargtipr = 'P'
  and cargsign NOT IN ('PA','AP')
  AND substr(cargdoso,1,2) NOT IN ('PA','AP')
  and concclco = 2
  and cargcaca = 19
group by  ss.sesuserv, servdesc, cargnuse, cargdoso, pefacicl, cargtipr, clcocodi, clcodesc, cargprog, upper(procdesc), CARGCACA,csc.cacadesc,
          CARGCONC,co.concdesc, cargsign,SESUCATE, c.cargfecr, cargusua
