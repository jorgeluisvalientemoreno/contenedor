CREATE OR REPLACE TRIGGER ADM_PERSON.LDCTRG_LDC_CONST_UNOPRL
  BEFORE INSERT OR UPDATE ON ldc_const_unoprl
  REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
  /**************************************************************
  Propiedad intelectual JM GESTIONINFORMATICA S.A.S.

  Trigger  :  ldctrg_ldc_const_unioprnl

  Descripci?n  : Actualizamos datos de auditoria para el registro de unidades operativas.

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 06-07-2016

  Historia de Modificaciones
  ***********************************************************************/
DECLARE
 nusession      gv$session.audsid%TYPE;
 sbmensaje      VARCHAR2(200);
 eerror         EXCEPTION;
BEGIN
  SELECT userenv('SESSIONID'),USER,SYSDATE INTO nusession,:new.usuario,:new.fecha FROM dual;
  SELECT se.machine INTO :new.maquina FROM v$session se WHERE se.audsid = nusession AND rownum = 1;
EXCEPTION
 WHEN eerror THEN
  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
 WHEN OTHERS THEN
  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,SQLERRM);
END;
/
