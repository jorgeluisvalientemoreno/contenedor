CREATE OR REPLACE TRIGGER ADM_PERSON.LDCTRG_AUDI_LDC_ASIG_OT_TECN
  after insert or update or delete on ldc_asig_ot_tecn
  referencing old as old new as new for each row
  /**************************************************************
  Propiedad intelectual PETI.

  Trigger  :  LDCTRG_audi_ldc_asig_ot_tecn

  Descripci¿n  : Registra auditoria de cambio en ldc_asig_ot_tecn

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 16-04-2013

  Historia de Modificaciones
  **************************************************************/

DECLARE
  nuErrCode number;
  sbErrMsg  VARCHAR2(2000);
  sbIssue   VARCHAR2(4000);
  sbMessage VARCHAR2(4000);
  eerror    exception;
  eerror2   exception;
  eerror3   exception;
BEGIN
 IF inserting THEN
  INSERT INTO audi_ldc_asig_ot_tecn(unidad_operativa,tecnico_unidad,orden,unidad_operativa_new,tecnico_unidad_new,fecha,usuario,opera)
                             VALUES(NULL,NULL,:new.orden,:new.unidad_operativa,:new.tecnico_unidad,sysdate,user,'I');
 END IF;
 IF updating THEN
  INSERT INTO audi_ldc_asig_ot_tecn(unidad_operativa,tecnico_unidad,orden,unidad_operativa_new,tecnico_unidad_new,fecha,usuario,opera)
                             VALUES(:old.unidad_operativa,:old.tecnico_unidad,:old.orden,:new.unidad_operativa,:new.tecnico_unidad,sysdate,user,'U');
 END IF;
 IF deleting THEN
  INSERT INTO audi_ldc_asig_ot_tecn(unidad_operativa,tecnico_unidad,orden,unidad_operativa_new,tecnico_unidad_new,fecha,usuario,opera)
                             VALUES(:old.unidad_operativa,:old.tecnico_unidad,:old.orden,:new.unidad_operativa,:new.tecnico_unidad,sysdate,user,'D');
 END IF;
EXCEPTION
 WHEN OTHERS THEN
    pkErrors.GetErrorVar(nuErrCode, sbErrMsg);
END LDCTRG_AUDI_LDC_ASIG_OT_TECN;
/
