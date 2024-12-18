create or replace PROCEDURE adm_person.ldc_valida_fecha_asignacion
IS
    /******************************************************************
    Propiedad intelectual de GDC.

    Unidad         : LDC_VALIDA_FECHA_ASIGNACION
    Descripcion    : Caso 362: Valida que la fecha de asignación sea menor a la fecha
                               de inicio de ejecución

    Autor          : OLSolftware
    Fecha          : 24/06/2020

    Parametros              Descripcion
    ============         ===================

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    24/06/2020      OLSoftware.CA362    Creación
    24/04/2024      Adrianavg           OSF-2597: Se migra del esquema OPEN al esquema ADM_PERSON
    ******************************************************************/

    nuOrderId               or_order.order_id%type;
    dtFechaAsigna           or_order.Created_Date%type;
    dtInicioEjecucion       or_order.Exec_Initial_Date%type;
    sbEntrega               VARCHAR2(100) := '0000362';

BEGIN

    ut_trace.trace('Inicio LDC_VALIDA_FECHA_ASIGNACION', 10);

    -- Se valida si aplica para la gasera
    IF fblaplicaentregaxcaso(sbEntrega) THEN

        -- Obtener orden de la instancia
        nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
        ut_trace.trace('nuOrderId => '||nuOrderId, 10);

        -- Obtener fecha de asignacion de la orden de la instancia
        dtFechaAsigna := daor_order.fdtgetassigned_date(nuOrderId,0);
        ut_trace.trace('dtFechaAsigna => '||dtFechaAsigna, 10);

        -- Obtener fecha de ejecución inicial
        dtInicioEjecucion := daor_order.fdtGetExec_Initial_Date(nuOrderId,0);
        ut_trace.trace('dtInicioEjecucion => '||dtInicioEjecucion, 10);

        -- Valide que la fecha de ejecuci?n inicial sea mayot a la fecha de asignación
        IF dtInicioEjecucion < dtFechaAsigna THEN
            ge_boerrors.seterrorcodeargument
            (
                Ld_Boconstans.cnuGeneric_Error,
                'La fecha de Ejecución Inicial ['||TO_CHAR(dtInicioEjecucion,'DD/MM/YYYY HH24:MI:SS')||
                '] debe ser mayor a la fecha de Asignación ['||TO_CHAR(dtFechaAsigna,'DD/MM/YYYY HH24:MI:SS')||']. Favor validar'
            );

            RAISE ex.CONTROLLED_ERROR;

        END IF;
    END IF;
    ut_trace.trace('Fin LDC_VALIDA_FECHA_ASIGNACION', 10);

EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
        RAISE ex.CONTROLLED_ERROR;
    WHEN others THEN
        Errors.setError;
        RAISE ex.CONTROLLED_ERROR;

END LDC_VALIDA_FECHA_ASIGNACION;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento LDC_VALIDA_FECHA_ASIGNACION
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_VALIDA_FECHA_ASIGNACION', 'ADM_PERSON'); 
END;
/