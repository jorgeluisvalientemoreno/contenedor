create or replace procedure adm_person.api_subscriptionregister(inuCliente 			IN Number,
																inuCicloFactura 	IN Number,
																isbTipoDirecCobro	IN Varchar2,
																inuDireccionCobro 	IN Number,
																onuSuscripcion 		OUT Number,
																onuErrorCode 		OUT Number,
																osbErrorMessage 	OUT varchar
																)										 
IS
/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	
    Programa        : api_subscriptionregister
    Descripcion     : Api para registrar un contrato.
    Autor           : Jhon Eduar Erazo Guchavez
    Fecha           : 12-07-2023
	 
    Parametros de Entrada
		inuCliente          Código del cliente
		inuCicloFactura     Código del ciclo de facturación
		isbTipoDirecCobro	Tipo de dirección de cobro
		inuDireccionCobro	Código de la dirección de cobro
    
	Parametros de Salida
		onuSuscripcion		Código del contrato creado
		onuErrorCode        Código de error
		osbErrorMessage     Mensaje de error
		
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
	jerazoer	12-07-2023		Creación
***************************************************************************/
BEGIN

	ut_trace.trace('Inicio api_subscriptionregister ' 				|| chr(10) ||
					'inuCliente: ' 			|| inuCliente 			|| chr(10) ||
					'inuCicloFactura: ' 	|| inuCicloFactura 		|| chr(10) ||
					'isbTipoDirecCobro: '	|| isbTipoDirecCobro	|| chr(10) ||
					'inuDireccionCobro: ' 	|| inuDireccionCobro, 2);

	OS_SUBSCRIPTIONREGISTER(onuSuscripcion, 	-- IONUSUBSCRIPTION_ID
							inuCliente, 		-- INUSUBSCRIBER_ID
							-1, 				-- INUSUBSCRIPTION_TYPE
							'CO', 				-- ISBMONEY_TYPE
							inuCicloFactura, 	-- INUBILLING_CYCLE_ID
							isbTipoDirecCobro,	-- ISBADDRESSTYPECODE
							NULL, 				-- INUBANK
							NULL, 				-- INUBRANCH
							NULL, 				-- ISBBANKACCOUNT
							NULL, 				-- INUBANKACCOUNTTYPE
							inuDireccionCobro, 	-- INUCOLLECTADDRESSID
							NULL, 				-- IDTCREDITCARDEXPIREDAT
							NULL, 				-- ISBCARDTYPE
							NULL, 				-- INUCOMPANYID
							onuErrorCode, 		-- ONUERRORCODE
							osbErrorMessage		-- OSBERRORMESSAGE
							);
							
	ut_trace.trace('Termina api_subscriptionregister ' 		|| chr(10) ||
					'onuSuscripcion: ' 	|| onuSuscripcion	|| chr(10) ||
					'onuErrorCode: ' 	|| onuErrorCode 	|| chr(10) ||
					'osbErrorMessage: '	|| osbErrorMessage, 3);
							

EXCEPTION

WHEN PKG_ERROR.CONTROLLED_ERROR THEN
	ut_trace.trace('PKG_ERROR.CONTROLLED_ERROR api_subscriptionregister', 4);
	pkg_Error.setError;
	pkg_error.getError(onuErrorCode, osbErrorMessage);
WHEN OTHERS THEN
	ut_trace.trace('OTHERS api_subscriptionregister', 4);
	pkg_Error.SETERROR;
	pkg_error.getError(onuErrorCode, osbErrorMessage);

END api_subscriptionregister;
/
BEGIN

	pkg_utilidades.prAplicarPermisos('API_SUBSCRIPTIONREGISTER', 'ADM_PERSON'); 

END;
/