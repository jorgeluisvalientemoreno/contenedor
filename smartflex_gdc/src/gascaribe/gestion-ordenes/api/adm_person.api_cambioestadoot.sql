CREATE OR REPLACE PROCEDURE adm_person.api_cambioestadoot
(
	inuOrden 			IN 	NUMBER,
	inuEstado 			IN 	NUMBER,
	inuCausal 			IN 	NUMBER,
	idtFechaCambio 		IN 	DATE,
	onuCodigoError 		OUT NUMBER, 
	osbMensajeError 	OUT VARCHAR2
) 
IS
/*****************************************************************
    Propiedad intelectual de Gases del Caribe

    Unidad         : api_cambioestadoot
    Descripcion    : Api encargado de realizar el cambio de estado de una orden de trabajo
    Autor          : Carlos Gonzalez (Horbath)
    Fecha          : 17/03/2025

    Parámetros              Descripcion
    ============            ===================
    inuOrden              	Numero de la orden
    inuEstado               Estado de la orden
	inuCausal				Causal
	idtFechaCambio			Fecha de cambio de estado
    onuCodigoError          Código de error
    osbMensajeError         Mensaje de error
    
    
    Fecha           Autor       	Modificación
    ==========      ===========     ===================
	17/03/2025      cgonzalez       OSF-4124: Creación
******************************************************************/
    -- Constantes para el control de la traza
    csbMetodo           CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;                -- Constante para nombre de función    
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuOrden: '||inuOrden, csbNivelTraza);
        pkg_traza.trace('inuEstado: '||inuEstado, csbNivelTraza);
        pkg_traza.trace('inuCausal: '||inuCausal, csbNivelTraza);
		pkg_traza.trace('idtFechaCambio: '||idtFechaCambio, csbNivelTraza);
        
        ldc_cambioestado(inuOrden, inuEstado, inuCausal, idtFechaCambio, onuCodigoError, osbMensajeError);
        
        pkg_traza.trace('onuCodigoError: '||onuCodigoError, csbNivelTraza);
        pkg_traza.trace('osbMensajeError: '||osbMensajeError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(onuCodigoError, osbMensajeError);
            pkg_traza.trace('onuCodigoError: '||onuCodigoError, csbNivelTraza);
			pkg_traza.trace('osbMensajeError: '||osbMensajeError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(onuCodigoError, osbMensajeError);
            pkg_traza.trace('onuCodigoError: '||onuCodigoError, csbNivelTraza);
			pkg_traza.trace('osbMensajeError: '||osbMensajeError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
END api_cambioestadoot;
/
begin
    pkg_utilidades.prAplicarPermisos('API_CAMBIOESTADOOT','ADM_PERSON');    
    execute immediate 'GRANT EXECUTE ON ADM_PERSON.API_CAMBIOESTADOOT TO RGISOSF';
end;
/