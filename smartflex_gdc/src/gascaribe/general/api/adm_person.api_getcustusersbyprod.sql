CREATE OR REPLACE PROCEDURE adm_person.api_getcustusersbyprod
(
	inuProductId 		IN 	pr_subs_type_prod.product_id%TYPE,
    isbServiceNumber 	IN 	pr_product.service_number%TYPE,
    inuRoleId 			IN 	pr_subs_type_prod.role_id%TYPE,
    orfCustUserData 	OUT constants_per.tyrefcursor,
    onuErrorCode        OUT ge_error_log.message_id%TYPE,
    osbErrorMessage 	OUT ge_error_log.description%TYPE
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : api_getcustusersbyprod
    Descripcion     : Api para consultar informacion de usuarios asociados a producto
    Autor           : Carlos Andres Gonzalez (Horbath)
    Fecha           : 05-09-2023
    
	Parametros de Entrada
		inuProductId 		Producto
		isbServiceNumber    Numero de Servicio
		inuRoleId    		Identificador del rol

    Parametros de Salida
		orfCustUserData 	Datos de los usuarios
							SUBS_TYPE_PROD_ID
							PRODUCT_ID
							SUBSCRIBER_ID
							ROLE_ID
							LAST_UPDATE
							ROLE_DESC

		onuErrorCode      	Codigo de error
		osbErrorMessage   	Mensaje de error
    
	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    cgonzalez   05/09/2023      OSF-1527: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_getcustusersbyprod';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);
	
	os_getcustusersbyprod
	(
		inuProductId,
		isbServiceNumber,
		inuRoleId,
		orfCustUserData,
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
  pkg_utilidades.prAplicarPermisos('API_GETCUSTUSERSBYPROD', 'ADM_PERSON');
end;
/