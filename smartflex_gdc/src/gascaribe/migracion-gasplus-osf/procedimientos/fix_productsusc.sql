CREATE OR REPLACE PROCEDURE FIX_PRODUCTSUSC
AS

CURSOR cuactuprod
is
SELECT product_id, address_id,susciddi FROM
pr_product, suscripc
WHERE address_id=1
AND susciddi<>1
AND subscription_id=susccodi;


BEGIN


        for r in cuactuprod
        loop
            UPDATE pr_product SET address_id=r.susciddi WHERE product_id=r.product_id;
            commit;
        END loop;


END;
/
