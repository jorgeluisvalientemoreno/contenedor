create or replace PROCEDURE adm_person.api_get_requests_reg
(
	inuOpeUnitErp_Id IN 	or_operating_unit.operating_unit_id%TYPE,
	osbRequestsRegs		OUT CLOB,
	onuErrorCode 		OUT NUMBER,
	osbErrorMessage 	OUT VARCHAR2
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe

	Programa        : api_get_requests_reg
    Descripcion     : Api para consultar Solicitudes de Items realizadas a sistema externo
    Autor           : Jhon Jairo Soto (Horbath)
    Fecha           : 08-09-2023

	Parametros de Entrada
		inuOpeUnitErp_Id Identificador de la Unidad Operativa

    Parametros de Salida
		osbRequestsRegs		XML con informacion del cursor
		onuErrorCode      	Codigo de error
		osbErrorMessage   	Mensaje de error

	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    Jsoto       08/09/2023      OSF-1540: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_get_requests_reg';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);

	os_get_requests_reg
	(
		inuOpeUnitErp_Id,
		osbRequestsRegs,
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
  pkg_utilidades.prAplicarPermisos('API_GET_REQUESTS_REG', 'ADM_PERSON');
end;
/