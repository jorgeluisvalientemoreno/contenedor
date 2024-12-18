CREATE OR REPLACE trigger ADM_PERSON.LDCTRG_AUD_EJECA_CONC_DIARIA
  after insert or update or delete on ldc_ejecuta_conc_diaria
  referencing old as old new as new for each row
  /**************************************************************
  Propiedad intelectual PETI.

  Trigger  :  ldc_ejecuta_conc_diaria

  Descripci¿n  : Registra auditoria de actualizaciones proceso

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 03-03-2015

  Historia de Modificaciones
  **************************************************************/

DECLARE
  nuErrCode number;
  sbErrMsg  VARCHAR2(2000);
  eerror    exception;
  eerror2   exception;
  eerror3   exception;
  sbterminal ldc_aud_ejecuta_conc_diaria.terminal%TYPE;
BEGIN
  SELECT SYS_CONTEXT ('USERENV', 'HOST') INTO sbterminal FROM DUAL;
 IF inserting THEN
  INSERT INTO ldc_aud_ejecuta_conc_diaria(proceco ,ejecuta_antes ,ejecuta_actu ,usuario ,terminal ,fecha,oper)
                                   VALUES(:new.proceco,null,:new.ejecuta,user,sbterminal,sysdate,'I');
 ELSIF updating THEN
  IF :old.ejecuta <> :new.ejecuta THEN
   INSERT INTO ldc_aud_ejecuta_conc_diaria(proceco ,ejecuta_antes ,ejecuta_actu ,usuario ,terminal ,fecha,oper)
                                   VALUES(:old.proceco,:old.ejecuta,:new.ejecuta,user,sbterminal,sysdate,'U');
  END IF;
 ELSIF deleting THEN
  INSERT INTO ldc_aud_ejecuta_conc_diaria(proceco ,ejecuta_antes ,ejecuta_actu ,usuario ,terminal ,fecha,oper)
                                   VALUES(:old.proceco,:old.ejecuta,NULL,user,sbterminal,sysdate,'D');
 END IF;
EXCEPTION
 WHEN OTHERS THEN
    pkErrors.GetErrorVar(nuErrCode, sbErrMsg);
END LDCTRG_AUD_EJECA_CONC_DIARIA;
/
