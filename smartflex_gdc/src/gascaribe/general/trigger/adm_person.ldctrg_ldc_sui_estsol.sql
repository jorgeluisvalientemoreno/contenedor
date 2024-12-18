CREATE OR REPLACE TRIGGER ADM_PERSON.ldctrg_ldc_sui_estsol
  BEFORE INSERT OR UPDATE ON ldc_sui_estsol
  REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
  /**************************************************************
  Propiedad intelectual JM GESTIONINFORMATICA S.A.S.

  Trigger  :  ldctrg_ldc_sui_estsol

  Descripci¿n  : Obtiene el nombre del tipo del estado de solicitud de la tabla padre

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 10-05-2016

  Historia de Modificaciones
  18/10/2024    jpinedc     OSF-3383    Se migra a ADM_PERSON
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
