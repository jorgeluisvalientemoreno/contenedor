CREATE OR REPLACE PROCEDURE adm_person.api_obtenercostoitemlista 
(
    inuIdItem               IN ge_unit_cost_ite_lis.items_id%type,
    inuFechaAssignacion     IN or_order.assigned_date%type,
    inuGeolocationId        IN ge_list_unitary_cost.geograp_location_id%type,
    inuContratista          IN ge_list_unitary_cost.contractor_id%type,
    inuUnidadOper           IN ge_list_unitary_cost.operating_unit_id%type,
    inuContract             IN ge_list_unitary_cost.contract_id%type,
    onuIdListaCosto         OUT ge_unit_cost_ite_lis.list_unitary_cost_id%type,
    onuCostoItem            OUT ge_unit_cost_ite_lis.price%type,
    onuPrecioVentaItem      OUT ge_unit_cost_ite_lis.sales_value%type,
    onuErrorCode 	        OUT ge_message.message_id%TYPE, 
    osbErrorMessage 	    OUT ge_error_log.description%TYPE 
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : api_obtenercostoitemlista
    Descripcion     : Api para obtener costo de un item de acuerdo a los parametros de entrada
    Autor           : Jhon Soto (Horbath)
    Fecha           : 12-09-2023
    
	Parametros de Entrada
    inuIdItem               Id del Item
    inuFechaAssignacion     Fecha Asignación de la Orden
    inuGeolocationId        ID de Ubicación Geográfica
    inuContratista          Id de Contratista
    inuUnidadOper           Id de Unidad Operativa
    inuContract             Id de Contrato
		
    Parametros de Salida
    onuIdListaCosto         Retorna ID de Lista de Costo
    onuCostoItem            Retorna costo del item
    onuPrecioVentaItem      Retorna Precio Venta Item
    onuErrorCode      	    Codigo de error
    osbErrorMessage   	    Mensaje de error

    
	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    jsoto       12/09/2023      OSF-1466: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_obtenercostoitemlista';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);
	
	GE_BCCERTCONTRATISTA.OBTENERCOSTOITEMLISTA
	(
     inuIdItem,
     inuFechaAssignacion,
     inuGeolocationId,
     inuContratista,
     inuUnidadOper,
     inuContract, 
     onuIdListaCosto,
     onuCostoItem,
     onuPrecioVentaItem
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
  pkg_utilidades.prAplicarPermisos('API_OBTENERCOSTOITEMLISTA', 'ADM_PERSON');
end;
/