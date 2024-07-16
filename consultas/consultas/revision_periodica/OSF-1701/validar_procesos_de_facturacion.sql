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
 where p.prejfech >= '01/01/2024'
  and pf.pefacicl  in (201)
  and p.prejcope = 111230
   and exists (select null
          from procejec p2
         where p2.prejcope = p.prejcope
           and p2.prejprog in ('FGCC')
           and p2.prejespr = 'T')
           and p.prejfech >= '24/04/2024'
 order by p.prejcope desc, p.prejfech desc

