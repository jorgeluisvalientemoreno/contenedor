select clavref3, sum(decode(clavcont, '40', 1, '01', 1, -1) * impomtrx) Total
  from open.ldci_incoliqu
 where iclinudo = 3251
   and (ctadiv LIKE '%147065%' OR clasecta LIKE '%1110%')
group by clavref3
