CREATE OR REPLACE PROCEDURE adm_person.api_coupongeneration
(
	inuRefType      	IN  NUMBER,
    isbXMLReference 	IN  CLOB,
    onuCupoNume     	OUT cupon.cuponume%TYPE,
    onuTotalValue   	OUT NUMBER,
    onuErrorCode        OUT ge_error_log.message_id%TYPE,
    osbErrorMessage 	OUT ge_error_log.description%TYPE
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : api_coupongeneration
    Descripcion     : Api para generar cupon desde XML
    Autor           : Carlos Andres Gonzalez (Horbath)
    Fecha           : 01-09-2023
    
	Parametros de Entrada
		inuRefType 			Tipo de Referencia
							1: Cupón Pago Agrupador (CA)
							2: Cupón Pago Suscripción (FA)
							3: Cupón Pago Factura (AF)
							4: Cupón Pago Producto (CC)
							5: Cupón de Negociación (NG)

		isbXMLReference    	Estructura XML de acuerdo al tipo de referencia
							1: Cupón Pago Agrupador (CA) 
							<?xml version="1.0" encoding="utf-8" ?>
							<Productos>
								<Datos>
									<Id_Producto></Id_Producto>
									<Valor_a_Pagar></ Valor_a_Pagar >
								</Datos>
								<Datos>
									<Id_Producto></Id_Producto>
									<Valor_a_Pagar></ Valor_a_Pagar >
								</Datos>
							</Productos>
							
							2: Cupón Pago Suscripción (FA)
							<?xml version="1.0" encoding="utf-8" ?>
							<Suscripcion>
								<Id_Suscripcion></Id_Suscripcion>
								<Valor_a_Pagar></ Valor_a_Pagar >
							</Suscripcion >
							
							3: Cupón Pago Factura (AF)
							<?xml version="1.0" encoding="utf-8" ?>
							<Factura>
								<Id_Factura></Id_Factura>
								<Valor_a_Pagar></ Valor_a_Pagar >
							</Factura >
						
							4: Cupón Pago Producto (CC) 
							<?xml version="1.0" encoding="utf-8" ?>
							<Producto>
								<Id_Producto ></Id_Producto>
								<Valor_a_Pagar></ Valor_a_Pagar >
							</Producto >
							
							5: Cupón de Negociación (NG) 
							<?xml version="1.0" encoding="utf-8" ?>
							<Negociacion>
								< Id_Negociacion></ Id_Negociacion>
							</Negociacion>

    Parametros de Salida
		onuCupoNume 		Numero del cupon generado
		onuTotalValue 		Valor total a pagar
		onuErrorCode      	Codigo de error
		osbErrorMessage   	Mensaje de error
    
	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    cgonzalez   01/09/2023      OSF-1511: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_coupongeneration';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);
	
	os_coupongeneration
	(
		inuRefType,
		isbXMLReference,
		onuCupoNume,
		onuTotalValue,
		onuErrorCode,
		osbErrorMessage
	);
	
	ut_trace.trace('onuCupoNume: '||onuCupoNume, 10);
	ut_trace.trace('onuTotalValue: '||onuTotalValue, 10);
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
  pkg_utilidades.prAplicarPermisos('API_COUPONGENERATION', 'ADM_PERSON');
end;
/