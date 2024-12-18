CREATE OR REPLACE PROCEDURE adm_person.api_balancetopay
(
	inuReference  		IN  NUMBER,
    inuReferenceParam 	IN  CLOB,
    osbUnpaidDebt 		OUT CLOB,
	onuErrorCode 		OUT ge_error_log.message_id%TYPE,
	osbErrorMessage 	OUT ge_error_log.description%TYPE
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : api_balancetopay
    Descripcion     : Api para consultas saldos pendientes a pagar
    Autor           : Carlos Andres Gonzalez (Horbath)
    Fecha           : 04-09-2023
    
	Parametros de Entrada
		inuReference 		Tipo de Referencia
								1: Cliente
								2: Contrato
								3: Factura
								4: Numero de Servicio
								5: Elementos de Medicion
								6: Numero Fiscal
								7: Cupon
								8: Saldo Contrato
		inuReferenceParam   Estructura XML de acuerdo al tipo de referencia
								1: Cliente
								<?xml version = ''1.0'' encoding=''utf-8''?>
								<Saldos_Cliente>
									<Tipo_Id> </Tipo_Id>
									<Numero_Id> </Numero_Id>
								</Saldos_Cliente>
								
								2: Contrato
								<?xml version = ''1.0'' encoding=''utf-8''?>
								<Saldos_Contrato>
									<Cod_Contrato> </Cod_Contrato>
								</Saldos_Contrato>
								
								3: Factura
								<?xml version = ''1.0'' encoding=''utf-8''?>
								<Saldo_Factura>
									<Cod_Factura> </Cod_Factura>
								</Saldo_Factura>
								
								4: Numero de Servicio
								<?xml version = ''1.0'' encoding=''utf-8''?>
								<Saldos_Producto>
									<Num_Servicio> </Num_Servicio>
								</Saldos_Producto>
								
								5: Elementos de Medicion
								<?xml version = ''1.0'' encoding=''utf-8''?>
								<Saldos_ElementoMedicion>
									<Cod_Elemento> </Cod_Elemento>
								</Saldos_ElementoMedicion>
								
								6: Numero Fiscal
								<?xml version = ''1.0'' encoding=''utf-8''?>
								<Saldos_NumeroFiscal>
									<Tipo_Documento> </Tipo_Documento>
									<Prefijo> </Prefijo>
									<No_Fiscal> </No_Fiscal>
									<Tipo_Comprobante> </Tipo_Comprobante>
								</Saldos_NumeroFiscal>
								
								7: Cupon
								<?xml version = ''1.0'' encoding=''utf-8''?>
								<Num_Cupon>
									<Cupon> </Cupon>
								</Num_Cupon>
								
								8: Saldo Contrato
								<?xml version = ''1.0'' encoding=''utf-8''?>
								<Saldo_Contrato>
									<Cod_Contrato> </Cod_Contrato>
								</Saldo_Contrato>
		
    Parametros de Salida
		osbUnpaidDebt 		Informacion del Cupon
							< ?xml version="1.0" encoding="utf-8" ?>
								< Inf_Cupon>
								< Valor>
								< Cod_Contrato>
								< Nombre>
								< Dir_Cobro>
								< Estado>
							< /Inf_Cupon>
		onuErrorCode      	Codigo de error
		osbErrorMessage   	Mensaje de error
    
	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    cgonzalez   04/09/2023      OSF-1518: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_balancetopay';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);
	
	os_balancetopay
	(
		inuReference,
		inuReferenceParam,
		osbUnpaidDebt,
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
  pkg_utilidades.prAplicarPermisos('API_BALANCETOPAY', 'ADM_PERSON');
end;
/