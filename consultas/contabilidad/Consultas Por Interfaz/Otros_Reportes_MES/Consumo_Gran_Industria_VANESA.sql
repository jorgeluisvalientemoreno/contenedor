SELECT sesuserv, servdesc, sesucate, catedesc, sesunuse, sesususc, sesuesco, escodesc, identification, subscriber_name, subs_last_name, address,
       PROCESO, nuse, pefacicl, clcocodi, clcodesc, Concepto, Nombreconcepto, CausadeCargo, NombreCausadeCargo, cargsign,
       decode(cargsign, 'DB', VALOR, 'CR', (VALOR * -1), 'AS', (VALOR * -1)) VALOR
       FROM
(select decode(cargtipr,'A','FACTURACION','P','NOTAS') PROCESO, cargnuse nuse, pefacicl, clcocodi, clcodesc,
       cargprog, upper(procdesc),
       CARGCACA CausadeCargo,
       csc.cacadesc NombreCausadeCargo,
       CARGCONC    Concepto,
       co.concdesc Nombreconcepto,
       cargsign,CUCOCATE Categoria,
       sum(cargvalo) VALOR
from open.cargos c,
     OPEN.CUENCOBR,
     OPEN.FACTURA,
     open.CONCEPTO CO,
     open.CAUSCARG csc,
     open.procesos,
     open.ic_clascont, open.perifact, OPEN.SERVSUSC
where c.cargcaca = csc.cacacodi
  and c.CARGCONC = CO.CONCCODI
  AND factcodi = CUCOfact
  AND CARGCUCO = CUCOCODI
  and clcocodi(+) = concclco
  and cargpefa = pefacodi
  AND FACTFEGE BETWEEN to_date('01/04/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')
                   and to_date('30/04/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')
  and cargprog = proccons
  and cargtipr = 'A'
  and cargsign NOT IN ('PA','AP')
  AND C.CARGNUSE = SESUNUSE
  AND SESUCATE NOT IN (1, 2, 3, 12)
group by  cargtipr, cargnuse, pefacicl, clcocodi, clcodesc, cargprog, upper(procdesc), CARGCACA,csc.cacadesc,CARGCONC,co.concdesc, CARGSIGN,CUCOCATE
UNION
select  decode(cargtipr,'A','FACTURACION','P','NOTAS'), cargnuse, pefacicl, clcocodi, clcodesc,
       cargprog, upper(procdesc),
       CARGCACA CausadeCargo,
       csc.cacadesc NombreCausadeCargo,
       CARGCONC    Concepto,
       co.concdesc Nombreconcepto,
       cargsign,SESUCATE Categoria,
       sum(cargvalo)
from open.cargos c,open.SERVSUSC ss,
     open.CONCEPTO CO,
     open.CAUSCARG csc, open.procesos, open.ic_clascont, open.perifact
where c.cargcaca = csc.cacacodi
  and c.cargnuse = ss.sesunuse
  and c.CARGCONC = CO.CONCCODI
  and c.cargfecr between to_date('01/04/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')
                     and to_date('30/04/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')
  and cargprog = proccons
  and clcocodi(+) = concclco
  and cargpefa = pefacodi
  AND CARGCUCO > 0
  and cargtipr = 'P'
  and cargsign NOT IN ('PA','AP')
  AND substr(cargdoso,1,2) NOT IN ('PA','AP')
  AND CARGNUSE = SESUNUSE
  AND SESUCATE NOT IN (1, 2, 3, 12)
group by  cargtipr, cargnuse, pefacicl, clcocodi, clcodesc, cargprog, upper(procdesc), CARGCACA,csc.cacadesc,
          CARGCONC,co.concdesc, cargsign,SESUCATE) COBRO, open.servsusc, open.ge_subscriber, open.suscripc, open.categori, open.servicio, open.estacort
where cobro.nuse = sesunuse
  and sesususc = susccodi
  and sesucate = catecodi
  and sesuserv = servcodi
  and sesuesco = escocodi
  and suscclie = subscriber_id
