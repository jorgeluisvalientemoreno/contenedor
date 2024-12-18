CREATE OR REPLACE PROCEDURE adm_person.api_registerdebtfinancing
(
	inuSubscriptionId   IN  suscripc.susccodi%TYPE,
    inuProductId        IN  servsusc.sesunuse%TYPE,
    isbDeferredList     IN  VARCHAR2,
    isbOnlyExpiredAcc   IN  cc_financing_request.only_expired_acc%TYPE,
    isbRequireSigning   IN  cc_financing_request.wait_by_sign%TYPE,
    idtRegisterDate     IN  mo_packages.request_date%TYPE,
    inuReceptionTypeId  IN  mo_packages.reception_type_id%TYPE,
    inuSubscriberId     IN  mo_packages.contact_id%TYPE,
    isbResponseAddress  IN  ab_address.address%TYPE,
    inuGeograLocation   IN  ge_geogra_location.geograp_location_id%TYPE,
    isbComment          IN  mo_packages.comment_%TYPE,
    inuFinancingPlanId  IN  plandife.pldicodi%TYPE,
    idtInitPayDate      IN  diferido.difefein%TYPE,
    inuDiscountValue    IN  cc_financing_request.value_to_finance%TYPE,
    inuValueToPay       IN  cc_financing_request.initial_payment%TYPE,
    inuSpread           IN  diferido.difespre%TYPE,
    inuQuotesNumber     IN  diferido.difenucu%TYPE,
    isbSupportDocument  IN  diferido.difenudo%TYPE,
    isbCosignersList    IN  VARCHAR2,
    onuPackageId        OUT mo_packages.package_id%TYPE,
    onuCouponNumber     OUT cupon.cuponume%TYPE,
    onuErrorCode        OUT ge_error_log.message_id%TYPE,
    osbErrorMessage     OUT ge_error_log.description%TYPE,
    isbProcessName      IN  VARCHAR2 DEFAULT NULL
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : api_registerdebtfinancing
    Descripcion     : Api para registrar negociacion de deuda
    Autor           : Carlos Andres Gonzalez (Horbath)
    Fecha           : 01-09-2023
    
	Parametros de Entrada
		inuSubscriptionId 	Contrato
		inuProductId        Producto
		isbDeferredList     Lista de diferidos para la financiacion
		isbOnlyExpiredAcc   Flag financiar solo deuda vencida
		isbRequireSigning   Flag verificacion perfil financiero del usuario
		idtRegisterDate     Fecha de registro
		inuReceptionTypeId  Medio de recepcion
		inuSubscriberId     Identificador del cliente
		isbResponseAddress  Direccion de respuesta
		inuGeograLocation   Ubicacion geografica
		isbComment          Comentario
		inuFinancingPlanId  Plan de financiacion
		idtInitPayDate      Fecha de inicio de cobro
		inuDiscountValue    Valor de descuento
		inuValueToPay       Valor a pagar como cuota inicial
		inuSpread           Puntos adicionales al porcentaje de interes
		inuQuotesNumber     Numero de cuotas
		isbSupportDocument  Documento de soporte
		isbCosignersList    Lista de codeudores
		isbProcessName      Nombre del proceso
		
    Parametros de Salida
		onuPackageId 		Solicitud
		onuCouponNumber 	Numero del Cupon
		onuErrorCode      	Codigo de error
		osbErrorMessage   	Mensaje de error
    
	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    cgonzalez   01/09/2023      OSF-1511: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_registerdebtfinancing';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);
	
	os_registerdebtfinancing
	(
		inuSubscriptionId,
		inuProductId,
		isbDeferredList,
		isbOnlyExpiredAcc,
		isbRequireSigning,
		idtRegisterDate,
		inuReceptionTypeId,
		inuSubscriberId,
		isbResponseAddress,
		inuGeograLocation,
		isbComment,
		inuFinancingPlanId,
		idtInitPayDate,
		inuDiscountValue,
		inuValueToPay,
		inuSpread,
		inuQuotesNumber,
		isbSupportDocument,
		isbCosignersList,
		onuPackageId,
		onuCouponNumber,
		onuErrorCode,
		osbErrorMessage,
		isbProcessName
	);
	
	ut_trace.trace('onuPackageId: '||onuPackageId, 10);
	ut_trace.trace('onuCouponNumber: '||onuCouponNumber, 10);
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
  pkg_utilidades.prAplicarPermisos('API_REGISTERDEBTFINANCING', 'ADM_PERSON');
end;
/