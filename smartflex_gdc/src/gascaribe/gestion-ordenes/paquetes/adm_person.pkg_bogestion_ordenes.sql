CREATE OR REPLACE PACKAGE adm_person.pkg_bogestion_ordenes IS
  /*******************************************************************************
      Propiedad Intelectual de Gases del Caribe

    Programa  : pkg_bogestion_ordenes
    Autor       : Luis Felipe Valencia Hurtado
      Fecha       : 12-03-2024
      Descripcion : Paquete para gestion de ordenes

    Modificaciones  :
      Autor           Fecha       Caso      Descripcion
      felipe.valencia     12-03-2024  OSF-2416  Creacion
      lubin.pineda        18-12-2024  OSF-3726  prcEjecutarOrden : Creacion
      jsoto		  		  27/12/2024  OSF-3805  prcProcesarOrden : Creacion
	  jsoto				  10/03/2025  OSF-4095  Se adicionan los metodos fnuObtActividadLegalizada
												y prcCreaOrdenCerrada
												Se suprime el método prcProcesarOrden
      jpinedc             27-03-2025  OSF-4042  * Se crea STYOR_ORDER_SMF
                                                * Se crea prObtieneCostoOrden												
  *******************************************************************************/
    SUBTYPE STYOR_ORDER_SMF IS DAOR_ORDER.STYOR_ORDER;
    
  PROCEDURE prcActualizaDireccion(inuOrden     IN or_order.order_id%TYPE,
                                  inuDireccion IN or_order.external_address_id%TYPE);

  --Servicio para obtener el motivo instanciado
  FUNCTION fnuObtMotivoActividad RETURN NUMBER;

  -- Actualiza la orden como ejecutada
  PROCEDURE prcEjecutarOrden(inuOrden          IN or_order_comment.order_id%TYPE,
                             inuTipoComentario IN or_order_comment.comment_type_id%TYPE,
                             isbComentario     IN or_order_comment.order_comment%TYPE);

  FUNCTION fblValGenerarOrdenAdicional (
									ircOrder  IN pkg_or_order.styor_order
									) RETURN BOOLEAN;

							
  FUNCTION fnuObtActividadLegalizada 
  RETURN NUMBER;

  PROCEDURE prcCreaOrdenCerrada 
							 (
								 inuActividad         	IN  ge_items.items_id%TYPE,
								 inuUnidadOperativa     IN  or_order.operating_unit_id%TYPE,
								 inuCausalLegalizacion  IN  or_order.causal_id%TYPE,
								 inuPersonaLegaliza     IN  ge_person.person_id%TYPE,
								 inuDireccion        	IN  or_order_activity.address_id%TYPE,
								 idtFechaFinalizacion   IN  or_order.execution_final_date%TYPE,
								 inuCantidadItem       	IN  or_order_items.legal_item_amount%TYPE DEFAULT NULL,
								 inuValorReferencia     IN  or_order_activity.value_reference%TYPE DEFAULT NULL,
								 inuTipoObservacion    	IN  ge_comment_type.comment_type_id%TYPE DEFAULT NULL,
								 isbObservacion         IN  or_order_comment.order_comment%TYPE DEFAULT NULL,
								 inuOrdenRelacionada    IN  or_order.order_id%TYPE DEFAULT NULL,
								 inuTipoRelacion     	IN  ge_transition_type.transition_type_id%TYPE DEFAULT NULL,
								 inuPackageId        	IN  mo_packages.package_id%TYPE DEFAULT NULL,
								 inuMotiveId         	IN  mo_motive.motive_id%TYPE DEFAULT NULL,
								 inuComponentId      	IN  mo_component.component_id%TYPE DEFAULT NULL,
								 inuInstanceId       	IN  wf_instance.instance_id%TYPE DEFAULT NULL,
								 inuProducto        	IN  pr_product.product_id%TYPE DEFAULT NULL,
								 ionuOrder_id         	IN out or_order.order_id%TYPE
							 );

    -- Obtiene el costo de la orden
    PROCEDURE prObtieneCostoOrden( ircOrden   IN OUT STYOR_ORDER_SMF);
    
