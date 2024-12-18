CREATE OR REPLACE PROCEDURE adm_person.api_getproductdata
(
	inuProductId  			IN  pr_product.product_id%TYPE,
    isbServiceNumber     	IN  pr_product.service_number%TYPE,
    inuSubscriptionId 		IN 	pr_product.subscription_id%TYPE,
	inuPremiseId 			IN 	ab_address.estate_number%TYPE,
	inuAddressId 			IN 	pr_product.address_id%TYPE,
	inuProductTypeId 		IN 	pr_product.product_type_id%TYPE,
	inuProductStatusId 		IN 	pr_product.product_status_id%TYPE,
	isbOnlyActiveProduct 	IN 	ps_product_status.is_active_product%TYPE, 
	orfProductData 			OUT constants_per.tyrefcursor,
	onuErrorCode 			OUT ge_error_log.error_log_id%TYPE,
	osbErrorMessage 		OUT ge_error_log.description%TYPE
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : api_getproductdata
    Descripcion     : Api para consultar datos del producto
    Autor           : Carlos Andres Gonzalez (Horbath)
    Fecha           : 05-09-2023
    
	Parametros de Entrada
		inuProductId 			Producto
		isbServiceNumber     	Numero de servicio
		inuSubscriptionId		Contrato
		inuPremiseId			Identificador del predio
		inuAddressId			Identificador de la direccion
		inuProductTypeId		Tipo de producto
		inuProductStatusId		Estado del producto
		isbOnlyActiveProduct	Productos activos Default Y = Si - N = No
		
    Parametros de Salida
		orfProductData 			Datos del producto
								PRODUCT_ID
								SUBSCRIPTION_ID
								PRODUCT_TYPE_ID
								DISTRIBUT_ADMIN_ID
								IS_PROVISIONAL
								PROVISIONAL_END_DATE
								PROVISIONAL_BEG_DATE
								PRODUCT_STATUS_ID
								SERVICE_NUMBER
								CREATION_DATE
								IS_PRIVATE
								RETIRE_DATE
								COMMERCIAL_PLAN_ID
								PERSON_ID
								CLASS_PRODUCT
								ROLE_WARRANTY
								CREDIT_LIMIT
								EXPIRATION_OF_PLAN
								INCLUDED_ID
								COMPANY_ID
								ORGANIZAT_AREA_ID
								ADDRESS_ID
								PERMANENCE
								SUBS_PHONE_ID
								CATEGORY_ID
								SUBCATEGORY_ID
								SUSPEN_ORD_ACT_ID
								COLLECT_DISTRIBUTE
								PRODUCT_TYPE_DESC
								DISTRIBUT_ADMIN_DESC
								PRODUCT_STATUS_DESC
								COMMERCIAL_PLAN_NAME
								COMPANY_DESC
								ORGANIZAT_AREA_DESC
								ADDRESS 
								CATEGORY_DESC
								SUBCATEGORY_DESC

		onuErrorCode			Codigo de error
		osbErrorMessage   		Mensaje de error
    
	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    cgonzalez   05/09/2023      OSF-1527: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_getproductdata';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);
	
	os_getproductdata
	(
		inuProductId,
		isbServiceNumber,
		inuSubscriptionId,
		inuPremiseId,
		inuAddressId,
		inuProductTypeId,
		inuProductStatusId, 
		isbOnlyActiveProduct,
		orfProductData,
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
  pkg_utilidades.prAplicarPermisos('API_GETPRODUCTDATA', 'ADM_PERSON');
end;
/