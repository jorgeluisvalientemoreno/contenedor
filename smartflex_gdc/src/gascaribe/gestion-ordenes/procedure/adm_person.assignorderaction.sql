CREATE OR REPLACE PROCEDURE ADM_PERSON.ASSIGNORDERACTION
    (
        inuOrderId          in  OR_order.order_id%type,
        inuOperUnitId       in  OR_operating_unit.operating_unit_id%type,
        inuTiempoEspera     in  or_regenera_activida.tiempo_espera%type
    )
    IS
        rcOrder         daor_order.styOR_order;
    BEGIN

        rcOrder := daor_order.frcGetRecord(inuOrderId);

        if(inuTiempoEspera > 0) then
            --  Modifica la fecha de asignación de la orden
            rcOrder.assigned_date := trunc(ge_bccalendar.fdtGetNNextDateNonHoliday(ut_date.fdtSysdate, inuTiempoEspera));
            -- Si la acción es autoasignar entonces asigna la unidad a la orden
            rcOrder.operating_unit_id := inuOperUnitId;
            -- Cambia la orden a estado planeado
            or_boordertransition.changeStatus(rcOrder, or_boconstants.cnuORDER_ACTION_ASSIGN, or_boconstants.cnuORDER_STAT_PLANNED, false);
            daor_order.updRecord(rcOrder);
        else
            or_boprocessorder.ProcessOrder(rcOrder.order_id, null, inuOperUnitId);
        END if;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END AssignOrderAction;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('ASSIGNORDERACTION', 'ADM_PERSON');
END;
/