END pkg_bogestion_ordenes;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bogestion_ordenes IS

  -- Constantes para el control de la traza
  csbSP_NAME    CONSTANT VARCHAR2(100) := $$PLSQL_UNIT;
  csbNivelTraza CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;

  -- Identificador del ultimo caso que hizo cambios
  csbVersion CONSTANT VARCHAR2(15) := 'OSF-4042';

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe

  Programa        : fsbVersion
  Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor         : Luis Felipe Valencia Hurtado
    Fecha         : 12-03-2024

    Modificaciones  :
    Autor           Fecha       Caso      Descripcion
    felipe.valencia     12-03-2024  OSF-2416  Creacion
  ***************************************************************************/
  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe

  Programa        : prcActualizaDireccion
    Descripcion     : Ejecuta el cambio de direccion de la orden

    Autor         :   Luis Felipe Valencia Hurtado
    Fecha         :   12-03-2024

    Parametros de Entrada
      inuOrden          Identificador de la orden
      isbDireccion    Identificador de la Direccion
    Parametros de Salida
      nuError       codigo de error
      osbError       mensaje de error

  Modificaciones  :
    Autor           Fecha       Caso      Descripcion
    felipe.valencia     12-03-2024  OSF-2416  Creacion
  ***************************************************************************/
  PROCEDURE prcActualizaDireccion(inuOrden     IN or_order.order_id%TYPE,
                                  inuDireccion IN or_order.external_address_id%TYPE) IS
    csbMT_NAME VARCHAR2(100) := csbSP_NAME || '.prcActualizaDireccion';
    nuError    NUMBER;
    sbError    VARCHAR2(32767);
    sbmensaje  VARCHAR2(32767);
  BEGIN
    pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbINICIO);
    pkg_traza.trace('inuOrden => ' || inuOrden, csbNivelTraza);
    pkg_error.prInicializaError(nuError, sbError);

    pkg_or_order.prcActualizaDireccionOrden(inuOrden,
                                            inuDireccion,
                                            nuError,
                                            sbError);

    IF (NVL(nuError, 0) = 0) THEN
      pkg_or_order_activity.prcactualizaDireccActividad(inuOrden,
                                                        inuDireccion,
                                                        nuError,
                                                        sbError);
      IF (NVL(nuError, 0) = 0) THEN
        pkg_or_extern_systems_id.prcactualizaDireccExterna(inuOrden,
                                                           inuDireccion,
                                                           nuError,
                                                           sbError);
        IF (NVL(nuError, 0) <> 0) THEN
          sbmensaje := 'Error actualizando or_extern_systems_id nuError :' ||
                       nuError || ' sbError: ' || sbError;
          Pkg_Error.SetErrorMessage(isbMsgErrr => sbmensaje);
        END IF;
      ELSE
        sbmensaje := 'Error actualizando or_order_activity nuError :' ||
                     nuError || ' sbError: ' || sbError;
        Pkg_Error.SetErrorMessage(isbMsgErrr => sbmensaje);
      END IF;
    ELSE
      sbmensaje := 'Error actualizando or_order nuError :' || nuError ||
                   ' sbError: ' || sbError;
      Pkg_Error.SetErrorMessage(isbMsgErrr => sbmensaje);
    END IF;

    pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
      pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
      pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
  END prcActualizaDireccion;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Programa      : fnuObtMotivoActividad
    Descripcion   : Servicio para obtener el motivo instanciado
    Caso          : OSF-3541
    Autor         : Jorge Valiente
    Fecha         : 19-11-2024

    Parametros
      Salida
        nuMotivo    Codigo Motivo

    Modificaciones  :
    Autor           Fecha       Caso      Descripcion
  ***************************************************************************/
  FUNCTION fnuObtMotivoActividad RETURN NUMBER IS

    csbMT_NAME VARCHAR2(100) := csbSP_NAME || '.fnuObtMotivoActividad';
    nuError    NUMBER;
    sbError    VARCHAR2(32767);

    nuMotivo NUMBER;

  BEGIN

    pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbINICIO);

    pkg_traza.trace('Ejecucion del servicio OR_BOLEGALIZEACTIVITIES.FNUGETCURRMOTIVE',
                    csbNivelTraza);

    nuMotivo := OR_BOLEGALIZEACTIVITIES.FNUGETCURRMOTIVE();

    pkg_traza.trace('Motivo: ' || nuMotivo, csbNivelTraza);

    pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN);

    RETURN(nuMotivo);

  EXCEPTION

    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, csbNivelTraza);
      pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;

    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, csbNivelTraza);
      pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;

  END fnuObtMotivoActividad;

  PROCEDURE prcEjecutarOrden(inuOrden          IN or_order_comment.order_id%TYPE,
                             inuTipoComentario IN or_order_comment.comment_type_id%TYPE,
                             isbComentario     IN or_order_comment.order_comment%TYPE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcEjecutarOrden';
    nuError NUMBER;
    sbError VARCHAR2(4000);

  BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

    OR_BOEjecutarorden.EjecutarOrden(inuOrden,
                                     inuTipoComentario,
                                     isbComentario);

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
  END prcEjecutarOrden;


  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Programa      : fblValGenerarOrdenAdicional
    Descripcion   : Servicio Validar que el estado de la orden sea valido para
					crear relacion con otra orden
    Caso          : OSF-3639
    Autor         : Jhon Soto
    Fecha         : 19-12-2024

    Parametros
      Salida
        nuActividad    Codigo Actividad  Legalizada

    Modificaciones  :
    Autor           Fecha       Caso      Descripcion
  ***************************************************************************/
  FUNCTION fblValGenerarOrdenAdicional (ircOrder  IN pkg_or_order.styor_order) RETURN BOOLEAN IS

    csbMT_NAME VARCHAR2(100) := csbSP_NAME ||
                                '.fblValGenerarOrdenAdicional ';
    nuError    NUMBER;
    sbError    VARCHAR2(32767);

    nuActividad NUMBER;

  BEGIN

    pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbINICIO);

    pkg_traza.trace('Ejecucion del servicio OR_BOPROCESSORDER.FBLISORDERALTERABLEBYRELATED',
                    csbNivelTraza);

	IF OR_BOPROCESSORDER.FBLISORDERALTERABLEBYRELATED(ircOrder) THEN
		pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN);
		RETURN(CONSTANTS_PER.GETTRUE);
	END IF;


    pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN);
    RETURN(CONSTANTS_PER.GETFALSE);

  EXCEPTION

    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, csbNivelTraza);
      pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN_ERC);
      RETURN(CONSTANTS_PER.GETFALSE);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, csbNivelTraza);
      pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN_ERR);
      RETURN(CONSTANTS_PER.GETFALSE);
  END fblValGenerarOrdenAdicional ;


  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
  
    Programa      : fnuObtActividadLegalizada
    Descripcion   : Servicio para obtener Orden Actividad de orden legalizada
    Caso          : OSF-3541
    Autor         : Jorge Valiente
    Fecha         : 10-03-2025
  
    Parametros
      Salida
        nuActividad    Codigo Actividad  Legalizada
  
    Modificaciones  :
    Autor           Fecha       Caso      Descripcion
  ***************************************************************************/
  FUNCTION fnuObtActividadLegalizada RETURN NUMBER IS
  
    csbMT_NAME VARCHAR2(100) := csbSP_NAME ||
                                '.fnuObtActividadLegalizada';
    nuError    NUMBER;
    sbError    VARCHAR2(32767);
  
    nuActividad NUMBER;
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbINICIO);
  
    pkg_traza.trace('Ejecucion del servicio OR_BOLEGALIZEACTIVITIES.Fnugetcurractivity',
                    csbNivelTraza);
  
    nuActividad := OR_BOLEGALIZEACTIVITIES.Fnugetcurractivity;
  
    pkg_traza.trace('Actividad: ' || nuActividad, csbNivelTraza);
  
    pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN);
  
    RETURN(nuActividad);
  
  EXCEPTION
  
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, csbNivelTraza);
      pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, csbNivelTraza);
      pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
    
  END;


