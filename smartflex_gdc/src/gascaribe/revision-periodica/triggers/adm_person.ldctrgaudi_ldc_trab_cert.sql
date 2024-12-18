CREATE OR REPLACE TRIGGER ADM_PERSON.LDCTRGAUDI_LDC_TRAB_CERT
  after insert or update or delete on ldc_trab_cert
  referencing old as old new as new for each row
  /**************************************************************
  Propiedad intelectual PETI.

  Trigger  :  ldctrgaudi_LDC_trab_cert

  Descripción  : Registra auditoria de cambio en audi_LDC_trab_cert

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 19-09-2013

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
  INSERT INTO audi_ldc_trab_cert(tipotrab, fecha, usuario, opera)
                          VALUES(:new.id_trabcert,SYSDATE,USER,'I');
 END IF;
 IF updating THEN
  INSERT INTO audi_ldc_trab_cert(tipotrab, fecha, usuario, opera)
                          VALUES(:old.id_trabcert,SYSDATE,USER,'U');
 END IF;
 IF deleting THEN
  INSERT INTO audi_ldc_trab_cert(tipotrab, fecha, usuario, opera)
                          VALUES(:old.id_trabcert,SYSDATE,USER,'D');
 END IF;
EXCEPTION
 WHEN OTHERS THEN
    pkErrors.GetErrorVar(nuErrCode, sbErrMsg);
END LDCTRGAUDI_LDC_TRAB_CERT;
/
