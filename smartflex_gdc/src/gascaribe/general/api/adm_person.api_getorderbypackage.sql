CREATE OR REPLACE PROCEDURE adm_person.api_getorderbypackage
(
	inuPackageId 		IN 	mo_packages.package_id%TYPE,
	ocuOrders 			OUT constants_per.tyrefcursor,
	onuErrorCode 		OUT ge_error_log.error_log_id%TYPE,
	osbErrorMessage 	OUT ge_error_log.description%TYPE
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : api_getorderbypackage
    Descripcion     : Api para consultar ordenes asociadas a una solicitud
    Autor           : Carlos Andres Gonzalez (Horbath)
    Fecha           : 06-09-2023
    
	Parametros de Entrada
		inuPackageId		Identificador de la solicitud
		
    Parametros de Salida
		ocuOrders 			Cursor con informacion de las ordenes
							ORDER_ID
		onuErrorCode      	Codigo de error
		osbErrorMessage   	Mensaje de error
    
	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    cgonzalez   06/09/2023      OSF-1543: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_getorderbypackage';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);
	
	os_getorderbypackage
	(
		inuPackageId,
		ocuOrders,
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
  pkg_utilidades.prAplicarPermisos('API_GETORDERBYPACKAGE', 'ADM_PERSON');
end;
/