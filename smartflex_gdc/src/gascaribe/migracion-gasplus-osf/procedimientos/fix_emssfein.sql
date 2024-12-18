CREATE OR REPLACE procedure fix_EMSSFEIN
AS

CURSOR cuelmesesu
is
SELECT rowid
FROM elmesesu
WHERE emssfere IS null OR emssfein > sysdate;

BEGIN

    for r in cuelmesesu
    loop
        UPDATE elmesesu SET emssfein=sysdate WHERE elmesesu.rowid=r.rowid;
        commit;
    END loop;

END;
/
