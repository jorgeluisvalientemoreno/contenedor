CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_EXECACTIONBYTRYLEG
    (
        inuOrderId          in  OR_order.order_id%type,
        inuOperUnitId       in  OR_operating_unit.operating_unit_id%type,
        inuAction           in  or_regenera_activida.action%type,
        inuTiempoEspera     in  or_regenera_activida.tiempo_espera%type
    )
    IS
    BEGIN

        ut_trace.trace('INICIA - LDC_ExecActionByTryLeg',15);
        ut_trace.trace('inuOrderId['||inuOrderId||'] - inuOperUnitId['||inuOperUnitId||'] - inuAction['||inuAction||'] - inuTiempoEspera['||inuTiempoEspera||']',15);

        -- Si la orden tiene más de una actividad no debe ejecutar acción alguna sobre la orden debido
        -- a que solo ejecuta la acción de la primera orden
        if(or_bcorderactivities.fnuGetCountOrderActivities(inuOrderId)>1)then
            return;
        END if;

        if(inuAction = or_boconstants.cnuToBlockOrder) then
            or_bolockorder .LockOrder
            (
                inuOrderId,
                or_boconstants.cnuGeneralType
            );
        elsif(inuAction = or_boconstants.cnuAutoAssignOrder)then
            AssignOrderAction
            (
                inuOrderId,
                inuOperUnitId,
                inuTiempoEspera
            );
        else
            ReprogramOrderAction
            (
                inuOrderId,
                inuTiempoEspera
            );
        END if;

        ut_trace.trace('FIN - LDC_ExecActionByTryLeg',15);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END LDC_ExecActionByTryLeg;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_EXECACTIONBYTRYLEG', 'ADM_PERSON');
END;
/
