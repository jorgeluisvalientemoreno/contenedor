select (Case When Ctadiv Is Null Then Clasecta Else Ctadiv End) Clasecta,
       clavref3, sum(decode(clavcont, '40', 1, '01', 1, -1) * impomtrx) Total
  from open.ldci_detaintesap l
 where l.cod_interfazldc = 6421
   and (ctadiv LIKE '%147065%' OR clasecta LIKE '%1110%' OR clasecta LIKE '%110501%')
group by (Case When Ctadiv Is Null Then Clasecta Else Ctadiv End), clavref3
order by 2, 1;

