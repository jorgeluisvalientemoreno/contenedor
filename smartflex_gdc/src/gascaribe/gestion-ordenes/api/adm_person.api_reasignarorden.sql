CREATE OR REPLACE PROCEDURE adm_person.api_reasignarorden
(
	inuOrden 			IN 	NUMBER,
	inuUnidadOperativa 	IN 	NUMBER,
	idtFechaCambio 		IN 	DATE,
	onuCodigoError 		OUT NUMBER, 
	osbMensajeError 	OUT VARCHAR2
) 
IS
/*****************************************************************
    Propiedad intelectual de Gases del Caribe

    Unidad         : api_reasignarorden
    Descripcion    : Api encargado de realizar la reasignacion de una orden de trabajo
    Autor          : Carlos Gonzalez (Horbath)
    Fecha          : 17/03/2025

    Parámetros              Descripcion
    ============            ===================
    inuOrden              	Numero de la orden
    inuUnidadOperativa		Unidad Operativa
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
        pkg_traza.trace('inuUnidadOperativa: '||inuUnidadOperativa, csbNivelTraza);
		pkg_traza.trace('idtFechaCambio: '||idtFechaCambio, csbNivelTraza);
        
        ldc_os_reassingorder(inuOrden, inuUnidadOperativa, idtFechaCambio, onuCodigoError, osbMensajeError);
        
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
END api_reasignarorden;
/
begin
    pkg_utilidades.prAplicarPermisos('API_REASIGNARORDEN','ADM_PERSON');    
    execute immediate 'GRANT EXECUTE ON ADM_PERSON.API_REASIGNARORDEN TO RGISOSF';
end;
/