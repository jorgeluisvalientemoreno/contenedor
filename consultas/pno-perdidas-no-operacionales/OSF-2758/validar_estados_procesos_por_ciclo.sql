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
 where p.prejfech >= '01/01/2024'
   and pf.pefacicl = 5502
   --and p.prejcope = 115043
  order by p.prejcope desc, p.prejfech desc
