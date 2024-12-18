CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_BOValExecutionDates
IS
    /***************************************************************************
    Propiedad intelectual de PETI.

    Unidad         : LDC_BOValExecutionDates
    Descripcion    : Procedimiento Personalizado para validar que la fecha inicial
                     de ejecución sea mayor a la fecha de creación de la órden, en
                     caso contrario genera un error y no permite la legalización.

                     Aplica para los tipos de trabajo de reconexión y suspensión
                     por cartera, puesto que si esta restricción no se realiza, se
                     genera un error a la hora de atender el registro de suspensión
                     y reconexión en SUSPCONE.

    Autor          : Alejandro Cárdenas Cardona
    Fecha          : 19-02-2015

    Historia de Modificaciones
    Fecha             Autor                     Modificacion
    ==========        ==================        ================================
    19-02-2015        acardenas.Aranda141343    Creación

    ****************************************************************************/

    nuOrderId       OR_order.order_id%type;
    dtExecIniDate   OR_order.exec_initial_date%type;
    dtCreatedDate   OR_order.created_date%type;
    sbMessage       varchar2(10000);

    -- CURSOR para obtener registro de Actividad de órden
    CURSOR  cuOrderActivity(nuOrderId OR_order.order_id%type)
    IS
        SELECT  *
        FROM    OR_order_activity
        WHERE   order_id = nuOrderId
                AND rownum = 1;
BEGIN
    ut_trace.trace('INICIO LDC_BOValExecutionDates', 9);

    -- Obtener el identificador de la orden  que se encuentra en la instancia
    nuOrderId   :=  or_bolegalizeorder.fnuGetCurrentOrder;

    ut_trace.trace('Orden ['||nuOrderId||']', 10);
    ut_trace.trace('Se valida la fecha de inicio de ejecución...', 11);

    -- Obtiene fecha de inicio de ejecución y fecha de creación de la órden
    dtExecIniDate := daor_order.fdtgetexec_initial_date(nuOrderId);
    dtCreatedDate := daor_order.fdtgetcreated_date(nuOrderId);

    ut_trace.trace('Fecha de Inicio de Ejecución ['||dtExecIniDate||']', 11);
    ut_trace.trace('Fecha de Creación de la órden ['||dtCreatedDate||']', 11);

    -- verifica que la fecha de inicio de ejecución no sea menor que la fecha de creación
    if dtCreatedDate > dtExecIniDate then

        sbMessage := 'La fecha de Inicio de Ejecución ['||dtExecIniDate||'] ';
        sbMessage := sbMessage||'NO debe ser menor que la Fecha de Creación de la ÿrden [';
        sbMessage := sbMessage||dtCreatedDate||'].';

        ut_trace.trace('ERROR!!! '||sbMessage, 12);

        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, sbMessage);
  		raise ex.CONTROLLED_ERROR;

    END if;

    ut_trace.trace('FIN LDC_BOValExecutionDates', 9);

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END LDC_BOValExecutionDates;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BOVALEXECUTIONDATES', 'ADM_PERSON');
END;
/