PROCEDURE prcCreaOrdenCerrada 
							 (
								 inuActividad         	IN  ge_items.items_id%TYPE,
								 inuUnidadOperativa     IN  or_order.operating_unit_id%TYPE,
								 inuCausalLegalizacion  IN  or_order.causal_id%TYPE,
								 inuPersonaLegaliza     IN  ge_person.person_id%TYPE,
								 inuDireccion        	IN  or_order_activity.address_id%TYPE,
								 idtFechaFinalizacion   IN  or_order.execution_final_date%TYPE,
								 inuCantidadItem       	IN  or_order_items.legal_item_amount%TYPE DEFAULT NULL,
								 inuValorReferencia     IN  or_order_activity.value_reference%TYPE DEFAULT NULL,
								 inuTipoObservacion    	IN  ge_comment_type.comment_type_id%TYPE DEFAULT NULL,
								 isbObservacion         IN  or_order_comment.order_comment%TYPE DEFAULT NULL,
								 inuOrdenRelacionada    IN  or_order.order_id%TYPE DEFAULT NULL,
								 inuTipoRelacion     	IN  ge_transition_type.transition_type_id%TYPE DEFAULT NULL,
								 inuPackageId        	IN  mo_packages.package_id%TYPE DEFAULT NULL,
								 inuMotiveId         	IN  mo_motive.motive_id%TYPE DEFAULT NULL,
								 inuComponentId      	IN  mo_component.component_id%TYPE DEFAULT NULL,
								 inuInstanceId       	IN  wf_instance.instance_id%TYPE DEFAULT NULL,
								 inuProducto        	IN  pr_product.product_id%TYPE DEFAULT NULL,
								 ionuOrder_id         	IN OUT or_order.order_id%TYPE
							 )
