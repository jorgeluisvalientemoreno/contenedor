CREATE OR REPLACE procedure adm_person.LDCINSLDCLOGERRORRSUI(TEXTO IN VARCHAR2) IS
/**************************************************************************
        Autor       : Víctor  / Horbath
        Fecha       : 2019-02-26
        Ticket      : 200-2392
        Descripcion : Graba de manera autonoma en la tabla ldclogerrorrsui


        HISTORIAL DE MODIFICACIONES
        FECHA        	AUTOR       	MODIFICACION
        =========       =========       ====================
        08/05/2024      Adrianavg       OSF-2668: Se migra del esquema OPEN al esquema ADM_PERSON
***************************************************************************/
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
     INSERT INTO ldclogerrorrsui VALUES(LDC_SEQLOGERRORSUI.nextval,TEXTO);
     COMMIT;
     null;
END;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDCINSLDCLOGERRORRSUI
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCINSLDCLOGERRORRSUI', 'ADM_PERSON'); 
END;
/
