CREATE OR REPLACE PACKAGE PERSONALIZACIONES.pkg_LDC_SPECIALS_PLAN IS
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		
		Autor       :   Jhon Eduar Erazo
		Fecha       :   31-03-2025
		Descripcion :   Paquete con los metodos para la entidad LDC_SPECIALS_PLAN
		ModIFicaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	31/02/2025	OSF-4155	Creación
	*******************************************************************************/
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 31-03-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <ModIFicacion Autor="Jhon.Erazo" Fecha="31-03-2025" Inc="OSF-4155" Empresa="GDC">
               Creación
           </ModIFicacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;	
	
	-- Valida si el contrato y plan de financiación, tiene planes excepcionales	
	FUNCTION fnuObtExisPlanEspecxContra(inuContrato				IN NUMBER,
										inuPlanFinanciacionId 	IN NUMBER,
										idtFecha				IN DATE
										)
	RETURN NUMBER;
									
END pkg_LDC_SPECIALS_PLAN;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.pkg_LDC_SPECIALS_PLAN IS

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
    <Fecha> 31-03-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <ModIFicacion Autor="Jhon.Erazo" Fecha="31-03-2025" Inc="OSF-4155" Empresa="GDC"> 
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
    Programa        : fnuObtExisPlanEspecxContra
    Descripcion     : Valida si el contrato y plan de financiación, tiene planes excepcionales
    Autor           : Jhon Erazo
    Fecha           : 31-03-2025
  
    Parametros de Entrada
		inuContrato				Contrato
		inuPlanFinanciacionId	Plan de financiación
		idtFecha				Fecha
	  
    Parametros de Salida
	
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	31/02/2025	OSF-4155	Creación
	***************************************************************************/	
	FUNCTION fnuObtExisPlanEspecxContra(inuContrato				IN NUMBER,
										inuPlanFinanciacionId 	IN NUMBER,
										idtFecha				IN DATE
										)
	RETURN NUMBER
	IS
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'fnuObtExisPlanEspecxContra';
		
		nuError			NUMBER;  
		nuSpecialPlan	NUMBER;
		sbmensaje		VARCHAR2(1000);	
		
		CURSOR cuExistePlanEspecial IS
			SELECT  count(1)
			FROM LDC_SPECIALS_PLAN
			WHERE SUBSCRIPTION_ID = inuContrato
			AND PLAN_ID = inuPlanFinanciacionId
			AND idtFecha BETWEEN INIT_DATE AND END_DATE;
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuContrato: ' 			|| inuContrato 			 || CHR(10) ||
						'inuPlanFinanciacionId: ' 	|| inuPlanFinanciacionId || CHR(10) ||
						'idtFecha: ' 				|| idtFecha, cnuNVLTRC);
		
		IF (cuExistePlanEspecial%ISOPEN) THEN
			CLOSE cuExistePlanEspecial;
		END IF;
		
		OPEN cuExistePlanEspecial;
		FETCH cuExistePlanEspecial INTO nuSpecialPlan;			  
		CLOSE cuExistePlanEspecial;
		
		pkg_traza.trace('nuSpecialPlan: ' || nuSpecialPlan, cnuNVLTRC);

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuSpecialPlan;

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
	END fnuObtExisPlanEspecxContra;

END pkg_LDC_SPECIALS_PLAN;
/
PROMPT Otorgando permisos de ejecución para adm_person.pkg_LDC_SPECIALS_PLAN
BEGIN
    pkg_utilidades.prAplicarPermisos(UPPER('pkg_LDC_SPECIALS_PLAN'), 'PERSONALIZACIONES');
END;
/