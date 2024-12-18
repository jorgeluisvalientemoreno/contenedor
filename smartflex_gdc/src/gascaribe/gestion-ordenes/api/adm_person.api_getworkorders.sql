create or replace PROCEDURE adm_person.api_getworkorders
(
 inuOperatingUnitId 	in or_order.operating_unit_id%type, 
 inuGeograLocationId 	in or_order.geograp_location_id%type, 
 inuConsCycleId 		in ciclcons.cicocodi%type, 
 inuOperatingSectorId 	in or_order.operating_sector_id%type, 
 inuRouteId 			in or_order.route_id%type, 
 idtInitialDate 		in or_order.created_date%type, 
 idtFinalData 			in or_order.created_date%type, 
 inuTaskTypeId 			in or_order.task_type_id%type, 
 inuOrderStatusId 		in or_order.order_status_id%type, 
 orfOrder 				out constants_per.tyrefcursor, 
 onuErrorCode 			out ge_error_log.message_id%type, 
 osbErrorMessage 		out ge_error_log.description%type
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe

	Programa        : API_GETWORKORDERS
    Descripcion     : Permite recuperar en un cursor referenciado información relacionada a orden de trabajo
    Autor           : Jhon Jairo Soto (Horbath)
    Fecha           : 08-09-2023

	Parametros de Entrada
     inuOperatingUnitId 	Unidad Operativa
    inuGeograLocationId 	Ubicación geográfica
    inuConsCycleId 		    Ciclo de Consumo, 
    inuOperatingSectorId 	Sector Operativo, 
    inuRouteId 			    Ruta 
    idtInitialDate 		    Fecha Inicial (Creacion)
    idtFinalData 			Fecha Final (Creación), 
    inuTaskTypeId 			Tipo de trabajo
    inuOrderStatusId 		Estado de la orden, 

    Parametros de Salida
    orfOrder 			Cursor Referenciado 
	onuErrorCode      	Codigo de error
	osbErrorMessage   	Mensaje de error

	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    Jsoto       08/09/2023      OSF-1540: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_getworkorders';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);

	os_getworkorders
	(
		inuOperatingUnitId, 
		inuGeograLocationId, 
		inuConsCycleId, 
		inuOperatingSectorId, 
		inuRouteId, 
		idtInitialDate, 
		idtFinalData, 
		inuTaskTypeId, 
		inuOrderStatusId, 
		orfOrder, 
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
  pkg_utilidades.prAplicarPermisos('API_GETWORKORDERS', 'ADM_PERSON');
end;
/