CREATE OR REPLACE PROCEDURE adm_person.api_getbranchbyaddress
(
	inuAddressId 		IN 	ab_address.address_id%TYPE,
	inuDistance 		IN  NUMBER,
	inuAmount  			IN  NUMBER,
    orfEntity 			OUT constants_per.tyrefcursor,
	onuErrorCode 		OUT ge_error_log.error_log_id%TYPE,
	osbErrorMessage 	OUT ge_error_log.description%TYPE
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : api_getbranchbyaddress
    Descripcion     : Api para consultar puntos de pago cercanos a direccion
    Autor           : Carlos Andres Gonzalez (Horbath)
    Fecha           : 05-09-2023
    
	Parametros de Entrada
		inuAddressId 		Identificador de la direccion
		inuDistance   		Distancia en metros para buscar entidades cercanas
		inuAmount			Cantidad de entidades a retornar
		
    Parametros de Salida
		orfEntity 			Cursor con informacion de las entidades cercanas
							SUCUBANC.SUBABANC
							BANCO.BANCNOMB
							SUCUBANC.SUBACODI
							SUCUBANC.SUBANOMB
							SUCUBANC.SUBAADID
							AB_ADDRESS.ADDRESS_PARSED
							SUCUBANC.SUBACOPO 
							SUCUBANC.SUBATELE
							SUCUBANC.SUBASIST

		onuErrorCode      	Codigo de error
		osbErrorMessage   	Mensaje de error
    
	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    cgonzalez   05/09/2023      OSF-1527: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_getbranchbyaddress';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);
	
	os_getbranchbyaddress
	(
		inuAddressId,
		inuDistance,
		inuAmount,
		orfEntity,
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
  pkg_utilidades.prAplicarPermisos('API_GETBRANCHBYADDRESS', 'ADM_PERSON');
end;
/