IS
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcCreaOrdenCerrada

	Parametros de Entrada
		 inuActividad         	Actividad
		 inuUnidadOperativa     Unidad Operativa
		 inuCausalLegalizacion  Causal de Legalizacion
		 inuPersonaLegaliza     Persona que legaliza
		 inuDireccion        	Direccion de instalacion del producto
		 idtFechaFinalizacion   Fecha final de legalizacion
		 inuCantidadItem       	Cantidad de item legalizado
		 inuValorReferencia     Valor de referencia
		 inuTipoObservacion    	Tipo de observación
		 isbObservacion         Observacion
		 inuOrdenRelacionada    Orden a relacionar
		 inuTipoRelacion     	Tipo de relacion
		 inuPackageId        	Solicitud 
		 inuMotiveId         	Motivo
		 inuComponentId      	Componente
		 inuInstanceId       	Instancia
		 inuProducto        	Producto
	
    Parametros de Salida
	
		 inuOrder_id         	IN out or_order.order_id%TYPE


    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/


	nuErrorCode    	NUMBER;
	sbErrorMessage 	VARCHAR2(4000);
	csbMT_NAME  		VARCHAR2(200) := csbSP_NAME || 'prcCreaOrdenCerrada';

BEGIN

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

	  or_boorder.CloseOrderWithProduct(inuActivity      => inuActividad, -- Actividad
									   inuOperUnitId    => inuUnidadOperativa, -- Unidad de Trabajo
									   inuCausalId      => inuCausalLegalizacion, -- Causal de legalizaci?n
									   inuPersonId      => inuPersonaLegaliza, -- Persona que legaliza
									   inuAddressId     => inuDireccion, -- Direccion del producto
									   idtFinishDate    => SYSDATE, -- Fecha final de ejecuci?n
									   inuItemAmount    => 1, -- Cantidad de Actividades legalizadas (1)
									   inuRefValue      => 0, -- Valor de la orden
									   inuCommentTypeId => inuTipoObservacion, -- Tipo de comentario de legalizacion
									   isbComment       => isbObservacion, -- Comentario de legalizacion
									   inuOrderRelaId   => NULL, -- orden relacionada (Si es orden regenerada)
									   inuRelationType  => NULL, -- Tipo de relacion (Si es una orden regenerada)
									   inupackageid     => NULL,
									   inumotiveid      => NULL,
									   inucomponentid   => NULL,
									   inuinstanceid    => NULL,
									   inuProductId     => inuProducto, -- Producto
									   ionuOrderId      => ionuOrder_id -- Entrada/Salida Orden generada  ?
									   );


	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbErrorMessage);
      pkg_traza.trace('sbErrorMessage: ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbErrorMessage);
      pkg_traza.trace('sbErrorMessage: ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
END prcCreaOrdenCerrada;

    -- Obtiene el costo de la orden
    PROCEDURE prObtieneCostoOrden( ircOrden   IN OUT STYOR_ORDER_SMF)
    IS
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prObtieneCostoOrden';
        
        nuError			    NUMBER;  
        sbmensaje		    VARCHAR2(1000);      
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
        OR_BOORDERCOST.GETORDERCOST( iorcorder => ircOrden );

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbmensaje);
            pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbmensaje: ' || sbmensaje, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE PKG_ERROR.CONTROLLED_ERROR;
        WHEN others THEN
            Pkg_Error.seterror;
            pkg_error.geterror(nuError, sbmensaje);
            pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbmensaje: ' || sbmensaje, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE PKG_ERROR.CONTROLLED_ERROR;    
    END prObtieneCostoOrden;
    

END pkg_bogestion_ordenes;
/
BEGIN
	pkg_utilidades.prAplicarPermisos(upper('pkg_bogestion_ordenes'), 'ADM_PERSON');
END;
/

