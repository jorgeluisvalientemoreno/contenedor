CREATE OR REPLACE PROCEDURE ADM_PERSON.LD_LEGALIZE
(
        inuOrderId        in  or_order.order_id%type,
        inuCausalId       in  Or_Order.Causal_Id%type,
        inuPersonId       in  Ge_Person.Person_Id%type,
        idtExeInitialDate in  Or_Order.Exec_Initial_Date%type,
        idtExeFinalDate   in  Or_Order.Execution_Final_Date%type,
        onuErrorCode      out number,
        osbErrorMessage   out varchar2
)
IS
        nuTaskTypeId    OR_task_type.task_type_id%type;
        nuPersonId    Ge_Person.Person_Id%type;
        dtExeInitialDate  Or_Order.Exec_Initial_Date%type;
        dtExeFinalDate  Or_Order.Execution_Final_Date%type;

BEGIN
        -- Lógica
        ut_trace.Trace('LD_LEGALIZE INICIO',1);

        -- Inicializa las variables de salida del servicio
        ge_boutilities.InitializeOutput(onuErrorCode, osbErrorMessage);

        -- Valida los argumentos de entrada
        nuPersonId   := inuPersonId;
        dtExeInitialDate := idtExeInitialDate;
        dtExeFinalDate := idtExeFinalDate;

    	OR_BOExternalLegalizeActivity.ValidateOrderDataLega
        (
            inuOrderId,
            inuCausalId,
            nuPersonId,
            dtExeInitialDate,
            dtExeFinalDate
        );

        -- Instancia los datos de la orden
        OR_BOFWLegalizeOrderUtil.InitInstanceData(inuorderId);

        -- Obtiene el tipo de trabajo
        nuTaskTypeId := daor_order.fnuGetTask_type_id(inuOrderId);

        --  Legaliza la orden
        or_bolegalizeactivities.LegalizeOrder(inuOrderId, nuPersonId,inuCausalId, dtExeInitialDate, dtExeFinalDate, nuTaskTypeId);

        -- Se elimina la instancia que fue creada para la evaluación
        Or_BOInstance.StopInstanceManager;

        ut_trace.Trace('LD_LEGALIZE FIN',1);


    EXCEPTION
		when ex.CONTROLLED_ERROR then
			Errors.getError(onuErrorCode, osbErrorMessage);
		when others then
			Errors.setError;
			Errors.getError(onuErrorCode, osbErrorMessage);
    END;
/

PROMPT Otorgando permisos de ejecucion a LD_LEGALIZE
BEGIN
  pkg_utilidades.prAplicarPermisos('LD_LEGALIZE','ADM_PERSON');
END;
/
