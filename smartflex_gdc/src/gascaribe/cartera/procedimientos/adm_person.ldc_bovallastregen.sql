CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_BOValLastRegen
IS

     /*****************************************************************
    Propiedad intelectual de PETI.

    Unidad         : LDC_BOValLastRegen
    Descripcion    : Procedimiento Personalizado para validar que si la causal
                     es de fallo y no existe regeneración, no se permita legalizar
                     la órden si no que se exija una causal de anulación.
                     (Aplica para suspensiones y Reconexiones de cartera)

    Autor          : Alejandro Cárdenas Cardona
    Fecha          : 15-10-2014

    Historia de Modificaciones
    Fecha             Autor               Modificacion
    ==========        ==================  ======================================
    15-10-2014        acardenas.NC3600    Creación.
    ****************************************************************************/

    nuTryLegal      or_order_activity.legalize_try_times%type;
    nuOrderId       OR_order.order_id%type;
    nuActivityId    or_order_activity.activity_id%type;
    rcOrderAct      or_order_activity%rowtype;
    nuCausalId      ge_causal.causal_id%type;
    nuCausalClas    ge_causal.class_causal_id%type;
    nuCausalType    ge_causal.causal_type_id%type;
    nuCounter       number;
    sbMessage       varchar2(10000);

    -- CURSOR para obtener registro de Actividad de órden
    CURSOR  cuOrderActivity(nuOrderId OR_order.order_id%type)
    IS
        SELECT  *
        FROM    OR_order_activity
        WHERE   order_id = nuOrderId
                AND rownum = 1;

    -- CURSOR para obtener registros de regeneración de actividades
    CURSOR  cuRegeneraOrder(
                            nuActivityId    OR_order_activity.activity_id%type,
                            nuCausalID      ge_causal.causal_id%type,
                            nuTryLegal      or_order_activity.legalize_try_times%type
                            )
    IS
        SELECT  count(*)
        FROM    or_regenera_activida
        WHERE   actividad = nuActivityId
                AND id_causal = nuCausalID
                AND try_legalize = nuTryLegal;


BEGIN
    ut_trace.trace('INICIO LDC_BOValLastRegen', 9);

    -- Obtener el identificador de la orden  que se encuentra en la instancia
    nuOrderId   :=  or_bolegalizeorder.fnuGetCurrentOrder;

    -- Obtener causal de legalización
    nuCausalId  :=  or_boorder.fnugetordercausal(nuOrderId);

    -- Obtiene el registro en Actividad de ÿrdenes
    open  cuOrderActivity(nuOrderId);
    fetch cuOrderActivity INTO rcOrderAct;
    close cuOrderActivity;

    -- Obtiene el intento de legalización actual
    nuTryLegal := rcOrderAct.legalize_try_times;

    -- Obtiene Actividad asociada a la órden
    nuActivityId := rcOrderAct.activity_id;

    -- Si la clase de causal es "Fallo" y el tipo diferente a "Anulación" valida regeneración
    nuCausalClas := dage_causal.fnugetclass_causal_id(nuCausalId);
    nuCausalType := dage_causal.fnugetcausal_type_id(nuCausalId);

    if nuCausalClas = 2 AND nuCausalType <> 18 then

        -- Verifica si existe configuración de regeneración para el intento y causal actual
        ut_trace.trace('Validación de Regeneración......', 10);
        ut_trace.trace('Numero de la Orden:'||nuOrderId, 10);
        ut_trace.trace('Causal de Legalización:'||nuCausalId, 10);
        ut_trace.trace('Intento Actual:'||nuTryLegal, 10);
        ut_trace.trace('Actividad:'||nuActivityId, 10);

        open  cuRegeneraOrder(nuActivityId, nuCausalId, nuTryLegal);
        fetch cuRegeneraOrder INTO nuCounter;
        close cuRegeneraOrder;

        -- Si no existe configuración de regeneración levanta error

        if nuCounter = 0 then
            sbMessage := 'No existe configuración de regeneración para la causal seleccionada.';
            sbMessage := sbMessage||' Se debe legalizar la órden con una causal de tipo "Anulación"';
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, sbMessage);
      		raise ex.CONTROLLED_ERROR;
        END if;
    END if;

    ut_trace.trace('FIN LDC_BOValLastRegen', 9);

EXCEPTION

    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;

    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;

END LDC_BOValLastRegen;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BOVALLASTREGEN', 'ADM_PERSON');
END;
/

