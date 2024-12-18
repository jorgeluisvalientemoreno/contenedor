CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PROLENALOGERROR(nuvalor NUMBER,nutipo NUMBER,sbmensaje VARCHAR2,sbprogr VARCHAR2) IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
 INSERT INTO log_error_err VALUES(
                                   nuvalor
                                  ,nutipo
                                  ,sbmensaje
                                  ,sbprogr
                                  ,SYSDATE
                                  );
 COMMIT;
END;
/
PROMPT Otorgando permisos de ejecucion a LDC_PROLENALOGERROR
BEGIN
  pkg_utilidades.prAplicarPermisos('LDC_PROLENALOGERROR','ADM_PERSON');
END;
/
GRANT EXECUTE on ADM_PERSON.LDC_PROLENALOGERROR to REXEREPORTES;
/