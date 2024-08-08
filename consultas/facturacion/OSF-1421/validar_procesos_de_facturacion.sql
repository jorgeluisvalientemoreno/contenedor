select pf.pefacicl,
       p.prejcope,
       p.prejprog,
       p.prejfech,
       p.prejespr,
       p.prejidpr,
       pf.pefafimo,
       pf.pefaffmo,
       pf.pefafeco,
       pf.pefafege,
       pf.pefafcco
  from procejec p
  left join open.perifact pf  on pf.pefacodi = p.prejcope
 where pf.pefacicl = 1601
 and p.prejcope in (104896, 105300, 106240, 102444)
 order by p.prejcope desc, p.prejfech desc




 --
