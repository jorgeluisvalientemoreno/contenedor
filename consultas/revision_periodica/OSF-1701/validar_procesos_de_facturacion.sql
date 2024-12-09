--validar_procesos_de_facturacion
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
 where p.prejfech >= '01/06/2023'
  and pf.pefacicl  in (5105)
  and p.prejcope = 113347
   and exists (select null
          from procejec p2
         where p2.prejcope = p.prejcope
           and p2.prejprog in ('FGCC')
           and p2.prejespr = 'T')
           and p.prejfech >= '01/06/2023'
 order by p.prejcope desc, p.prejfech desc

