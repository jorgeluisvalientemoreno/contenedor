CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_BOREPROCESAORD IS
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BoReprocesaOrd
    Descripcion    : Servicios para gestionar la forma LDPOR
    Autor          : Horbath
	Caso           : 745
    Fecha          : 30-05-2021

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================

  ******************************************************************/

  /*****************************************************************
    Unidad         : ProcesaLinea
    Descripcion    : Procesa la linea del archivo enviada desde LDPOR
  ******************************************************************/
    PROCEDURE ProcesaLinea
    (
        inuAction       IN  ldc_log_process_ldpor.action%TYPE,
        isbLine         IN  VARCHAR2,
        onuProcessExit  OUT nocopy NUMBER,
        onuProcessFail  OUT nocopy NUMBER
    );

    /*****************************************************************
    Unidad         : GetLOVAction
    Descripcion    : Obtiene las acciones posibles a realizar
  ******************************************************************/
    PROCEDURE GetLOVAction
    (
        orfLOVActions  out  nocopy pkconstante.tyRefCursor
    );

END LDC_BOREPROCESAORD;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_BOREPROCESAORD IS
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BoReprocesaOrd
    Descripcion    : Servicios para gestionar la forma LDPOR
    Autor          : Horbath
	Caso           : 745
    Fecha          : 30-05-2021

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================

  ******************************************************************/

    cnuPENDENVIO        CONSTANT    NUMBER := 1;
    cnuANULA            CONSTANT    NUMBER := 2;
    cnuREENVIO          CONSTANT    NUMBER := 3;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fblValidateValue
    Descripcion    : Valida si el dato ingresado es numerico
    Autor          : Horbath
	Caso           : 745
    Fecha          : 30-05-2021

    Nombre         :
    Parametros         Descripcion
    ============  ===================
    isbValue     Identificador de la orden o proceso

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
    FUNCTION fblValidateValue
    (
        isbValue    IN      VARCHAR2
    )
    RETURN BOOLEAN
    IS
        nuValue     NUMBER;
    BEGIN

        nuValue := TO_NUMBER(isbValue);

        RETURN TRUE;

    EXCEPTION
        when OTHERS then
            RETURN FALSE;
    END fblValidateValue;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : RegisterLog
    Descripcion    : Registra en la tabla del log LDC_LOG_PROCESS_LDPOR
    Autor          : Horbath
	Caso           : 745
    Fecha          : 30-05-2021

    Nombre         :
    Parametros         Descripcion
    ============  ===================
    inuAction     Identificador de la accion a procesar
    isbLine       Linea con las ordenes o procesos

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
    PROCEDURE RegisterLog
    (
        isbOrdProcess       IN  VARCHAR2,
        inuAction           IN  ldc_log_process_ldpor.action%TYPE,
        isbErrorMessage     IN  ldc_log_process_ldpor.message_error%TYPE
    )
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;

        rcLog             ldc_log_process_ldpor%ROWTYPE;
        sbUser            ldc_log_process_ldpor.user_%TYPE;

    BEGIN
        ut_trace.Trace('INICIO - LDC_BoReprocesaOrd.RegisterLog', 10);

        SELECT USER
        INTO sbUser
        FROM DUAL;

        rcLog.process_ldpor_id := SEQ_LDC_LOG_PROCESS_LDPOR.NEXTVAL;
        rcLog.register_date := ut_date.fdtsysdate;
        rcLog.action := inuAction;
        rcLog.message_error := isbErrorMessage;
        rcLog.user_ := sbUser;

        IF NOT fblValidateValue(isbOrdProcess) THEN
            rcLog.message_error := 'Orden o proceso inv�lido: '||isbOrdProcess||' - '||isbErrorMessage;
            rcLog.process_order_id := NULL;
        ELSE
            rcLog.process_order_id := isbOrdProcess;
        END IF;

        INSERT INTO ldc_log_process_ldpor VALUES rcLog;

        COMMIT;

        ut_trace.Trace('FIN - LDC_BoReprocesaOrd.RegisterLog', 10);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;

    END RegisterLog;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : ProcesaLinea
    Descripcion    : Procesa la linea del archivo enviada desde LDPOR
    Autor          : Horbath
	Caso           : 745
    Fecha          : 30-05-2021

    Nombre         :
    Parametros         Descripcion
    ============  ===================
    inuAction     Identificador de la accion a procesar
    isbLine       Linea con las ordenes o procesos

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
    PROCEDURE ProcesaLinea
    (
        inuAction       IN  ldc_log_process_ldpor.action%TYPE,
        isbLine         IN  VARCHAR2,
        onuProcessExit  OUT nocopy NUMBER,
        onuProcessFail  OUT nocopy NUMBER
    )
    IS
        tbOrders        ut_string.tytb_string;
        nuIndex         NUMBER;
        nuErrorCode     NUMBER;
        sbErrorMessage  VARCHAR2(4000);

    BEGIN
        ut_trace.Trace('INICIO - LDC_BoReprocesaOrd.ProcesaLinea', 10);

        onuProcessExit := 0;
        onuProcessFail := 0;

        ut_string.extstring(isbLine, ',', tbOrders);

        nuIndex := tbOrders.first;

        LOOP
            EXIT WHEN nuIndex IS NULL;

                BEGIN
                    IF tbOrders(nuIndex) IS NOT NULL THEN

                        IF inuAction = cnuPENDENVIO THEN
                            UPDATE LDCI_ORDENMOVILES
                                SET ESTADO_ENVIO = 'P'
                            WHERE ORDER_ID = tbOrders(nuIndex);

                        ELSIF inuAction = cnuANULA THEN
                            UPDATE LDCI_ORDENMOVILES
                                SET ESTADO_ENVIO_ANULA = 'P'
                            WHERE ORDER_ID = tbOrders(nuIndex);

                        ELSIF inuAction = cnuREENVIO THEN
                            UPDATE OPEN.LDCI_MESAENVWS
                                SET MESAESTADO = -1
                            WHERE MESAPROC = tbOrders(nuIndex);
                        END IF;

                        COMMIT;

                        onuProcessExit := onuProcessExit + 1;

                    END IF;

                EXCEPTION
                    when ex.CONTROLLED_ERROR then
                        Errors.getError(nuErrorCode, sbErrorMessage);
                        RegisterLog(tbOrders(nuIndex), inuAction, sbErrorMessage);
                        onuProcessFail := onuProcessFail + 1;
                    when OTHERS then
                        Errors.SetError;
                        Errors.getError(nuErrorCode, sbErrorMessage);
                        RegisterLog(tbOrders(nuIndex), inuAction, sbErrorMessage);
                        onuProcessFail := onuProcessFail + 1;
                END;

            nuIndex := tbOrders.NEXT(nuIndex);
        END LOOP;


        ut_trace.Trace('FIN - LDC_BoReprocesaOrd.ProcesaLinea', 10);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;
    END ProcesaLinea;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : GetLOVAction
    Descripcion    : Obtiene las acciones posibles a realizar
    Autor          : Horbath
	Caso           : 745
    Fecha          : 30-05-2021

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================
    orfLOVActions   Cursor con las acciones

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
   ******************************************************************/
    PROCEDURE GetLOVAction
    (
        orfLOVActions  out  nocopy pkconstante.tyRefCursor
    )
    IS
    BEGIN

        ut_trace.Trace('INICIO: LDC_BoReprocesaOrd.GetLOVPackType', 8);

        open orfLOVActions for
            SELECT 1 ID, 'Pendiente de env�o' Description FROM dual
            UNION ALL
            SELECT 2 ID, 'Anular' Description FROM dual
            UNION ALL
            SELECT 3 ID, 'Reenv�o de proceso' Description FROM dual;

        ut_trace.Trace('FIN - LDC_BoReprocesaOrd.GetLOVAction', 8);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;

    END GetLOVAction;


END LDC_BOREPROCESAORD;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BOREPROCESAORD', 'ADM_PERSON'); 
END;
/  