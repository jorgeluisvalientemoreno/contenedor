CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIURLD_SUPPLI_MODIFICA_DATE
  BEFORE INSERT OR UPDATE OF INITIAL_DATE, FINAL_DATE, INITIAL_HOUR, FINAL_HOUR ON LD_SUPPLI_MODIFICA_DATE
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW
--WHEN (new.initial_date  > new.final_date)
  /**************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Trigger      : trgbiurLD_SUPPLI_MODIFICA_DATE
  Descripcion  : Trigger para validacion de fecha inicial y fecha final.
  Autor        : Alex Valencia Ayola
  Fecha        : 28/Feb/2013

  Historia de Modificaciones
  Fecha        IDEntrega           Modificacion

  **************************************************************/
DECLARE
  cnuGeneric_Error CONSTANT NUMBER := 2741; /*constante de error*/
BEGIN
  :new.initial_hour := to_char(:new.initial_date, 'HH24:MI');
  :new.final_hour   := to_char(:new.final_date, 'HH24:MI');

  IF (INSERTING) THEN
    IF (:new.initial_date > :new.final_date) THEN
      GI_BOERRORS.SETERRORCODEARGUMENT(cnuGeneric_Error,
                                       'Fecha de inicio debe ser menor a la fecha final');

      RAISE ex.controlled_error;
    END IF;

    IF ((:new.initial_date < Sysdate) OR (:new.final_date < Sysdate)) THEN
      GI_BOERRORS.SETERRORCODEARGUMENT(cnuGeneric_Error,
                                       'Fecha de inicio y fecha final no deben ser menor a la fecha del sistema');

      RAISE ex.controlled_error;
    END IF;
  END IF;
  IF (UPDATING) THEN
    IF (:new.final_date < SYSDATE OR :new.final_date < :new.initial_date) THEN
      GI_BOERRORS.SETERRORCODEARGUMENT(cnuGeneric_Error,
                                       'La fecha final debe ser mayor a la fecha inicial, y mayor a la fecha del sistema');

      RAISE ex.controlled_error;
    END IF;
  END IF;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    RAISE ex.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    Errors.setError;
    RAISE ex.CONTROLLED_ERROR;
END TRGBIURLD_SUPPLI_MODIFICA_DATE;
/
