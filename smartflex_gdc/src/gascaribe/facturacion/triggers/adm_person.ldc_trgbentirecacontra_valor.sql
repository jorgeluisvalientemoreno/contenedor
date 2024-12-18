CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGBENTIRECACONTRA_VALOR

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_TRGBENTIRECACONTRA_VALOR
    Descripcion    : TRIGGER QUE PERMITE VALIDAR SI LA TARIFA UNICA ESTA ACTIVA O NO
                     PARA VALIDAR EL VALOR DE LA TARIFA
    Autor          : Jorge Valiente
    Fecha          : 16/09/2014

    Historia de Modificaciones
      Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

  BEFORE INSERT OR UPDATE OF VALOR ON LDC_ENTIRECA_CONTRA
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW --FOLLOWS TRG_BIUOR_ORDER_ACTIVITY

DECLARE

  onuerrorcode    number;
  osberrormessage varchar2(4000);

  ex_error exception;

BEGIN

  UT_TRACE.TRACE('INICIO LDC_TRGBTARIFACONCEPTO_VALIDA', 10);

  if :NEW.VALOR_UNICO = 'S' AND NVL(:NEW.VALOR,0) <= 0 then
    osberrormessage := 'Obligatorio colocar el valor si el flag de TARIFA UNICA esta activo';
    raise ex_error;
  end if;

  if :NEW.VALOR_UNICO = 'N' AND NVL(:NEW.VALOR,0) > 0 then
    osberrormessage := 'Obligatorio NO colocar el valor si el flag de TARIFA UNICA esta inactivo';
    raise ex_error;
  end if;

  UT_TRACE.TRACE('FIN LDC_TRGBTARIFACONCEPTO_VALIDA', 10);

EXCEPTION

  when ex_error then
    --raise;
    --errors.seterror;
    --errors.geterror(nuerrorcode, sberrormessage);
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     osberrormessage);

    UT_Trace.Trace('Error procreaitemspago: ' || osberrormessage, 10);
    dbms_output.put_line('Error procreaitemspago: ' || osberrormessage);

    raise;
  WHEN OTHERS THEN
    osberrormessage := 'INCONSISTENCIA TRIGGER LDC_TRGBENTIRECACONTRA_VALOR [' ||
                       DBMS_UTILITY.FORMAT_ERROR_STACK || '] - [' ||
                       DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

END LDC_TRGBENTIRECACONTRA_VALOR;
/
