select mosfsesu, s.subscriber_name||s.subs_last_name, Total
  from (
        select mosfsesu, sum(mosfvalo) Total
          from open.movisafa m
         where m.mosffecr <= '01-06-2015'
        group by mosfsesu
        ), open.servsusc c, open.ge_subscriber s, open.suscripc p
 where Total > 0        
   and mosfsesu = c.sesunuse
   and c.sesususc = p.susccodi
   and p.suscclie = s.subscriber_id 
