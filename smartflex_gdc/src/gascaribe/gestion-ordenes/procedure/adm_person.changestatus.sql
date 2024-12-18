create or replace PROCEDURE adm_person.changestatus (
    iorcorder        IN OUT NOCOPY daor_order.styor_order,
    inufinalstatusid IN or_order.order_status_id%TYPE,
    inucommtypeid    IN or_order_comment.comment_type_id%TYPE,
    isbcomment       IN or_order_comment.order_comment%TYPE
)
    IS
/***************************************************************************
   Historia de Modificaciones
   Autor       Fecha        Descripcion.
   Adrianavg   20/05/2024   OSF-2673: Migrar del esquema OPEN al esquema ADM_PERSOM
   ***************************************************************************/
    
        rcStatChange    daor_order_stat_change.styOr_order_stat_change;
        rcOrderComment  daor_order_comment.styOR_order_comment;
        cnuOrderExec    OR_order_status.order_status_id%type := Or_BoConstants.cnuORDER_STAT_EXECUTING;

    BEGIN


        ut_trace.trace('INICIA -  OR_BOAdminOrder.ChangeStatus'||chr(10)||
                       '  orden ['||iorcOrder.order_id||']'||chr(10)||
                       '  inuFinalStatusId ['||inuFinalStatusId||']',15);



        -- Inserta registro en or_order_stat_change
        rcStatChange.order_stat_change_id  := or_bosequences.fnuNextOr_Order_Stat_Change;
        rcStatChange.initial_status_id := iorcOrder.order_status_id;
        rcStatChange.final_status_id := inuFinalStatusId;
        rcStatChange.order_id := iorcOrder.order_id;
        rcStatChange.stat_chg_date := sysdate;
        rcStatChange.user_id := ut_session.getUSER;
        rcStatChange.terminal := ut_session.getTERMINAL;
        rcStatChange.comment_type_id := inuCommTypeId;
        rcStatChange.execution_date := iorcOrder.exec_estimate_date;
        rcStatChange.initial_oper_unit_id := iorcOrder.operating_unit_id;
        rcStatChange.programing_class_id := iorcOrder.programing_class_id;
        rcStatChange.range_description := null;


        IF (inuFinalStatusId = OR_BOConstants.cnuORDER_STAT_CANCELED) THEN
            rcStatChange.execution_date := null;
            rcStatChange.programing_class_id := null;
            rcStatChange.action_id := OR_boconstants.cnuORDER_ACTION_CANCEL;
        ELSIF inuFinalStatusId = OR_BOConstants.cnuORDER_STAT_EXECUTED THEN
            rcStatChange.action_id := OR_boconstants.cnuORDER_ACTION_EXECUT;
        ELSIF inuFinalStatusId = OR_BOConstants.cnuORDER_STAT_CLOSED THEN
            rcStatChange.action_id := OR_boconstants.cnuORDER_ACTION_CLOSE;
        ELSIF (rcStatChange.initial_status_id = cnuOrderExec AND
               inuFinalStatusId = OR_BOConstants.cnuORDER_STAT_ASSIGNED) THEN
             rcStatChange.action_id := OR_boconstants.cnuORDER_ACTION_POSTPONE;
        ELSIF (rcStatChange.initial_status_id = OR_BOConstants.cnuORDER_STAT_REGISTERED AND
                inuFinalStatusId = OR_BOConstants.cnuORDER_STAT_ASSIGNED) THEN
                rcStatChange.initial_oper_unit_id := null;
                rcStatChange.action_id := OR_boconstants.cnuORDER_ACTION_ASSIGN;
        ELSIF (inuFinalStatusId = cnuOrderExec) THEN
            rcStatChange.action_id := OR_boconstants.cnuORDER_ACTION_NOTIFY;
        ELSIF (inuFinalStatusId = or_boconstants.cnuORDER_STAT_REGISTERED) THEN
            rcStatChange.execution_date := null;
            rcStatChange.programing_class_id := null;
            rcStatChange.action_id := OR_boconstants.cnuORDER_ACTION_UNPROG;
        END IF;

        -- Evalua si debe insertar en OR_ORDER_COMMENT
        IF (inuCommTypeId IS NOT NULL) THEN
            -- Inserta registro en OR_order_comment
            rcOrderComment.order_comment_id := or_bosequences.fnuNextOr_Order_Comment;
            rcOrderComment.order_comment := isbComment;
            rcOrderComment.order_id := iorcOrder.order_id;
            rcOrderComment.comment_type_id := inuCommTypeId;
            rcOrderComment.register_date := ut_date.fdtSysdate;
            rcOrderComment.legalize_comment := GE_BOConstants.csbNO;
            rcOrderComment.person_id := ge_boPersonal.fnuGetPersonId;

            daor_order_comment.insRecord(rcOrderComment);
        END IF;

        -- Si el estado final es 12 - Anulada ú 8 - Cerrada
        IF (inuFinalStatusId = or_boconstants.cnuORDER_STAT_CANCELED) OR
           (inuFinalStatusId = or_boconstants.cnuORDER_STAT_CLOSED) THEN

            iorcOrder.legalization_date := ut_date.fdtsysdate;

            -- Actualiza a NULL el campo ADM_PENDING
            iorcOrder.adm_pending := NULL;

            -- Actualiza el estado de la actividad asociada a la orden administrativa.
            ut_trace.Trace('Actualizo estado de la actividad asociada a la orden ['|| iorcOrder.order_id||'] - ',15);
            ut_trace.Trace('Estado: '||or_boconstants.csbFinishStatus,15);
            or_bcorderactivities.updStatusActivityByOrder
            (
                iorcOrder.order_id,
                or_boconstants.csbFinishStatus
            );

        ELSIF (inuFinalStatusId = OR_BOConstants.cnuORDER_STAT_EXECUTED) THEN
            iorcOrder.legalization_date := ut_date.fdtsysdate;
        ELSIF (inuFinalStatusId = OR_BOConstants.cnuORDER_STAT_ASSIGNED) THEN
            iorcOrder.exec_initial_date := NULL;
            iorcOrder.assigned_date := ut_date.fdtsysdate;
        ELSIF (inuFinalStatusId = cnuOrderExec) THEN
            iorcOrder.exec_initial_date := ut_date.fdtsysdate;
        ELSIF (inuFinalStatusId = or_boconstants.cnuORDER_STAT_REGISTERED) THEN
            iorcOrder.exec_initial_date := NULL;
            iorcOrder.assigned_date := NULL;
            iorcOrder.legalization_date := NULL;
            iorcOrder.operating_unit_id := NULL;
        END IF;

        -- Actualiza el registro de la orden
        iorcOrder.order_status_id := inuFinalStatusId;

        ut_trace.Trace('Se actualiza orden ['||iorcOrder.order_id||'] a estado ['||iorcOrder.order_status_id||']',15);
        daor_order.updRecord(iorcOrder);

         rcStatChange.final_oper_unit_id := iorcOrder.operating_unit_id;

        daor_order_stat_change.insrecord(rcStatChange);

        ut_trace.trace('FIN -  OR_BOAdminOrder.ChangeStatus',15);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ChangeStatus;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre CHANGESTATUS
BEGIN
    pkg_utilidades.prAplicarPermisos('CHANGESTATUS', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REXEREPORTES sobre CHANGESTATUS
GRANT EXECUTE ON ADM_PERSON.CHANGESTATUS TO REXEREPORTES;
/