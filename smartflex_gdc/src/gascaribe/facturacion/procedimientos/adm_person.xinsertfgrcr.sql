create or replace procedure ADM_PERSON.XINSERTFGRCR(TEXTO IN VARCHAR2) IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
     INSERT INTO xtracefgrcr VALUES(seqtracefgrcr.nextval,TEXTO,SYSDATE);
     COMMIT;
    null;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('XINSERTFGRCR', 'ADM_PERSON');
END;
/
