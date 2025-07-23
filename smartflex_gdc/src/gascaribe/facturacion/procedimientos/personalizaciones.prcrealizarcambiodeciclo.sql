CREATE OR REPLACE PROCEDURE PERSONALIZACIONES.prcRealizarCambioDeCiclo IS
/**************************************************************************
    Propiedad intelectual de Gases del Caribe S.A (c).
            
    Nombre      :   prcRealizarCambioDeCiclo
    Descripción :   Pluggin para legalización de orden 12134
    Autor       :   jcatuche
    Fecha       :   16/12/2024
            
    Historial de Modificaciones
    ---------------------------------------------------------------------------
    Fecha         Autor         Descripcion
    =====         =======       ===============================================
    16/12/2024    jcatuche      OSF-3758: Creación
***************************************************************************/
    -- Constantes para el control de la traza
    csbMetodo           CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;          -- Constante para nombre de objeto    
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para este objeto. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
    
    -------------------------
    --  PRIVATE VARIABLES
    -------------------------
    nuError             NUMBER;
    sbError             VARCHAR2(2000);
    
    nuOrden             NUMBER;
    nuCausal   	        ge_causal.causal_id%TYPE;
    
BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
    -- Obtiene la orden
	nuOrden := pkg_bcordenes.fnuObtenerOTInstanciaLegal;
	pkg_traza.trace('nuOrden: ' || nuOrden, csbNivelTraza);
	
	nuCausal := pkg_bcordenes.fnuobtienecausal(nuOrden);
	pkg_traza.trace('nuCausal: ' || nuCausal, csbNivelTraza);
	
	--Procedimiento de legalización
	OAL_RealizaCambioDeCiclo
	(
        nuOrden,    --Número de la orden
        nuCausal,   --Causal
        null,       --Persona
        null,       --Fecha inic ejecución
        null,       --Fecha fin ejecución
        null,       --Datos adicionales
        null,       --Actividades
        null,       --Items Elementos
        null,       --Lecturas Elementos
        null        --Comentarios Elementos
	);
	
	pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
EXCEPTION
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
        RAISE pkg_Error.Controlled_Error;
END PRCREALIZARCAMBIODECICLO;
/
PROMPT Otorga Permisos de Ejecución a personalizaciones.PRCREALIZARCAMBIODECICLO
BEGIN
  pkg_utilidades.prAplicarPermisos('PRCREALIZARCAMBIODECICLO','PERSONALIZACIONES');
END;
/
