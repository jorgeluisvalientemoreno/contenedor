CREATE OR REPLACE PROCEDURE adm_person.api_set_newitem
(
	isbItemCode           	IN      ge_items.code%TYPE,
    ionuItemsId           	IN OUT 	ge_items.items_id%TYPE,
    isbDescription        	IN     	ge_items.description%TYPE,
    inuItemClassif        	IN      ge_items.item_classif_id%TYPE,
    inuiItemTipo           	IN      ge_items.id_items_tipo%TYPE,
    inuMeasureUnit        	IN      ge_items.measure_unit_id%TYPE,
    inuConcept            	IN      ge_items.concept%TYPE,
    inuConceptDiscount    	IN      ge_items.discount_concept%TYPE,
    isbProvType           	IN      ge_items.provisioning_type%TYPE,
    isbPlatform           	IN      ge_items.platform%TYPE,
    isbRecovery           	IN      ge_items.recovery%TYPE,
    isbRecoveryItemCode 	IN      ge_items.code%TYPE,
    inuItemsGama          	IN      ge_items_gama_item.id_items_gama%TYPE,
    inuInitStatus         	IN      ge_items.init_inv_status_id%TYPE,
    isbShared           	IN      ge_items.shared%TYPE,
	onuErrorCode 			OUT 	ge_message.message_id%TYPE,
	osbErrorMessage 		OUT 	ge_error_log.description%TYPE
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : api_set_newitem
    Descripcion     : Api para realizar la creacion de un item
    Autor           : Carlos Gonzalez
    Fecha           : 29-08-2023
    
	Parametros de Entrada
		isbItemCode				Serie del item
		ionuItemsId				Identificador
		isbDescription			Descripcion
		inuItemClassif			Clasificacion del item
		inuiItemTipo			Tipo de item
		inuMeasureUnit			Unidad de medida
		inuConcept				Concepto
		inuConceptDiscount		Concepto de descuento
		isbProvType				Tipo de aprovisionamiento
		isbPlatform				Plataforma de aprovisionamiento
		isbRecovery				Recuperable
		isbRecoveryItemCode 	Serie del item de recuperacion
		inuItemsGama			Gama del item
		inuInitStatus			Estado inicial
		isbShared				Compartido

    Parametros de Salida
		onuErrorCode      			Codigo de error
		osbErrorMessage   			Mensaje de error
    
	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    cgonzalez   29/08/2023      OSF-1476: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_set_newitem';
BEGIN
	ut_trace.trace('Inicio '||csbMetodo, 10);
	
	os_set_newitem
	(
		isbItemCode,
		ionuItemsId,
		isbDescription,
		inuItemClassif,
		inuiItemTipo,
		inuMeasureUnit,
		inuConcept,
		inuConceptDiscount,
		isbProvType,
		isbPlatform,
		isbRecovery,
		isbRecoveryItemCode,
		inuItemsGama,
		inuInitStatus,
		isbShared,
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
  pkg_utilidades.prAplicarPermisos('API_SET_NEWITEM', 'ADM_PERSON');
end;
/