SELECT D.DCRCCUCO, D.DCRCSIGN, 
      substr(dcrcinad,
      instr(dcrcinad, '|2307||E||', 1, 1)+ length('|2307||E||'),
      length(dcrcinad))
       ,sum(decode(dcrcsign,'C',dcrcvalo, -dcrcvalo)) valor
  FROM open.ic_decoreco D
 WHERE dcrcecrc = 38370 --38190
   AND DCRCCLCR in (SELECT --+ index (IC_CLASCORE, IX_IC_CLASCORE01)
                           clcrcons FROM open.IC_CLASCORE WHERE clcrcorc in (5203))
   AND dcrcinad like '%|2307|%'  --'%|2307||E||%' --
 --AND dcrccuco <> '-1'
GROUP BY D.DCRCCUCO, D.DCRCSIGN, 
         substr(dcrcinad,
                 instr(dcrcinad, '|2307||E||', 1, 1)+ length('|2307||E||'),
                 length(dcrcinad));
