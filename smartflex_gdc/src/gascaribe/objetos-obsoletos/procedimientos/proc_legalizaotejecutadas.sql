CREATE OR REPLACE PROCEDURE Proc_LegalizaOTEjecutadas AS
    /*=======================================================================
        Unidad         : Proc_LegalizaOTEjecutadas
        Descripcion    : Previene la legalizaci¿n de una OT desde OSF si ya
                         la OT ha sido gestionada desde Ludytrack
        Autor          : jgomez@horbath
        Fecha          : 30.12.2021

        Historia de Modificaciones

        Fecha             Autor             Modificaci¿n
        =========   ==================      ====================
        30.12.2021  jgomez@horbath.CA942    Creaci¿n
    =======================================================================*/
    onuerror     ge_error_log.error_log_id%TYPE;
    osbError     ge_error_log.description%TYPE;
    usrs         ld_parameter.value_chain%TYPE := dald_parameter.fsbgetvalue_chain('PARUSERLEGALOT');
    nuOrder      NUMBER;
    nuControl    NUMBER;
    nuFoundUsers NUMBER;
    blRaise      BOOLEAN := FALSE;
    nuEjecutada  NUMBER := 7;

    CURSOR cuLoadVal(inuOT NUMBER) IS
        SELECT COUNT(1)
          FROM OR_ORDER_STAT_CHANGE OSC
         WHERE OSC.ORDER_ID = inuOT
           AND OSC.USER_ID IN (SELECT REGEXP_SUBSTR(usrs, '[^,]+', 1, LEVEL) VALUES_
                                 FROM DUAL
                               CONNECT BY LEVEL <= (SELECT REGEXP_COUNT(usrs, ',')
                                                      FROM DUAL) + 1);

    CURSOR CuValUser(inuOT NUMBER) IS
        SELECT COUNT(1)
          FROM or_order_stat_change oosc
         WHERE oosc.final_status_id = nuEjecutada
           AND oosc.order_id = inuOT
           AND oosc.user_id IN (SELECT REGEXP_SUBSTR(usrs, '[^,]+', 1, LEVEL) VALUES_
                                  FROM DUAL
                                CONNECT BY LEVEL <= (SELECT REGEXP_COUNT(usrs, ',')
                                                       FROM DUAL) + 1);

BEGIN
    ut_trace.trace(isbmessage => '[ Proc_LegalizaOTEjecutadas', inulevel => 1);

    --<< Valida existencia de parametros
    IF usrs IS NULL
    THEN
        osbError := 'El par¿metro [PARUSERLEGALOT] no se encuentra configurado. Comun¿quese con el administrador del sistema.';
        ge_boerrors.seterrorcodeargument(2741, osbError);
    END IF;

    --<< Obtiene OT en proceso de legalizacion
    nuOrder := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace(isbmessage => '--<< nuOrder [' || nuOrder || ']', inulevel => 2);

    --<< Carga validacion de gestion de OT por personal parametrizado
    OPEN cuLoadVal(nuOrder);
    FETCH cuLoadVal
        INTO nuControl;
    CLOSE cuLoadVal;

    --<< Valida gesti¿n por personal parametrizado
    IF nuControl != 0
    THEN
        IF daor_order.fnugetorder_status_id(nuOrder) != nuEjecutada
        THEN
            blRaise := TRUE;
        ELSE
            --<< carga validaci¿n de ejecuci¿n de la OT
            OPEN CuValUser(nuOrder);
            FETCH CuValUser
                INTO nuFoundUsers;
            CLOSE CuValUser;

            --<< Valida usuario de ejecuci¿n
            blRaise := nuFoundUsers = 0;
        END IF;
    END IF;

    IF (blRaise)
    THEN
        ut_trace.trace(isbmessage => 'La OT [' || nuOrder || '] ya inici¿ gesti¿n desde el sistema Ludytrack. Por tal motivo la OT debe ser ejecutada desde Ludytrack', inulevel => 2);
        osbError := 'La OT [' || nuOrder || '] ya inici¿ gesti¿n desde el sistema Ludytrack. Por tal motivo la OT debe ser ejecutada desde Ludytrack';
        ge_boerrors.seterrorcodeargument(2741, osbError);
    END IF;

    ut_trace.trace(isbmessage => '] Proc_LegalizaOTEJEcutadas', inulevel => 1);
EXCEPTION
    WHEN OTHERS THEN
        ut_trace.trace(isbmessage => '] Proc_LegalizaOTEJEcutadas (err)', inulevel => 1);
        Errors.setError;
        errors.geterror(onuerror, osbError);
        RAISE ex.controlled_error;
END Proc_LegalizaOTEjecutadas;
/
