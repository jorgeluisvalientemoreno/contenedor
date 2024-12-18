CREATE OR REPLACE PROCEDURE adm_person.api_getsubscripbalance
(
	inuSubscriptionId  	IN  suscripc.susccodi%TYPE,
    inuProductType     	IN  servicio.servcodi%TYPE,
    onuOutStandBalance 	OUT cuencobr.cucosacu%TYPE,
    onuDeferredBalance 	OUT diferido.difesape%TYPE,
    onuExpiredBalance  	OUT cuencobr.cucosacu%TYPE,
    onuExpiredPeriods  	OUT NUMBER,
	onuErrorCode 		OUT ge_error_log.error_log_id%TYPE,
	osbErrorMessage 	OUT ge_error_log.description%TYPE
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : api_getsubscripbalance
    Descripcion     : Api para obtener saldos pendientes asociados al contrato
    Autor           : Carlos Andres Gonzalez (Horbath)
    Fecha           : 01-09-2023
    
	Parametros de Entrada
		inuSubscriptionId 	Contrato
		inuProductType     	Tipo de Producto
		
    Parametros de Salida
		onuOutStandBalance 	Saldo pendiente corriente
		onuDeferredBalance 	Saldo pendiente diferido
		onuExpiredBalance  	Saldo vencido
		onuExpiredPeriods  	Numero de periodos de facturacion vencidos
		onuErrorCode      	Codigo de error
		osbErrorMessage   	Mensaje de error
    
	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    cgonzalez   01/09/2023      OSF-1511: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_getsubscripbalance';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);
	
	os_getsubscripbalance
	(
		inuSubscriptionId,
		inuProductType,
		onuOutStandBalance,
		onuDeferredBalance,
		onuExpiredBalance,
		onuExpiredPeriods,
		onuErrorCode,
		osbErrorMessage
	);
	
	ut_trace.trace('onuOutStandBalance: '||onuOutStandBalance, 10);
	ut_trace.trace('onuDeferredBalance: '||onuDeferredBalance, 10);
	ut_trace.trace('onuExpiredBalance: '||onuExpiredBalance, 10);
	ut_trace.trace('onuExpiredPeriods: '||onuExpiredPeriods, 10);
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
  pkg_utilidades.prAplicarPermisos('API_GETSUBSCRIPBALANCE', 'ADM_PERSON');
end;
/