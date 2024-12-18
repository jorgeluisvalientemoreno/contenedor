CREATE OR REPLACE PROCEDURE adm_person.api_getbasicdataorder
(
	inuOrderId 			IN 	or_order.order_id%TYPE,
	ocuOrder 			OUT constants_per.tyrefcursor,
	ocuOrderActivity 	OUT constants_per.tyrefcursor,
    onuErrorCode 		OUT ge_error_log.error_log_id%TYPE,
	osbErrorMessage 	OUT ge_error_log.description%TYPE
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : api_getbasicdataorder
    Descripcion     : Api para consultar informacion de la orden
    Autor           : Carlos Andres Gonzalez (Horbath)
    Fecha           : 06-09-2023
    
	Parametros de Entrada
		inuOrderId 			Identificador de la orden
		
    Parametros de Salida
		ocuOrder 			Cursor con informacion de la orden
							ORDERID
							ORDERSTATUS
							OPER_UNIT_ID
							OPER_SECTOR_ID
							ASSIGNED_DATE
							ARRANGEHOUR
							ASSIGNED_WITH
							CREATED_DATE
							EXECUTION_FINAL_DATE
							EXEC_ESTIMATE_DATE
							EXEC_INITIAL_DATE
							LEGALIZATION_DATE
							MAX_DATE_TO_LEGALIZE
							ASSO_UNIT_ID
							REAL_TASK_TYPE_ID
							TASK_TYPE_ID
							PRIORITY
		ocuOrderActivity 	Cursor con informacion de la actividad de la orden
							ACTIVITY_ID
							ADDRESS_ID
							ORDER_ACTIVITY_ID
							PACKAGE_ID
							ACTIVITY_STATUS
							TASK_TYPE_ID
							COMMENT_
							ELEMENT_ID
							MOTIVE_ID
							PROCESS_ID
							PRODUCT_ID
							REGISTER_DATE
							SUBSCRIBER_ID
							SUBSCRIPTION_ID
		
		onuErrorCode      	Codigo de error
		osbErrorMessage   	Mensaje de error
    
	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    cgonzalez   06/09/2023      OSF-1543: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_getbasicdataorder';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);
	
	os_getbasicdataorder
	(
		inuOrderId,
		ocuOrder,
		ocuOrderActivity,
		onuErrorCode,
		osbErrorMessage
	);
	
	ut_trace.trace('onuErrorCode: '||onuErrorCode, 10);
	ut_trace.trace('osbErrorMessage: '||osbErrorMessage, 10);
   
	ut_trace.trace('Fin '||csbMetodo, 10);
EXCEPTION
	WHEN pkg_Error.CONTROLLED_ERROR THEN
		pkg_Error.GETERROR(onuErrorCode, osbErrorMessage);
		ut_trace.trace('Fin CONTROLLED_ERROR '||csbMetodo||' '||osbErrorMessage, 10);
	WHEN OTHERS THEN
		pkg_Error.SETERROR;
		pkg_Error.GETERROR(onuErrorCode, osbErrorMessage);
		ut_trace.trace('Fin OTHERS '||csbMetodo||' '||osbErrorMessage, 10);
END;
/
begin
  pkg_utilidades.prAplicarPermisos('API_GETBASICDATAORDER', 'ADM_PERSON');
end;
/