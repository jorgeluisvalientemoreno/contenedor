select gs.*, rowid
  from OPEN.GE_SUBSCRIBER gs
 where (select count(1)
          from OPEN.SUSCRIPC a
         where a.suscclie = gs.SUBSCRIBER_ID) = 0
 order by gs.subscriber_id desc
