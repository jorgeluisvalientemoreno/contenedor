CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGBTIPOTRABCERTIFICA_ITEM

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_TRGBTIPOTRABCERTIFICA_ITEM
    Descripcion    : TRIGGER QUE PERMITE VALIDAR SI LA LA ACTIVIDAD ESTA ASOCIADA AL TIPO DE TRABAJO
    Autor          : Jorge Valiente
    Fecha          : 09/10/2014

    Historia de Modificaciones
      Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

  BEFORE INSERT OR UPDATE OF ITEMS_ID ON LDC_TIPOTRAB_CERTIFICA
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW --FOLLOWS TRG_BIUOR_ORDER_ACTIVITY

DECLARE

  onuerrorcode    number;
  osberrormessage varchar2(4000);

  ex_error exception;

  CURSOR CUOR_TASK_TYPES_ITEMS(NUTASK_TYPE_ID OR_TASK_TYPE.TASK_TYPE_ID%TYPE,
                               NUITEMS_ID     GE_ITEMS.ITEMS_ID %TYPE) IS
    SELECT *
      FROM OR_TASK_TYPES_ITEMS
     WHERE OR_TASK_TYPES_ITEMS.TASK_TYPE_ID = NUTASK_TYPE_ID
       AND OR_TASK_TYPES_ITEMS.ITEMS_ID = NUITEMS_ID;

  TEMPCUOR_TASK_TYPES_ITEMS CUOR_TASK_TYPES_ITEMS%ROWTYPE;

BEGIN

  UT_TRACE.TRACE('INICIO LDC_TRGBTARIFACONCEPTO_VALIDA', 10);

  OPEN CUOR_TASK_TYPES_ITEMS(:NEW.TASK_TYPE_ID, :NEW.ITEMS_ID);
  FETCH CUOR_TASK_TYPES_ITEMS
    INTO TEMPCUOR_TASK_TYPES_ITEMS;
  IF CUOR_TASK_TYPES_ITEMS%NOTFOUND THEN
    osberrormessage := 'EL ITEM [' || :NEW.ITEMS_ID ||
                       '] NO ESTA ASOCIADO A TIPO DE TRABAJO [' ||
                       :NEW.TASK_TYPE_ID || ']';
    raise ex_error;
  END IF;
  CLOSE CUOR_TASK_TYPES_ITEMS;

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
    osberrormessage := 'INCONSISTENCIA TRIGGER LDC_TRBIGASIGAUTO [' ||
                       DBMS_UTILITY.FORMAT_ERROR_STACK || '] - [' ||
                       DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

END LDC_TRGBTIPOTRABCERTIFICA_ITEM;
/
