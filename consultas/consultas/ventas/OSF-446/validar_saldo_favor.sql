select cg.cargnuse, cg.cargsign, cg.cargvalo, cg.cargfecr, s1.sesusafa
 from open.cargos cg
 inner join open.servsusc s1 on s1.sesunuse = cg.cargnuse
 where cg.cargnuse in (51692374)
 and cg.cargsign = 'SA'
 order by cg.cargnuse desc, cg.cargfecr desc
