CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_LD_SUBS_COMO_DATO
BEFORE INSERT OR UPDATE ON  LD_SUBS_COMO_DATO
FOR EACH ROW
DECLARE
/**************************************************************************************
Propiedad Intelectual de SINCECOMP (C).

Trigger     : LDC_TRG_LD_SUBS_COMO_DATO
Descripcion : Trigger para controlar el ingreso de fechas a la tabla LD_SUBS_COMO_DATO
Autor       : Sebastian Tapias || 200-1164
Fecha       : 10-05-2017

Historia de Modificaciones

  Fecha               Autor                Modificacion
=========           =========          ====================
***************************************************************************************/
/*Variable para almacenar fecha actual*/
v_fecha_actual DATE := sysdate;

BEGIN
  /*Valida si el contrato existe*/
  DECLARE
  v_contrato SUSCRIPC.susccodi%type;
  BEGIN
    SELECT susccodi INTO v_contrato FROM SUSCRIPC WHERE susccodi = :new.codacont;
    IF v_contrato is null then
      errors.seterror(2741, 'El contrato ingresado no es valido');
      RAISE ex.controlled_error;
      END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
      errors.seterror(2741, 'El contrato ingresado no es valido');
      RAISE ex.controlled_error;
      WHEN EX.CONTROLLED_ERROR THEN
           RAISE;
      WHEN others THEN
           RAISE;
  END;

/*Valida si la fecha inicial de vigencia es menor que la fecha actual.*/
IF (TRUNC (:new.codafivi) < TRUNC (v_fecha_actual)) THEN
   errors.seterror(2741, 'La FECHA INICIAL de vigencia no puede ser menor a la FECHA ACTUAL');
   RAISE ex.controlled_error;
  END IF;
/*Valida si la fecha final de vigencia es menor que la fecha actual.*/
IF (TRUNC (:new.codaffvi) < TRUNC (v_fecha_actual)) THEN
  errors.seterror(2741, 'La FECHA FINAL de vigencia no puede ser menor a la FECHA ACTUAL');
   RAISE ex.controlled_error;
  END IF;
/*Validad si la fecha final de vigencia es menor que la fecha inicial de vigencia.*/
IF (TRUNC (:new.codaffvi) < TRUNC (:new.codafivi)) THEN
  errors.seterror(2741, 'La FECHA FINAL de vigencia no puede ser menor a la FECHA INICIAL');
   RAISE ex.controlled_error;
  END IF;

EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
           RAISE;
      WHEN others THEN
           RAISE;
END;
/
