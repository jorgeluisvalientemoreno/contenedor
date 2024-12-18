CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIURLD_RESOL_CONS_UNIT BEFORE INSERT OR UPDATE ON LD_RESOL_CONS_UNIT
REFERENCING OLD AS old NEW AS new
FOR EACH ROW
/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger      : trgbiurLD_RESOL_CONS_UNIT
Descripcion  : Trigger para validar que el campo cost_unit sea mayor que cero
Autor        : Evelio Sanjuanelo
Fecha        : 02/Jun/2013

Historia de Modificaciones
Fecha        IDEntrega           Modificación

**************************************************************/
DECLARE

BEGIN

  IF  UPDATING or INSERTING THEN

    IF (:new.cost_unit <= 0) THEN
      ge_boerrors.seterrorcodeargument(
                       ld_boconstans.cnuGeneric_Error,
                       'El valor debe ser mayor que cero');
    END IF;
  END IF;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    RAISE ex.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    Errors.setError;
    RAISE ex.CONTROLLED_ERROR;
END TRGBIURLD_RESOL_CONS_UNIT;
/
