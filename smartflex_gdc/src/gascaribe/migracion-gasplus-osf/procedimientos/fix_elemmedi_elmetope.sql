CREATE OR REPLACE procedure FIX_ELEMMEDI_ELMETOPE
as

cursor cuelemmedi
is
SELECT ROWID,G.*
FROM elemmedi G
WHERE  (elmetope = 0 OR elmenudc = 0)
AND not exists (select 'y' FROM elmesesu WHERE elmeidem = emsselme) ;

begin

   for r in cuelemmedi
   loop
        update elemmedi set elmetope=99999, elmenudc=5 where elemmedi.rowid=r.rowid;
        commit;
   end loop;

end;
/
