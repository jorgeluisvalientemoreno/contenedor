-- CONSULTA OPEN
SELECT dc.dcrccuco, dc.dcrcsign, 
       substr(dcrcinad,
              instr(dcrcinad, '|2307||E||', 1, 1)+ length('|2307||E||'),
              length(dcrcinad)) ITEM,
       sum(decode(dcrcsign,'C',dcrcvalo, -dcrcvalo)) valor
  FROM open.ic_decoreco dc
 WHERE dcrcecrc = 38470
   AND dcrcinad like '%|2307||E||%' --
GROUP BY  dc.dcrccuco, dc.dcrcsign, 
          substr(dcrcinad,
          instr(dcrcinad, '|2307||E||', 1, 1)+ length('|2307||E||'),
          length(dcrcinad))
