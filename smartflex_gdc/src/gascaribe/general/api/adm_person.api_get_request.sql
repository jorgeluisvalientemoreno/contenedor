CREATE OR REPLACE PROCEDURE adm_person.api_get_request
(
	inuItemsDocument_Id IN 	ge_items_request.id_items_documento%TYPE,
	osbRequest 			OUT CLOB,
	onuErrorCode 		OUT NUMBER,
	osbErrorMessage 	OUT VARCHAR2
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : api_get_request
    Descripcion     : Api para consultar informacion de una solicitud
    Autor           : Carlos Andres Gonzalez (Horbath)
    Fecha           : 08-09-2023
    
	Parametros de Entrada
		inuItemsDocument_Id Identificador de la solicitud
		
    Parametros de Salida
		osbRequest	 		XML con informacion del cursor
		onuErrorCode      	Codigo de error
		osbErrorMessage   	Mensaje de error
    
	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    cgonzalez   08/09/2023      OSF-1540: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_get_request';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);
	
	os_get_request
	(
		inuItemsDocument_Id,
		osbRequest,
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
  pkg_utilidades.prAplicarPermisos('API_GET_REQUEST', 'ADM_PERSON');
end;
/