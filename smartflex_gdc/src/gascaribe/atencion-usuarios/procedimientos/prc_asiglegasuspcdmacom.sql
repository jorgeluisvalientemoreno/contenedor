CREATE OR REPLACE PROCEDURE prc_asiglegasuspcdmacom
IS

	/*****************************************************************
	Unidad         : prc_asiglegasuspcdmacom
	Descripcion    : Asigna y legaliza las actividades 100009279 - CLM - SUSPENSION DESDE CDM_POR 
					 NO CAMBIO DE MEDIDOR EN MAL ESTADO y 100009280 - CLM - SUSPENSION DESDE ACOMETIDA_POR 
					 NO CAMBIO DE MEDIDOR EN MAL ESTADO
					
	Autor          : Jhon Erazo
	Fecha          : 31-01-2024

	Parametros            Descripcion
	============        	===================
	inuInstancia_id			Identificador de la instancia

	Historia de Modificaciones

	DD-MM-YYYY    <Autor>           Modificacion
	-----------  ---------------	-------------------------------------
	31-01-2024   jerazomvm        	OSF-2199: Creación.
	******************************************************************/
  
	--<<
	-- Variables del proceso
	-- Constantes para el control de la traza
	csbSP_NAME 	CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
	cnuNVLTRC 	CONSTANT NUMBER 		:= pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) 	:= pkg_traza.fsbINICIO;
	
	nuCodError				NUMBER;
	sbErrorMessage  		VARCHAR2(4000);	
	
	-->>

BEGIN

	pkg_traza.trace(csbSP_NAME, cnuNVLTRC, csbInicio);
	
	prc_ejecasiglegasuspcdmacom;
	
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
END prc_asiglegasuspcdmacom;
/
PROMPT Otorgando permisos de ejecución a prc_asiglegasuspcdmacom
BEGIN
	pkg_utilidades.prAplicarPermisos(upper('prc_asiglegasuspcdmacom'),'OPEN'); 
END;
/
