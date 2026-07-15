select SESUSUSC, PEFACODI, PEFACICL , PEFAANO , PEFAMES
from servsusc s1
left join perifact on pefacicl = s1.sesucicl
where pefaano=2023 and pefames in (7) 
and exists (select null from procejec p2 where pefacodi=p2.prejcope and p2.prejprog='FGCC' and p2.prejespr = 'T')
and  not  exists (select null
                 from cargos c1
                 left join servsusc s2 on c1.cargnuse =s2.sesunuse 
                 where c1.cargnuse= s1.sesunuse and pefacodi = c1.cargpefa and  s2.sesuserv=7014 and cargcaca in (15,51) 
                  )
and  exists (select null
                 from cargos c1
                 left join servsusc s2 on c1.cargnuse =s2.sesunuse 
                 where c1.cargnuse= s1.sesunuse and pefacodi = c1.cargpefa and  s2.sesuserv in(7055,7053) and cargcaca in (15,51) 
                  )
AND ROWNUM <= 5
GROUP BY SESUSUSC, PEFACODI, PEFACICL , PEFAANO , PEFAMES
