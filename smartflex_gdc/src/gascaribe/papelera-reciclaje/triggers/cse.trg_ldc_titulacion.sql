CREATE OR REPLACE TRIGGER TRG_LDC_TITULACION
BEFORE INSERT OR DELETE OR UPDATE ON OPEN.LDC_TITULACION
DECLARE
    sbSchema varchar(200);
    sbOsUser varchar(200);
    sbTermin varchar(200);
    sbProgra varchar(200);
BEGIN
    SELECT UPPER(NVL(USERNAME,'NA')) SCHEMANAME, UPPER(NVL(OSUSER,'NA')) OSUSER,UPPER(NVL(TERMINAL,'NA')) TERMINAL, UPPER(NVL(PROGRAM,'NA')) PROGRAM INTO sbSchema,sbOsUser,sbTermin,sbProgra FROM V$SESSION VS WHERE VS.SID = SYS_CONTEXT('USERENV','SID');
    IF CSE_SECURITY.checkRestrict THEN 
          IF sbProgra = 'SACME.EXE' THEN
    	     --ERRORS.setmessage('El usuario no esta autorizado para modificar la tabla LDC_TITULACION en esta base de datos.');
           ERRORS.setmessage('Desde el terminal '||sbTermin||' conectado con el usuario '||sbSchema||' en el programa '||sbProgra||', no esta autorizado para modificar la tabla LDC_TITULACION en esta base de datos.');
    	     raise EX.controlled_error;
          ELSE
          raise_application_error(-20001,'Desde el terminal '||sbTermin||' conectado con el usuario '||sbSchema||' en el programa '||sbProgra||', no esta autorizado para modificar la tabla LDC_TITULACION en esta base de datos.');
          END IF;
    END IF; 
EXCEPTION 
    WHEN EX.CONTROLLED_ERROR THEN
    RAISE EX.CONTROLLED_ERROR; 
END TRG_LDC_TITULACION;
/
