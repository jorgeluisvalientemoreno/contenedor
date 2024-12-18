CREATE OR REPLACE PROCEDURE prcReversaEstadoProducto
IS

	/*****************************************************************
	Unidad         : prcReversaEstadoProducto
	Descripcion    : Anula la solicitud de terminación de contrato
					
	Autor          : Jhon Erazo
	Fecha          : 28-02-2024

	Parametros            	Descripcion
	============        	===================

	Historia de Modificaciones

	DD-MM-YYYY    <Autor>           Modificacion
	-----------  ---------------	-------------------------------------
	28-02-2024   jerazomvm        	OSF-2374: Creación.
	******************************************************************/
  
	--<<
	-- Variables del proceso
	-- Constantes para el control de la traza
	csbSP_NAME 	CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT;
	cnuNVLTRC 	CONSTANT NUMBER 		:= pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) 	:= pkg_traza.fsbINICIO;
	
	nuSolicitudId		mo_packages.package_id%type;
	nuCodError			NUMBER;
	sbErrorMessage  	VARCHAR2(4000);	
	
	-->>

BEGIN

	pkg_traza.trace(csbSP_NAME, cnuNVLTRC, csbInicio);
	
	-- Obtiene la solicitud instanciada
	GE_BOInstance.GetValue('MO_PACKAGES', 'PACKAGE_ID', nuSolicitudId);
												 
	pkg_traza.trace('nuSolicitudId: ' || nuSolicitudId, cnuNVLTRC);
	
	-- Reversa el estado del producto
	pkg_botramiteanulacion.prcReversaEstadoProducto(nuSolicitudId);
	
	COMMIT;
	
	pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN);

EXCEPTION
	WHEN pkg_Error.Controlled_Error THEN
		Pkg_Error.seterror;
		pkg_Error.getError(nuCodError, sbErrorMessage);
		pkg_traza.trace('nuCodError: ' || nuCodError || ', ' || 'sbErrorMessage: ' || sbErrorMessage, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
		ROLLBACK;
		RAISE PKG_ERROR.CONTROLLED_ERROR;
	WHEN others THEN
		Pkg_Error.seterror;
		pkg_error.geterror(nuCodError, sbErrorMessage);
		pkg_traza.trace('nuCodError: ' || nuCodError || ', ' || 'sbErrorMessage: ' || sbErrorMessage, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
		ROLLBACK;
		RAISE PKG_ERROR.CONTROLLED_ERROR;
END prcReversaEstadoProducto;
/
PROMPT Otorgando permisos de ejecución a prcReversaEstadoProducto
BEGIN
	pkg_utilidades.prAplicarPermisos(upper('prcReversaEstadoProducto'),'OPEN'); 
END;
/
