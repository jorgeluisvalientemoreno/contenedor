CREATE OR REPLACE PROCEDURE adm_person.api_getcustomerdata
(
	inuCustomerId 				IN 	ge_subscriber.subscriber_id%TYPE,
	inuIdentificationTypeId 	IN 	ge_subscriber.ident_type_id%TYPE,
	isbIdentification 			IN 	ge_subscriber.identification%TYPE,
	orfCustomerData 			OUT constants_per.tyrefcursor,
	onuErrorCode 				OUT ge_error_log.error_log_id%TYPE,
	osbErrorMessage 			OUT ge_error_log.description%TYPE
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : api_getcustomerdata
    Descripcion     : Api para consultar informacion del cliente
    Autor           : Carlos Andres Gonzalez (Horbath)
    Fecha           : 05-09-2023
    
	Parametros de Entrada
		inuCustomerId 				Cliente
		inuIdentificationTypeId   	Tipo de identificacion
		isbIdentification			Numero de identificacion
		
    Parametros de Salida
		orfCustomerData 	Cursor con informacion del cliente
							SUBSCRIBER_ID
							PARENT_SUBSCRIBER_ID
							IDENT_TYPE_ID
							IDENT_TYPE_DESC
							SUBSCRIBER_TYPE_ID
							SUBSCRIBER_TYPE_DESC
							IDENTIFICATION
							SUBSCRIBER_NAME
							SUBS_LAST_NAME
							SUBS_SECOND_LAST_NAME
							E_MAIL
							URL
							PHONE
							ACTIVE
							ECONMIC_ACTIVITY_ID
							ECONMIC_ACTIVITY_DESC
							EXONERATION_DOCUMENT
							SUBS_STATUS_ID
							SUBS_STATUS_DESC
							MARKETING_SEGMENT_ID
							MARKETING_SEGMENT_DESC
							CONTACT_ID
							COUNTRY_ID
							COUNTRY_DESC
							ADDRESS_ID
							ADDRESS
							DATA_SEND
							VINCULATE_DATE
							ACCEPT_CALL
							TAXPAYER_TYPE
							TAXPAYER_TYPE_DESC
							AUTHORIZATION_TYPE
							AUTHORIZATION_TYPE_DESC
							COLLECT_PROGRAM_ID
							COLLECT_PROGRAM_DESC
							COLLECT_ENTITY_ID
							COLLECT_ENTITY_DESC
							CATEGORY_ID
							CATEGORY_DESC
							DOC_DATE_OF_ISSUE
							DOC_PLACE_OF_ISSUE
							ADDR_NBHOOD_ID
							ADDR_NBHOOD
							ADDR_GEOG_LOCA_ID
							ADDR_GEOG_LOCA 
							DATE_BIRTH
							GENDER

		onuErrorCode      	Codigo de error
		osbErrorMessage   	Mensaje de error
    
	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    cgonzalez   05/09/2023      OSF-1527: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_getcustomerdata';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);
	
	os_getcustomerdata
	(
		inuCustomerId,
		inuIdentificationTypeId,
		isbIdentification,
		orfCustomerData,
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
  pkg_utilidades.prAplicarPermisos('API_GETCUSTOMERDATA', 'ADM_PERSON');
end;
/