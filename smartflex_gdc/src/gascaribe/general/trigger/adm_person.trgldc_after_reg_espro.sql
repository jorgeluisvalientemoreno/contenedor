CREATE OR REPLACE trigger ADM_PERSON.trgLDC_after_REG_ESPRO
  after UPDATE of product_status_id,suspen_ord_act_id ON PR_PRODUCT
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW
DECLARE
  sbErrMsg  varchar2(2000); -- Mensaje error
  nuErrCode number; -- Mensaje error
  nuidregistro    ldc_usuarios_actualiza_cl.idregistro%TYPE;
Begin

  -- Se setea el trgLDC_REG_HIST_ESPRO en el modulo de errores

  pkErrors.Push('trgLDC_after_REG_ESPRO');
  IF :new.product_status_id <> :old.product_status_id THEN
      nuidregistro := seq_ldc_usuarios_actualiza_cl.nextval;
     INSERT INTO ldc_usuarios_actualiza_cl(producto,espro,idregistro) VALUES(:new.product_id,'S',nuidregistro);
  END IF;
  IF :new.suspen_ord_act_id <> :old.suspen_ord_act_id THEN
     nuidregistro := seq_ldc_usuarios_actualiza_cl.nextval;
     INSERT INTO ldc_usuarios_actualiza_cl(producto,acsu,idregistro) VALUES(:new.product_id,'S',nuidregistro);
  END IF;

  pkErrors.Pop;

exception
  when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
    pkErrors.GetErrorVar(nuErrCode, sbErrMsg);
    pkErrors.Pop;
    raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
  when others then
    pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
    pkErrors.Pop;
    raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
End;
/
