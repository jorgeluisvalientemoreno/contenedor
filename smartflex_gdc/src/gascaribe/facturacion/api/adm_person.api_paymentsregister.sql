CREATE OR REPLACE PROCEDURE adm_person.api_paymentsregister
(
	inuRefType      	IN  NUMBER,
    isbXMLReference 	IN  CLOB,
    isbXMLPayment     	IN 	CLOB,
    osbXMLCuopons   	OUT CLOB,
    onuErrorCode        OUT ge_error_log.message_id%TYPE,
    osbErrorMessage 	OUT ge_error_log.description%TYPE
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : api_paymentsregister
    Descripcion     : Api para registrar pagos desde XML
    Autor           : Carlos Andres Gonzalez (Horbath)
    Fecha           : 05-09-2023
    
	Parametros de Entrada
		inuRefType 			Tipo de Referencia
							1: Cupón
							2: Cliente
							3: Contrato
							4: Factura
							5: Numero de Servicio
							6: Elemento de Medicion
							7: Recargas

		isbXMLReference    	Estructura XML de acuerdo al tipo de referencia
							1: Cupón
							<xml version="1.0" encoding="utf-8">
								<Pago_Cupon>
									<Cupon></Cupon>
								</Pago_Cupon>
							</xml>
							
							2: Cliente
							<xml version="1.0" encoding="utf-8">
								<Pago_Cliente>
									<Tipo_Id></Tipo_Id>
									<Numero_Id></Numero_Id>
								</Pago_Cliente>
							</xml>
							
							3: Contrato
							<xml version="1.0" encoding="utf-8">
								<Pago_Contrato>
									<Cod_Contrato></Cod_Contrato>
								</Pago_Contrato>
							</xml>
						
							4: Factura
							<xml version="1.0" encoding="utf-8">
								<Pago_Factura>
									<Cod_Factura></Cod_Factura>
								</Pago_Factura>
							</xml>
							
							5: Numero de Servicio
							<xml version="1.0" encoding="utf-8">
								<Pago_No_Servicio>
									<No_Servicio></No_Servicio>
								</Pago_No_Servicio>
							</xml>
							
							6: Elemento de Medicion
							<xml version="1.0" encoding="utf-8">
								<Pago_Recarga>
									<Cod_ElemMedi></Cod_ElemMedi>
								</Pago_ Recarga>
							</xml>
							
							7: Recarga
							<xml version="1.0" encoding="utf-8">
								<Pago_Recarga>
									<Cod_Contrato></Cod_Contrato>
									<Cod_TipoProducto></Cod_TipoProducto>
								</Pago_Recarga>
							</xml>

		isbXMLPayment    	Estructura XML que contiene informacion del pago
							<?xml version="1.0" encoding="utf-8" ?> 
							<Informacion_Pago>
								<Conciliacion>
									<Cod_Conciliacion></Cod_Conciliacion>
									<Entidad_Conciliacion></Entidad_Conciliacion>
									<Fecha_Conciliacion></Fecha_Conciliacion>
								</Conciliacion>
								<Entidad_Recaudo></Entidad_Recaudo>
								<Punto_Pago></Punto_Pago>
								<Valor_Pagado></Valor_Pagado>
								<Fecha_Pago></Fecha_Pago>
								<No_Transaccion></No_Transaccion>
								<Forma_Pago></Forma_Pago>
								<Clase_Documento></Clase_Documento>
								<No_Documento></No_Documento>
								<Ent_Exp_Documento></Ent_Exp_Documento>
								<No_Autorizacion></No_Autorizacion>
								<No_Meses></No_Meses>
								<No_Cuenta></No_Cuenta>
								<Programa></Programa>
								<Terminal></Terminal>
							</Informacion_Pago>

    Parametros de Salida
		osbXMLCoupons 		Cadena XML Cupones pagados
							<?xml version = '1.0' encoding='ISO-8859-1'?>
							<Cupones_Pagados>
								<Conciliacion></Conciliacion>
								<Cupones>
									<Cupon_Pagado></Cupon_Pagado>
									<Contrato_Pagado></Contrato_Pagado>
								</Cupones>
							</Cupones_Pagados>

		onuErrorCode      	Codigo de error
		osbErrorMessage   	Mensaje de error
    
	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    cgonzalez   04/09/2023      OSF-1518: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_paymentsregister';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);
	
	os_paymentsregister
	(
		inuRefType,
		isbXMLReference,
		isbXMLPayment,
		osbXMLCuopons,
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
  pkg_utilidades.prAplicarPermisos('API_PAYMENTSREGISTER', 'ADM_PERSON');
end;
/