SELECT a.address_id, d.geograp_location_id
FROM servsusc s, pr_product a, ps_product_status c, ab_address d
WHERE s.sesususc = 53657991
AND s.sesuserv = 7014
AND a.product_id = s.sesunuse
AND c.product_status_id = a.product_status_id AND d.address_id = a.address_id and rownum = 1

select * from ab_address where address_id = 6545124;

select * from ab_segments where segments_id = 56341 ; 

select *
from or_operating_sector
where operating_sector_id= 9281

update ab_segments 
set operating_sector_id = 9281
where segments_id = 45847
;

DECLARE
   CURSOR getsegment IS
      SELECT d.segment_id
      FROM servsusc s
         JOIN pr_product a ON a.product_id = s.sesunuse
         JOIN ps_product_status c ON c.product_status_id = a.product_status_id
         JOIN ab_address d ON d.address_id = a.address_id
      WHERE s.sesususc IN (
      4508725
      )
      AND s.sesuserv = 7014;
BEGIN
   FOR rec IN getsegment LOOP
      UPDATE ab_segments
         SET operating_sector_id = 9281
       WHERE segments_id   = rec.segment_id;

      DBMS_OUTPUT.PUT_LINE(
         'Segment updated: ' || rec.segment_id
      );
   END LOOP;

   COMMIT;
END;
/
