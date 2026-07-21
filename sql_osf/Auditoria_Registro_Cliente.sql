with datos as(
SELECT gs.*
  FROM OPEN.ge_subscriber gs
 where gs.address_id is null
 and gs.subscriber_id = 3484749
   /*and not exists (select a.susccodi
          from OPEN.SUSCRIPC a
         where a.suscclie = gs.subscriber_id)*/)
select *-- count(1) 
from  datos,   open.AU_AUDIT_POLICY_LOG
where subscriber_id = external_id(+) and AUDIT_POLICY_ID= 116 and current_even_desc ='INSERT' 
;
