CREATE OR REPLACE TRIGGER ADM_PERSON.TRGIURPOLICYEXCLUSION
  AFTER INSERT OR UPDATE ON Ld_Policy_Exclusion
  REFERENCING OLD AS old NEW AS new
  For each row

/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger       :  trgiurPolicyExclusion

Descripcion   : Trigger que envia notificacion cuando el contrato no es valido

Autor         : AAcuna
Fecha         : 22-03-2013

Historia de Modificaciones
Fecha        IDEntrega           Modificacion
DD-MM-YYYY    Autor<SAO>      Descripcion de la Modificacion
**************************************************************/
DECLARE

  blSuscripc boolean;

BEGIN

  IF INSERTING THEN

    blSuscripc := pktblsuscripc.fblexist(:new.subscription_id);
    if (blSuscripc = false) then

      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El contrato digitado no existe');

    end if;

  END IF;

  IF UPDATING THEN

    blSuscripc := pktblsuscripc.fblexist(:new.subscription_id);

    if (blSuscripc = false) then

      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El contrato digitado no existe');

    end if;

  END IF;

EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
END TRGIURPOLICYEXCLUSION;
/
