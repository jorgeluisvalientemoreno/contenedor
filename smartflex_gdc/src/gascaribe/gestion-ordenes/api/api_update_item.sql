CREATE OR REPLACE PROCEDURE adm_person.api_update_item
(
	iclXMLItemsData		IN 		CLOB,
	onuErrorCode 		OUT 	ge_message.message_id%TYPE,
	osbErrorMessage 	OUT 	ge_error_log.description%TYPE
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : api_update_item
    Descripcion     : Api para realizar la actualizacion de un item
    Autor           : Carlos Gonzalez
    Fecha           : 28-08-2023
    
	Parametros de Entrada
		iclXMLItemsData 			XML con la siguiente estructura
									<?xml version="1.0" encoding="Windows-1252" ?>
									<UPDATE_ITEM>
										<ITEM_CODE></ITEM_CODE>
										<ITEM_ID></ITEM_ID>
										<DESCRIPTION></DESCRIPTION>
										<MEASURE_UNIT></MEASURE_UNIT>
										<CONCEPT></CONCEPT>
										<DISCOUNT_CONCEPT></DISCOUNT_CONCEPT>
										<PROVISION_TYPE></PROVISION_TYPE>
										<PLATAFORM></PLATAFORM>
										<IS_RECOVERY></IS_RECOVERY>
										<RECOVERY_ITEM></RECOVERY_ITEM>
										<ITEMS_GAMA></ITEMS_GAMA>
										<INIT_STATUS></INIT_STATUS>
										<OBSOLETE></OBSOLETE>
									</UPDATE_ITEM>

    Parametros de Salida
		onuErrorCode      			Codigo de error
		osbErrorMessage   			Mensaje de error
    
	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    cgonzalez   28/08/2023      OSF-1476: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_update_item';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);
	
	os_update_item
	(
		iclXMLItemsData,
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
  pkg_utilidades.prAplicarPermisos('API_UPDATE_ITEM', 'ADM_PERSON');
end;
/