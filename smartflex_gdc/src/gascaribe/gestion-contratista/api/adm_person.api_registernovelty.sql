create or replace procedure   adm_person.api_registernovelty (  inuOperatingUnit  IN  NUMBER,
                                                                inuItemId         IN  NUMBER,
                                                                inuPersonId       IN NUMBER,
                                                                inuOrderId        IN NUMBER,
                                                                inuValueRef       IN NUMBER,
                                                                inuAmount         IN NUMBER,
                                                                inuObservType     IN NUMBER,
                                                                isbObservation    IN VARCHAR2,
																isbRelacionaOrden IN VARCHAR2 DEFAULT 'S',
                                                                onuOrdenNovedad   OUT NUMBER,
                                                                onuErrorCode     OUT GE_MESSAGE.MESSAGE_ID%TYPE,
                                                                osbErrorMessage  OUT GE_ERROR_LOG.DESCRIPTION%TYPE ) IS
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
     Programa        : API_ADDITEMSORDER
     Descripcion     : api para Registrar Novedad de Liquidacion a Contratista
     Autor           : Luis Javier Lopez
     Fecha           : 23-08-2023

    Parametros de Entrada
        inuOperatingUnit	Identificador de la Unidad de Trabajo que Ocasiono la Novedad
        inuItemsId	        Identificador del Items que Representa la Novedad de Liquidacion.
        inuPersonId	        Tecnico de la Unidad que Provoco la Novedad.
        inuOrderId	        Orden de Referencia, es la Orden que Ocasiono la Novedad.
        inuValueRef	        Valor a Aplicar de la Novedad.
        inuAmount	        Cantidad de Item de Novedades
        inuObservType	    Identificador del Tipo de Observacion.
        isbObservation	    Observacion de la Novedad.
		isbRelacionaOrden   Indica si se debe relacionar la orden con la orden de novedad

    Parametros de Salida
        onuErrorCode          codigo de error
        osbErrorMessage       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripcion
	JSOTO		19/10/2023      OSF-1730 Se agrega variable isbRelacionaOrden para relacionar la orden de novedad
								Se actualiza el manejo de traza personalizada.
	jpinedc		10/07/2024      OSF-2204: * Se cambia OS_REGISTERNEWCHARGE                                
  ***************************************************************************/
  
    nuIdDireccion           NUMBER;
    cnuTipoRelacionNovedad  NUMBER := 14;
    csbMT_NAME  			  VARCHAR2(35) := 'API_REGISTERNOVELTY';
    cnuNVLTRC 			  CONSTANT NUMBER := pkg_traza.cnuNivelTrzApi;
    csbInicio   			  CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
  
	PROCEDURE prcRegistraOrdenNovedad
	(
        inuUnidadOperativa  IN  NUMBER,   
        inuItem             IN  NUMBER,
        inuOperario         IN  NUMBER,
        inuOrden            IN  NUMBER,
        inuValorRef         IN  NUMBER,
        inuCantidad         IN  NUMBER,
        inuTipoComentario   IN  NUMBER,
        isbComentario       IN  VARCHAR2,
        onuOrdenNovedad     OUT NUMBER,
        onuError            OUT NUMBER,
        osbError	        OUT VARCHAR2
	) IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbMT_NAME || '.prcRegistraOrdenNovedad';
	BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);

        pkg_error.prInicializaError(onuError, osbError);
        
        CT_BONOVELTY.VALIDATENOVELTY(
            inuUnidadOperativa,
            inuItem,
            inuOperario,
            inuOrden,
            inuValorRef,
            inuCantidad,
            NULL,
            inuTipoComentario,
            isbComentario,
            FALSE
        );
        
        CT_BONOVELTY.CREATENOVELTY(
            INUCONTRACTOR => NULL,
            INUOPERUNIT   => inuUnidadOperativa,
            INUITEM       => inuItem,
            INUTECUNIT    => inuOperario,
            INUORDERID    => inuOrden,
            INUVALUE      => inuValorRef,
            INUAMOUNT     => inuCantidad,
            INUUSERID     => NULL,
            INUCOMMENTYPE => inuTipoComentario,
            ISBCOMMENT    => isbComentario,
            ONUORDER      => onuOrdenNovedad
        );        
	          
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);  
    
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(onuError,osbError);        
            pkg_traza.trace('osbError => ' || osbError, cnuNVLTRC );
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(onuError,osbError);
            pkg_traza.trace('osbError => ' || osbError, cnuNVLTRC );	
	END prcRegistraOrdenNovedad;
    
BEGIN
 
	pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	
	pkg_error.prInicializaError(onuErrorCode, osbErrorMessage);
   
    prcRegistraOrdenNovedad( inuOperatingUnit,
                         inuItemId,
                         inuPersonId,
                         inuOrderId,
                         inuValueRef,
                         inuAmount,
                         inuObservType,
                         isbObservation,
                         onuOrdenNovedad,
                         onuErrorCode,
                         osbErrorMessage );
  
    IF ( onuErrorCode = 0 AND daor_order.fblexist(inuOrderId) AND isbRelacionaOrden = 'S') THEN
        nuIdDireccion := daor_order.fnugetexternal_address_id(inuOrderId);
        UPDATE or_order
        SET external_address_id = nuIdDireccion
        WHERE order_id IN
        (
            SELECT related_order_id
            FROM or_related_order
            WHERE order_id = inuOrderId
              AND rela_order_type_id = cnuTipoRelacionNovedad
        );
        UPDATE OR_order_activity
        SET address_id = nuIdDireccion
        WHERE ORDER_id IN
        (
            SELECT related_ORDER_id
            FROM OR_related_order
            WHERE ORDER_id = inuOrderId
              AND rela_order_type_id = cnuTipoRelacionNovedad
        );
    END IF;
	
	pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
  
 EXCEPTION
   WHEN 
      pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
	  pkg_traza.trace(csbMT_NAME||'['||osbErrorMessage||']',cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERC);
   WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError( onuErrorCode, osbErrorMessage );
	  pkg_traza.trace(csbMT_NAME||'['||osbErrorMessage||']',cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
END api_registernovelty;
/
BEGIN
     pkg_utilidades.praplicarpermisos('API_REGISTERNOVELTY', 'ADM_PERSON');
END;
/
