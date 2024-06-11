select pefacicl,
       cargpefa,
       pefames,
       pefaano,
       cargnuse,
       cargvalo,
       cargconc || ' ' || concdesc concepto,
       cargdoso,
       cargsign || ' ' || signdesc signo,
       cargprog || ' ' || procdesc proceso
from open.cargos 
left join open.perifact  on cargpefa = pefacodi
left join open.procesos  on cargprog = proccons
left join open.signo     on cargsign = signcodi
left join open.concepto  on conccodi = cargconc
 where cargpefa in (select pefacodi
                    from perifact
                    where pefaano in (2023)
                    and pefames = 1
                    and pefacodi = 103199
                    )
   and cargconc = 31
   and cargprog = 5
   and cargdoso like 'CO%PR%'
   and cargsign in ('DB', 'CR')
   and cargvalo > 1000000
