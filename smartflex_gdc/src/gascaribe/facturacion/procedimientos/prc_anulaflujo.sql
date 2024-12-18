CREATE OR REPLACE PROCEDURE prc_anulaflujo(inuInstancia_id IN wf_instance.instance_id%type)
IS

	/*****************************************************************
	Unidad         : prc_anulaflujo
	Descripcion    : Anula el flujo
					
	Autor          : Jhon Erazo
	Fecha          : 19-01-2024

	Parametros            Descripcion
	============        	===================
	inuInstancia_id			Identificador de la instancia

	Historia de Modificaciones

	DD-MM-YYYY    <Autor>           Modificacion
	-----------  ---------------	-------------------------------------
	19-01-2024   jerazomvm        	OSF-1907: Creación.
	******************************************************************/
  
	--<<
	-- Variables del proceso
	-- Constantes para el control de la traza
	csbSP_NAME 	CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
	cnuNVLTRC 	CONSTANT NUMBER 		:= pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) 	:= pkg_traza.fsbINICIO;
	
	nuCodError			NUMBER;
	sbErrorMessage  	VARCHAR2(4000);	
	-->>

BEGIN

	pkg_traza.trace(csbSP_NAME, cnuNVLTRC, csbInicio);
	
	pkg_traza.trace('inuInstancia_id: '	|| inuInstancia_id, cnuNVLTRC);
	
	PKG_BOGESTION_FLUJOS.prcAnulaFlujo(inuInstancia_id);
	
	pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN);

EXCEPTION
	WHEN others THEN
		Pkg_Error.seterror;
		pkg_error.geterror(nuCodError, sbErrorMessage);
		pkg_traza.trace('nuCodError: ' || nuCodError || ', ' || 'sbErrorMessage: ' || sbErrorMessage, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
		raise PKG_ERROR.CONTROLLED_ERROR;
END prc_anulaflujo;
/
PROMPT Otorgando permisos de ejecución a prc_anulaflujo
BEGIN
	pkg_utilidades.prAplicarPermisos('prc_anulaflujo', 'OPEN'); 
END;
/
