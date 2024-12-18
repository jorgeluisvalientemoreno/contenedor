CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGBACTIGENE_ACTIVIDAD

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_TRGBACTIGENE_ACTIVIDAD
    Descripcion    : TRIGGER QUE PERMITE VALIDAR SI LA LA ACTIVIDAD NO ESTA ASOCIADO AL PROCESO
    Autor          : Jorge Valiente
    Fecha          : 28/10/2014

    Historia de Modificaciones
      Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

  BEFORE INSERT OR UPDATE OF ACTIVITY_ID_GENERADA, PROXIMA_ACTIVITY_ID ON LDC_ACTIVIDAD_GENERADA
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW --FOLLOWS TRG_BIUOR_ORDER_ACTIVITY

DECLARE

  onuerrorcode    number;
  osberrormessage varchar2(4000);

  ex_error exception;

  CURSOR CULDC_PROCESO_ACTIVIDAD(NUPROCESO_ID  LDC_PROCESO_ACTIVIDAD.PROCESO_ID%TYPE,
                                 NUACTIVITY_ID LDC_PROCESO_ACTIVIDAD.ACTIVITY_ID%TYPE) IS
    SELECT *
      FROM LDC_PROCESO_ACTIVIDAD
     WHERE LDC_PROCESO_ACTIVIDAD.PROCESO_ID = NUPROCESO_ID
       AND LDC_PROCESO_ACTIVIDAD.ACTIVITY_ID = NUACTIVITY_ID;

  TEMPCULDC_PROCESO_ACTIVIDAD CULDC_PROCESO_ACTIVIDAD%ROWTYPE;

BEGIN

  UT_TRACE.TRACE('INICIO LDC_TRGBPROCACTI_ACTIVIDAD', 10);

  OPEN CULDC_PROCESO_ACTIVIDAD(:NEW.PROCESO_ID, :NEW.ACTIVITY_ID_GENERADA);
  FETCH CULDC_PROCESO_ACTIVIDAD
    INTO TEMPCULDC_PROCESO_ACTIVIDAD;
  IF CULDC_PROCESO_ACTIVIDAD%NOTFOUND THEN
    CLOSE CULDC_PROCESO_ACTIVIDAD;
    osberrormessage := 'LA ACTIVIDAD GENERADA [' ||
                       :NEW.ACTIVITY_ID_GENERADA ||
                       '] NO ESTA ASOCIADO AL PROCESO [' || :NEW.PROCESO_ID || ']';
    raise ex_error;
  END IF;
  CLOSE CULDC_PROCESO_ACTIVIDAD;

  OPEN CULDC_PROCESO_ACTIVIDAD(:NEW.PROCESO_ID, :NEW.ACTIVITY_ID_GENERADA);
  FETCH CULDC_PROCESO_ACTIVIDAD
    INTO TEMPCULDC_PROCESO_ACTIVIDAD;
  IF CULDC_PROCESO_ACTIVIDAD%NOTFOUND THEN
    CLOSE CULDC_PROCESO_ACTIVIDAD;
    osberrormessage := 'LA ACTIVIDAD GENERADA [' ||
                       :NEW.ACTIVITY_ID_GENERADA ||
                       '] NO ESTA ASOCIADO AL PROCESO [' || :NEW.PROCESO_ID || ']';
    raise ex_error;
  END IF;
  CLOSE CULDC_PROCESO_ACTIVIDAD;

  UT_TRACE.TRACE('FIN LDC_TRGBPROCACTI_ACTIVIDAD', 10);

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
    osberrormessage := 'INCONSISTENCIA TRIGGER LDC_TRGBPROCACTI_ACTIVIDAD [' ||
                       DBMS_UTILITY.FORMAT_ERROR_STACK || '] - [' ||
                       DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     osberrormessage);

    UT_Trace.Trace('Error procreaitemspago: ' || osberrormessage, 10);
    dbms_output.put_line('Error procreaitemspago: ' || osberrormessage);

END LDC_TRGBTIPOTRABCERTIFICA_ITEM;
/
