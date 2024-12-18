CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIURLD_ROLLOVER_QUOTA
  BEFORE INSERT OR UPDATE ON LD_ROLLOVER_QUOTA
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW

  /**************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Trigger      : trgbiurLD_ROLLOVER_QUOTA
  Descripcion  : Trigger que valida que no se permita ingresar en los campos
                 (Valor de incremento y Numero de cuotas) valores menores o igual a cero
  Autor        : Evelio Sanjuanelo
  Fecha        : 02/Abr/2013

  Historia de Modificaciones
  Fecha        IDEntrega           Modificacion
  **************************************************************/
BEGIN

  IF :new.value <= 0 THEN
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'El Valor del campo "Valor del Incremento" debe ser mayor que cero');
  END IF;
  IF :new.quotas_number < 0 THEN
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'El Valor del campo "Número de Cuotas" debe ser mayor, o igual a cero');
  END IF;
EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    RAISE ex.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    Errors.setError;
    RAISE ex.CONTROLLED_ERROR;
END TRGBIURLD_ROLLOVER_QUOTA;
/
