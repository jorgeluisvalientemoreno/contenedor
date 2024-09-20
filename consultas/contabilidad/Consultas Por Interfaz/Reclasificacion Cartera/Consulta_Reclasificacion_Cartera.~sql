select ic.clcocodi, ic.clcodesc, SUM(CACCSAPE)  CACCSAPE
  from open.ic_cartcoco, OPEN.CONCEPTO, OPEN.IC_CLASCONT ic
    where caccfege = '31/01/2024'
      and caccplca = 'L'
      AND CACCCONC = CONCCODI
      AND CONCCLCO = CLCOCODI
      and caccserv not in (7056)
GROUP BY  CLCOCODI, CLCODESC
