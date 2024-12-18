CREATE OR REPLACE PROCEDURE      FIX_ESPACIOS
AS

CURSOR cudireccion
is
SELECT
address_id
FROM ab_address
WHERE address like ' %';

BEGIN
        for r in   cudireccion
        loop
            UPDATE ab_address SET address=ltrim(address), address_parsed=ltrim(address_parsed)  WHERE address_id=r.address_id;
            COMMIT;
        END loop;
END;
/
