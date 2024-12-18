CREATE OR REPLACE PROCEDURE adm_person.api_updpaidcertif
(
	inuCertificateId 	IN 	ge_acta.id_acta%TYPE,
    idtPaymentDate 		IN 	ge_acta.extern_pay_date%TYPE,
    isbNumExterBill 	IN 	ge_acta.extern_invoice_num%TYPE,
    onuErrorCode        OUT ge_error_log.message_id%TYPE,
    osbErrorMessage 	OUT ge_error_log.description%TYPE
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : api_updpaidcertif
    Descripcion     : Api para actualizar el acta a pagada
    Autor           : Carlos Andres Gonzalez (Horbath)
    Fecha           : 06-09-2023
    
	Parametros de Entrada
		inuCertificateId 	Identificador del acta
		idtPaymentDate    	Fecha en que se pago el acta
		isbNumExterBill    	Numero de factura externa

    Parametros de Salida
		onuErrorCode      	Codigo de error
		osbErrorMessage   	Mensaje de error
    
	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    cgonzalez   06/09/2023      OSF-1543: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_updpaidcertif';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);
	
	os_updpaidcertif
	(
		inuCertificateId,
		idtPaymentDate,
		isbNumExterBill,
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
	pkg_utilidades.prAplicarPermisos('API_UPDPAIDCERTIF', 'ADM_PERSON');
end;
/