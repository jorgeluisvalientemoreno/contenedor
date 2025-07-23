CREATE OR REPLACE PACKAGE PERSONALIZACIONES.pkg_LDC_CONFPLCAES IS
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		
		Autor       :   Jhon Eduar Erazo
		Fecha       :   21-03-2025
		Descripcion :   Paquete con los metodos para la entidad LDC_CONFPLCAES
		ModIFicaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	21/02/2025	OSF-4155	Creación
	*******************************************************************************/
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 21-03-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <ModIFicacion Autor="Jhon.Erazo" Fecha="21-03-2025" Inc="OSF-4155" Empresa="GDC">
               Creación
           </ModIFicacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;	
	
	-- Valida si el plan de financiación tiene plan de cartera especial
	FUNCTION fsbObtPlanCarteraEspecial(inuPlanFinanciacionId IN NUMBER)
	RETURN VARCHAR2;
									
END pkg_LDC_CONFPLCAES;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.pkg_LDC_CONFPLCAES IS

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.';
	cnuNVLTRC   CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
	
    -- IdentIFicador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-4155';

	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 21-03-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <ModIFicacion Autor="Jhon.Erazo" Fecha="21-03-2025" Inc="OSF-4155" Empresa="GDC"> 
               Creación
           </ModIFicacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END fsbVersion;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbObtPlanCarteraEspecial
    Descripcion     : Valida si el plan de financiación tiene plan de cartera especial
    Autor           : Jhon Erazo
    Fecha           : 21-03-2025
  
    Parametros de Entrada
		inuPlanFinanciacionId	Plan de financiación
	  
    Parametros de Salida
	
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	21/02/2025	OSF-4155	Creación
	***************************************************************************/	
	FUNCTION fsbObtPlanCarteraEspecial(inuPlanFinanciacionId IN NUMBER)
	RETURN VARCHAR2
	IS
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'fsbObtPlanCarteraEspecial';
		
		nuError			NUMBER;  
		sbmensaje		VARCHAR2(1000);	
		sbPlanEspecial	VARCHAR2(1);
		
		CURSOR cuPlanCarteraEspecial IS
			SELECT 'X'
			FROM LDC_CONFPLCAES
			WHERE COPCORIG = inuPlanFinanciacionId;
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuPlanFinanciacionId: ' || inuPlanFinanciacionId, cnuNVLTRC);
		
		IF (cuPlanCarteraEspecial%ISOPEN) THEN
			CLOSE cuPlanCarteraEspecial;
		END IF;
		
		OPEN cuPlanCarteraEspecial;
		FETCH cuPlanCarteraEspecial INTO sbPlanEspecial;			  
		CLOSE cuPlanCarteraEspecial;
		
		pkg_traza.trace('sbPlanEspecial: ' || sbPlanEspecial, cnuNVLTRC);

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN sbPlanEspecial;

	EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
	END fsbObtPlanCarteraEspecial;

END pkg_LDC_CONFPLCAES;
/
PROMPT Otorgando permisos de ejecución para adm_person.pkg_LDC_CONFPLCAES
BEGIN
    pkg_utilidades.prAplicarPermisos(UPPER('pkg_LDC_CONFPLCAES'), 'PERSONALIZACIONES');
END;
/