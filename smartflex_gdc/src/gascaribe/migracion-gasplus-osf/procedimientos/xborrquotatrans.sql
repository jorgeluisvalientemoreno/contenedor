CREATE OR REPLACE procedure xborrquotatrans is
cursor ct is SELECT *
FROM ld_quota_transfer
WHERE request_user = 4104 AND review_user = 4104 AND
approved_user = 4104 and REQUEST_DATE<=to_date('01-02-2014 23:59:59','dd-mm-yyyy hh24:mi:ss');
begin
     for c in ct loop
         delete from ld_quota_transfer where QUOTA_TRANSFER_ID=c.QUOTA_TRANSFER_ID;
         commit;
     end loop;
end;
/
