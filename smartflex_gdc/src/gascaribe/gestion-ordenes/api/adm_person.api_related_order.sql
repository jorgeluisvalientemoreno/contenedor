CREATE OR REPLACE PROCEDURE adm_person.api_related_order( inuOrderId         	IN NUMBER,
                                                           inuOrdenRelacionar 	IN NUMBER,
                                                           onuErrorCode       	OUT NUMBER,
                                                           osbErrorMessage    	OUT VARCHAR2,
														   inuTipoRelacion	 	IN NUMBER DEFAULT 13) IS
  /*****************************************************************
  Procedimiento   :   api_related_order
  Descripcion     :   Proceso que se encarga de llamar al api de relacionar orden

  Parametros de Entrada
    InuOrderId            codigo de la Orden padre
    inuOrdenRelacionar    codigo de orden a relacionar

  Parametros de Salida
    OnuErrorCode          codigo de error
    OsbErrorMessage       mensaje de error


  Historia de Modificaciones
  Fecha       Autor              Modificacion
  =========   =========       ====================
  17-07-2023  LJLB            OSF-1133 Creacion
  20-12-2024  JSOTO			  OSF-3805 Se cambia objeto de open llamado, se adiciona parametro de entrada inuTipoRelacion
  ******************************************************************/
  
  csbMT_NAME  		VARCHAR2(200) := 'api_related_order';

BEGIN

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
	
	pkg_traza.trace('Parametros de entrada:');
	pkg_traza.trace('inuOrderId: '|| inuOrderId);
	pkg_traza.trace('inuOrdenRelacionar: '|| inuOrdenRelacionar);
	pkg_traza.trace('inuTipoRelacion: '|| inuTipoRelacion);

	onuErrorCode := 0;

	or_borelatedorder.relateorders(inuOrderId, inuOrdenRelacionar,inuTipoRelacion);
  
	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
	
EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(onuErrorCode, osbErrorMessage);
      pkg_traza.trace('osbErrorMessage: ' || osbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuErrorCode, osbErrorMessage);
      pkg_traza.trace('osbErrorMessage: ' || osbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;END api_related_order;
/
BEGIN
   pkg_utilidades.prAplicarPermisos('API_RELATED_ORDER', 'ADM_PERSON');
END;
/