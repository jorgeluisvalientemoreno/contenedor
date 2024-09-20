select cargnuse, sesususc, (s.subscriber_name || s.subs_last_name) nombre, cargsign, sum(cargvalo)
  from open.cargos, open.ge_subscriber s, open.servsusc c, open.suscripc p
 where cargnuse = sesunuse
   and cargfecr >= '01-12-2015'  and cargfecr < '01-01-2016'
   and cargcaca = 75
   and c.sesususc = p.susccodi
   and p.suscclie = s.subscriber_id
group by cargnuse, sesususc, s.subscriber_name, s.subs_last_name, cargsign
   

