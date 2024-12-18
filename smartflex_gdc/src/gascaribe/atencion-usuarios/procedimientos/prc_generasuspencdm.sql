CREATE OR REPLACE PROCEDURE prc_generasuspencdm
IS

	/*****************************************************************
	Unidad         : prc_generasuspencdm
	Descripcion    : Genera solicitud 100328 - Suspension por calidad de medicion, con el item
					 100009279 - CLM - SUSPENSION DESDE CDM_POR NO CAMBIO DE MEDIDOR EN MAL ESTADO
					
	Autor          : Jhon Erazo
	Fecha          : 30-01-2024

	Parametros            Descripcion
	============        	===================
	inuInstancia_id			Identificador de la instancia

	Historia de Modificaciones

	DD-MM-YYYY    <Autor>           Modificacion
	-----------  ---------------	-------------------------------------
	30-01-2024   jerazomvm        	OSF-2199: Creación.
	******************************************************************/
  
	--<<
	-- Variables del proceso
	-- Constantes para el control de la traza
	csbSP_NAME 	CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
	cnuNVLTRC 	CONSTANT NUMBER 		:= pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) 	:= pkg_traza.fsbINICIO;
	
	nuCodError			NUMBER;
	nuOrden  			or_order.order_id%type;
	sbErrorMessage  	VARCHAR2(4000);	
	
	-->>

BEGIN

	pkg_traza.trace(csbSP_NAME, cnuNVLTRC, csbInicio);
	
	 --Obtener el identificador de la orden
	nuorden       := PKG_BCORDENES.FNUOBTENEROTINSTANCIALEGAL;
	pkg_traza.trace('Numero de la Orden:' || nuorden, cnuNVLTRC);

	prc_generasolisuspencdm(nuorden);
	
	pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN);

EXCEPTION
	WHEN pkg_Error.Controlled_Error THEN
		Pkg_Error.seterror;
		pkg_Error.getError(nuCodError, sbErrorMessage);
		pkg_traza.trace('nuCodError: ' || nuCodError || ', ' || 'sbErrorMessage: ' || sbErrorMessage, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
		RAISE PKG_ERROR.CONTROLLED_ERROR;
	WHEN others THEN
		Pkg_Error.seterror;
		pkg_error.geterror(nuCodError, sbErrorMessage);
		pkg_traza.trace('nuCodError: ' || nuCodError || ', ' || 'sbErrorMessage: ' || sbErrorMessage, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
		RAISE PKG_ERROR.CONTROLLED_ERROR;
END prc_generasuspencdm;
/
PROMPT Otorgando permisos de ejecución a prc_generasuspencdm
BEGIN
	pkg_utilidades.prAplicarPermisos(upper('prc_generasuspencdm'),'OPEN'); 
END;
/
