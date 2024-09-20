select cargnuse, sesususc, (s.subscriber_name || s.subs_last_name) nombre, cargsign, /*sum*/(cargvalo) cargvalo, cargdoso,
       cargcodo, (select n.notaobse from open.notas n where n.notanume = cargcodo) Observacion
  from open.cargos, open.ge_subscriber s, open.servsusc c, open.suscripc p, open.concepto
 where cargnuse   =  sesunuse
   and cargfecr   >= '01-12-2016'  and cargfecr < '01-01-2017'
   and cargcaca   =  3
   and cargconc   =  conccodi
   and concclco   =  2
   and c.sesususc =  p.susccodi
   and p.suscclie =  s.subscriber_id
   and sesuserv   != 7056
