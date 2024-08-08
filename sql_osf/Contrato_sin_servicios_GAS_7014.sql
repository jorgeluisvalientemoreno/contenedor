select *
  from open.suscripc s
 where (select count(1)
          from open.servsusc a
         where a.sesususc = s.susccodi
           and a.sesuserv = 7014) = 0
 order by s.susccodi desc
