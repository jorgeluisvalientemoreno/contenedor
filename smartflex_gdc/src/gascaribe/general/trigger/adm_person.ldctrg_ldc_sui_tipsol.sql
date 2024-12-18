CREATE OR REPLACE TRIGGER ADM_PERSON.ldctrg_ldc_sui_tipsol
  BEFORE INSERT OR UPDATE ON ldc_sui_tipsol
  REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
  /**************************************************************
  Propiedad intelectual JM GESTIONINFORMATICA S.A.S.

  Trigger  :  ldctrg_ldc_sui_tipsol

  Descripción  : Obtiene el nombre del tipo de solicitud de la tabla padre

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 03-05-2016

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
