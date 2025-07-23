---cliento sin producto
select *
  from open.GE_SUBSCRIBER gs
 where (select count(1)
          from open.suscripc s
         where gs.subscriber_id = s.suscclie) = 0
   and gs.vinculate_date > sysdate - 350;
