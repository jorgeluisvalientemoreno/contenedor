CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAIUDLDCUSUCUOININD
AFTER DELETE OR INSERT OR UPDATE ON ldc_usucuoinind
FOR EACH ROW
BEGIN

  IF INSERTING THEN
    insert into ldc_usucuoinindlog
    values(:new.contrato, :new.producto, :new.porc_cuotaini, 'I', USER, userenv('TERMINAL'), sysdate);
  ELSIF UPDATING THEN
    insert into ldc_usucuoinindlog
    values(:new.contrato, :new.producto, :new.porc_cuotaini, 'U', USER, userenv('TERMINAL'), sysdate);
  ELSE
    insert into ldc_usucuoinindlog
    values(:old.contrato, :old.producto, :old.porc_cuotaini, 'D', USER, userenv('TERMINAL'), sysdate);
  END IF;

  EXCEPTION
    WHEN OTHERS THEN
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'Error al registrar Auditoria de LDC_USUCUOININD.  ' ||
                                       sqlerrm);

END;
/
