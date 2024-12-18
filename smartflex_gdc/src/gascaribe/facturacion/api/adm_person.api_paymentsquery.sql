CREATE OR REPLACE PROCEDURE adm_person.api_paymentsquery
(
	inuReferencia  			IN  NUMBER,
    iclDatosConsultaXML     IN  CLOB,
    oclResulConsultaXML 	OUT CLOB,
	onuCodigoError 			OUT ge_error_log.error_log_id%TYPE,
	osbMensajeError 		OUT ge_error_log.description%TYPE
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : api_paymentsquery
    Descripcion     : Api para consultar historico de pagos
    Autor           : Carlos Andres Gonzalez (Horbath)
    Fecha           : 04-09-2023
    
	Parametros de Entrada
		inuReferencia 			Tipo de Referencia
								1: Cliente
								2: Contrato
		iclDatosConsultaXML     Estructura XML de acuerdo al tipo de referencia
								1: Cliente
								<xml version="1.0" encoding="utf-8">
									<Pagos_Cliente>
										<Tipo_Id></Tipo_Id>
										<Numero_Id></Numero_Id>
										<Cantidad></Cantidad>
									</Pagos_Cliente>
								</xml>
								
								2: Contrato
								<xml version="1.0" encoding="utf-8">
									<Pagos_Contrato>
										<Contrato></Contrato>
										<Cantidad></Cantidad>
									</Pagos_Contrato>
								</xml>
		
    Parametros de Salida
		oclResulConsultaXML 
								<xml version="1.0" encoding="utf-8">
									<Resultados>
										<His_Pagos>
											<Contrato></Contrato>
											<Cupon></Cupon>
											< Valor_Pagado></Valor_Pagado>
											< Fecha_Pago></Fecha_Pago>
											< Entidad_Recaudo></Entidad_Recaudo>
											<Punto_Pago></Punto_Pago>
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
										</His_Pagos>
									</Resultados>
								</xml>
		
		onuCodigoError			Codigo de error
		osbMensajeError   		Mensaje de error
    
	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    cgonzalez   04/09/2023      OSF-1518: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_paymentsquery';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);
	
	os_paymentsquery
	(
		inuReferencia,
		iclDatosConsultaXML,
		oclResulConsultaXML,
		onuCodigoError,
		osbMensajeError
	);

	ut_trace.trace('onuCodigoError: '||onuCodigoError, 10);
	ut_trace.trace('osbMensajeError: '||osbMensajeError, 10);
   
	ut_trace.trace('Fin '||csbMetodo, 10);
EXCEPTION
	WHEN pkg_Error.CONTROLLED_ERROR THEN
		pkg_Error.GETERROR(onuCodigoError, osbMensajeError);
		ut_trace.trace('Fin CONTROLLED_ERROR '||csbMetodo||' '||osbMensajeError, 10);
	WHEN OTHERS THEN
		pkg_Error.SETERROR;
		pkg_Error.GETERROR(onuCodigoError, osbMensajeError);
		ut_trace.trace('Fin OTHERS '||csbMetodo||' '||osbMensajeError, 10);
END;
/
begin
  pkg_utilidades.prAplicarPermisos('API_PAYMENTSQUERY', 'ADM_PERSON');
end;
/