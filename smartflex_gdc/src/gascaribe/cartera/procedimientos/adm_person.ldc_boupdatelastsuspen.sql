CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_BOUPDATELASTSUSPEN
IS
     /*****************************************************************
    Propiedad intelectual de PETI.

    Unidad         : LDC_BOUpdateLastSuspen
    Descripcion    : Procedimiento Personalizado para actualizar la última actividad
                     de suspensión de un producto en PR_PRODUCT

    Autor          : Alejandro Cárdenas Cardona
    Fecha          : 15-10-2014

    Historia de Modificaciones
    Fecha             Autor               Modificacion
    ==========        ==================  ======================================
    15-10-2014        acardenas.NC3600    Creación.
    ****************************************************************************/

    nuOrderId       OR_order.order_id%type;
    nuActivityId    or_order_activity.activity_id%type;
    rcOrderAct      or_order_activity%rowtype;
    nuProductId     pr_product.product_id%type;

    -- CURSOR para obtener registro de Actividad de órden
    CURSOR  cuOrderActivity(nuOrderId OR_order.order_id%type)
    IS
        SELECT  *
        FROM    OR_order_activity
        WHERE   order_id = nuOrderId
                AND register_date = (
                                    SELECT  max(register_date)
                                    FROM    OR_order_activity
                                    WHERE   ORDER_id = nuOrderId
                                            AND product_id IS not null
                                    );

BEGIN
    ut_trace.trace('INICIO LDC_BOUpdateLastSuspen', 9);

    -- Obtener el identificador de la orden  que se encuentra en la instancia
    nuOrderId   :=  or_bolegalizeorder.fnuGetCurrentOrder;

    -- Obtiene el registro en Actividad de ÿrdenes
    open  cuOrderActivity(nuOrderId);
    fetch cuOrderActivity INTO rcOrderAct;
    close cuOrderActivity;

    -- Obtiene el producto asociado a la actividad de órden
    nuProductId := rcOrderAct.product_id;

    -- Obtiene Actividad asociada a la órden
    nuActivityId := rcOrderAct.order_activity_id;

    -- Actualiza actividad de suspensión en el producto sólo si existen datos
    if nuProductId IS not null AND nuActivityId IS not null then

        ut_trace.trace('Actualiza ÿltima Actividad de Suspensión...', 10);
        ut_trace.trace('Producto: '||nuProductId, 10);
        ut_trace.trace('Actividad de ÿrden: '||nuActivityId, 10);

        dapr_product.updsuspen_ord_act_id(nuProductId,nuActivityId);

    END if;

    ut_trace.trace('FIN LDC_BOUpdateLastSuspen', 9);

EXCEPTION

    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;

    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;

END LDC_BOUPDATELASTSUSPEN;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BOUPDATELASTSUSPEN', 'ADM_PERSON');
END;
/
