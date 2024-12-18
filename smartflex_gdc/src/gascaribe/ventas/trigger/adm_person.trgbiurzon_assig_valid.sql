CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIURZON_ASSIG_VALID
  BEFORE INSERT OR UPDATE ON LD_ZON_ASSIG_VALID
  FOR EACH ROW

BEGIN
  if(pktblsuscripc.fblexist(:new.subscription_id))then
     null;
  else
     ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                   'El número de contrato: [ '|| :new.subscription_id || ' ]' ||
                                   ' no existe, favor validar');
  end if;
  if(:new.DATE_OF_VISIT > Sysdate )then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                   'Fecha de visita no debe ser mayor, a la fecha del sistema');
  end if;
EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    RAISE ex.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    Errors.setError;
    RAISE ex.CONTROLLED_ERROR;
END;
/
