CREATE OR REPLACE PROCEDURE FIX_CLIESUSC
AS

CURSOR cuactuprod
is
SELECT b.susciddi, c.address, a.subscriber_id, a.address_id
FROM
GE_SUBSCRIBER a, suscripc b, ab_address c
WHERE a.address_id=1
AND b.susciddi<>1
AND a.subscriber_id=b.suscclie
AND b.susciddi=c.address_id;


BEGIN


        for r in cuactuprod
        loop
            UPDATE ge_subscriber SET address_id=r.susciddi, address=r.address WHERE subscriber_id=r.subscriber_id;
            commit;
        END loop;


END;
/
