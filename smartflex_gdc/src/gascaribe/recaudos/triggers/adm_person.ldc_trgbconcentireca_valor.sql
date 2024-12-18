CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGBCONCENTIRECA_VALOR

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

  BEFORE INSERT OR UPDATE OF VALOR ON LDC_CONC_ENTIRECA
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW --FOLLOWS TRG_BIUOR_ORDER_ACTIVITY

DECLARE

  onuerrorcode    number;
  osberrormessage varchar2(4000);

  ex_error exception;

  CURSOR CULDC_ENTIRECA_CONTRA(NUID_CONTRATISTA LDC_ENTIRECA_CONTRA.ID_CONTRATISTA%TYPE,
                               NUBANCCODI       LDC_ENTIRECA_CONTRA.BANCCODI%TYPE) IS
    SELECT *
      FROM LDC_ENTIRECA_CONTRA
     WHERE LDC_ENTIRECA_CONTRA.ID_CONTRATISTA = NUID_CONTRATISTA
       AND LDC_ENTIRECA_CONTRA.BANCCODI = NUBANCCODI;

  TEMPCULDC_ENTIRECA_CONTRA CULDC_ENTIRECA_CONTRA%ROWTYPE;

BEGIN

  UT_TRACE.TRACE('INICIO LDC_TRGBTARIFACONCEPTO_VALIDA', 10);

  OPEN CULDC_ENTIRECA_CONTRA(:NEW.ID_CONTRATISTA, :NEW.BANCCODI);
  FETCH CULDC_ENTIRECA_CONTRA
    INTO TEMPCULDC_ENTIRECA_CONTRA;
  IF CULDC_ENTIRECA_CONTRA%FOUND THEN
    if TEMPCULDC_ENTIRECA_CONTRA.VALOR_UNICO = 'S' AND
       NVL(:NEW.VALOR, 0) > 0 then
      osberrormessage := 'Obligatorio NO colocar el valor si el flag de TARIFA UNICA esta activo';
      raise ex_error;
    end if;

    if TEMPCULDC_ENTIRECA_CONTRA.VALOR_UNICO = 'N' AND
       NVL(:NEW.VALOR, 0) <= 0 then
      osberrormessage := 'Obligatorio colocar el valor si el flag de TARIFA UNICA esta inactivo';
      raise ex_error;
    end if;
  END IF;
  CLOSE CULDC_ENTIRECA_CONTRA;

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

END LDC_TRBIGASIGAUTO;
/
