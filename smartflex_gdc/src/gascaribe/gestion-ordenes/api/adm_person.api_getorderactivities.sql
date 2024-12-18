create or replace PROCEDURE adm_person.api_getorderactivities
(
	inuOrderId 			IN 	OR_ORDER.ORDER_ID%TYPE,
	orfReadActivities	OUT constants_per.tyrefcursor,
	onuErrorCode 		OUT NUMBER,
	osbErrorMessage 	OUT VARCHAR2
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe

	Programa        : API_GETORDERACTIVITIES
    Descripcion     : Permite recuperar en un cursor referenciado información relacionada a actividades de la orden
    Autor           : Jhon Jairo Soto (Horbath)
    Fecha           : 08-09-2023

	Parametros de Entrada
		inuOrderId Identificador de la Orden

    Parametros de Salida
		orfReadActivities	Cursor referenciado con informacion de actividades de la orden
		onuErrorCode      	Codigo de error
		osbErrorMessage   	Mensaje de error

	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    Jsoto       08/09/2023      OSF-1540: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_getorderactivities';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);

	os_getorderactivities
	(
		inuOrderId,
		orfReadActivities,
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
  pkg_utilidades.prAplicarPermisos('API_GETORDERACTIVITIES', 'ADM_PERSON');
end;
/