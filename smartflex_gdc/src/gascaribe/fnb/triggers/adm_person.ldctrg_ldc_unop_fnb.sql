CREATE OR REPLACE TRIGGER ADM_PERSON.LDCTRG_LDC_UNOP_FNB
  BEFORE INSERT OR UPDATE ON ldc_unop_fnb
  REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
  /**************************************************************
  Propiedad intelectual JM GESTIONINFORMATICA S.A.S.

  Trigger  :  ldctrg_ldc_unop_fnb

  Descripci¿n  : Obtiene datos

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 21-07-2016

  Historia de Modificaciones
  **************************************************************/
DECLARE
 nusession gv$session.audsid%TYPE;
BEGIN
  SELECT userenv('SESSIONID'),USER,SYSDATE INTO nusession,:new.usuario,:new.fecha FROM DUAL;
  SELECT se.machine INTO :new.maquina FROM gv$session se WHERE se.audsid = nusession;
EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/
