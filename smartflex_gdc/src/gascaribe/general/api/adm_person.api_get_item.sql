CREATE OR REPLACE PROCEDURE adm_person.api_get_item
(
	isbItemCode 		IN 	ge_items.code%TYPE,
	inuItemsId 			IN 	ge_items.items_id%TYPE,
	oclXMLItemsData 	OUT CLOB,
	onuErrorCode 		OUT ge_message.message_id%TYPE, 
	osbErrorMessage 	OUT ge_error_log.description%TYPE 
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : api_get_item
    Descripcion     : Api para consultar informacion basica de un item
    Autor           : Carlos Andres Gonzalez (Horbath)
    Fecha           : 07-09-2023
    
	Parametros de Entrada
		isbItemCode 		Codigo del item en texto
		inuItemsId			Identificador del item
		
    Parametros de Salida
		oclXMLItemsData 	Cursor con informacion de la orden
		onuErrorCode      	Codigo de error
		osbErrorMessage   	Mensaje de error
    
	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    cgonzalez   07/09/2023      OSF-1540: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_get_item';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);
	
	os_get_item
	(
		isbItemCode,
		inuItemsId,
		oclXMLItemsData,
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
  pkg_utilidades.prAplicarPermisos('API_GET_ITEM', 'ADM_PERSON');
end;
/