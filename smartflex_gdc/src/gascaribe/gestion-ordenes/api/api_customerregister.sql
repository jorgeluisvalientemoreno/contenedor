CREATE OR REPLACE PROCEDURE adm_person.api_customerregister
(
	ionuSubscriber_id 		IN OUT 	ge_subscriber.subscriber_id%TYPE,
	inuIdent_type_id 		IN 		ge_subscriber.ident_type_id%TYPE,
	isbIdentification 		IN 		ge_subscriber.identification%TYPE,
	inuParent_subscriber_id IN 		ge_subscriber.parent_subscriber_id%TYPE,
	inuSubscriber_type_id 	IN 		ge_subscriber.subscriber_type_id%TYPE,
	isbAddress 				IN 		ge_subscriber.address%TYPE,
	isbPhone 				IN 		ge_subscriber.phone%TYPE,
	isbSubscriber_name 		IN 		ge_subscriber.subscriber_name%TYPE,
	isbSubs_last_name 		IN 		ge_subscriber.subs_last_name%TYPE,
	isbE_mail 				IN 		ge_subscriber.e_mail%TYPE,
	isbUrl 					IN 		ge_subscriber.url%TYPE,
	isbContact_phone 		IN 		ge_subscriber.phone%TYPE,
	isbContact_address 		IN 		ge_subscriber.address%TYPE,
	isbContact_name 		IN 		ge_subscriber.subscriber_name%TYPE,
	inuContact_ident_type 	IN 		ge_subscriber.ident_type_id%TYPE,
	isbContact_ident 		IN 		ge_subscriber.identification%TYPE,
	inuMarketing_segment_id IN 		ge_subscriber.marketing_segment_id%TYPE,
	inuSubs_status_id 		IN 		ge_subscriber.subs_status_id%TYPE,
	isbSex 					IN 		ge_subs_general_data.gender%TYPE,
	idtBirthdate 			IN 		ge_subs_general_data.date_birth%TYPE,
	onuErrorCode 			OUT 	ge_message.message_id%TYPE,
	osbErrorMessage 		OUT 	VARCHAR2
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : api_customerregister
    Descripcion     : Api para realizar el registro de un cliente
    Autor           : Carlos Gonzalez
    Fecha           : 25-08-2023
    
	Parametros de Entrada
		ionuSubscriber_id 			Codigo del cliente
		inuIdent_type_id 			Tipo de identificacion
		isbIdentification 			Numero de Identificacion
		inuParent_subscriber_id 	Identificador del cliente padre
		inuSubscriber_type_id 		Tipo de cliente
		isbAddress 					Direccion del cliente
		isbPhone 					Numero telefonico
		isbSubscriber_name 			Nombre del cliente
		isbSubs_last_name 			Apellido del cliente
		isbE_mail 					Correo electronico
		isbUrl 						Url
		isbContact_phone 			Telefono de contacto
		isbContact_address 			Direccion de contacto
		isbContact_name 			Nombre de contacto
		inuContact_ident_type 		Tipo de identificacion de contacto
		isbContact_ident 			Numero de identificacion de contacto
		inuMarketing_segment_id 	Segmento de marketing
		inuSubs_status_id 			Estado del cliente
		isbSex 						Genero
		idtBirthdate 				Fecha de nacimiento
		
    Parametros de Salida
		ionuSubscriber_id 			Codigo del cliente
		onuErrorCode      			Codigo de error
		osbErrorMessage   			Mensaje de error
    
	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    cgonzalez   25/08/2023      OSF-1476: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_customerregister';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);
	
	os_customerregister
	(
		ionuSubscriber_id,
		inuIdent_type_id,
		isbIdentification,
		inuParent_subscriber_id,
		inuSubscriber_type_id,
		isbAddress,
		isbPhone,
		isbSubscriber_name,
		isbSubs_last_name,
		isbE_mail,
		isbUrl,
		isbContact_phone,
		isbContact_address,
		isbContact_name,
		inuContact_ident_type,
		isbContact_ident,
		inuMarketing_segment_id,
		inuSubs_status_id,
		isbSex,
		idtBirthdate,
		onuErrorCode,
		osbErrorMessage
	);
	
	ut_trace.trace('ionuSubscriber_id: '||ionuSubscriber_id, 10);
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
  pkg_utilidades.prAplicarPermisos('API_CUSTOMERREGISTER', 'ADM_PERSON');
end;
/