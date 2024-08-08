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
 where p.prejfech >= '01/01/2023'
   and pf.pefacicl = 8489
   and p.prejcope = 104327
   and not exists (select null
          from procejec p2
         where p2.prejcope = p.prejcope
           and p2.prejprog in ('FGCC')
           and p2.prejespr = 'T')
 order by p.prejcope desc, p.prejfech desc

