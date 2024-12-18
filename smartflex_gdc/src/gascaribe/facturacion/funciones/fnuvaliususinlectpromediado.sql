CREATE OR REPLACE FUNCTION open.fnuValiUsuSinLectPromediado  RETURN  NUMBER IS
/*****************************************************************
    Propiedad intelectual de Gases del Caribe

    Unidad         : fnuValiUsuSinLectPromediado
    Descripcion    : Funcion encargada de obtener contrato y hacer llamado a funcion encargada de validar si 
                     productos de contrato tuvieron consumo promedio a raíz de ajustes a reglas 
                     de lectura y relectura realizados bajo el caso OSF-2190 
    Autor          :
    Fecha          :

    Parámetros              Descripcion
    ============            ===================
        
    Fecha           Autor               Modificación
    =========       =========           ====================
	23-01-2024      jcatuchemvm         OSF-2231: Creación
******************************************************************/
    -- Constantes para el control de la traza
    csbMetodo           CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;                -- Constante para nombre de función    
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
    --Variables generales
    sberror             VARCHAR2(4000);
    nuerror             NUMBER;
    nuValida            NUMBER;
    sbValida            VARCHAR2(1);
    nuContrato          NUMBER;
    sbContrato          GE_BOINSTANCECONTROL.STYSBVALUE;
    
    
BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE('NOTIFICATION_INSTANCE',NULL,'CONTRACT','SUBSCRIPTION_ID',sbContrato);
        pkg_traza.trace('CONTRACT.SUBSCRIPTION_ID: ' || sbContrato, csbNivelTraza);
        nuContrato := UT_CONVERT.FNUCHARTONUMBER(sbContrato);
        
        sbValida := fsbValiUsuSinLectPromediado(nuContrato);
        
        IF sbValida = 'S' THEN
            nuValida := 1;
        ELSE
            nuValida := 0;
        END IF;
        
        pkg_traza.trace('return => '||nuValida, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        return nuValida;
        
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            nuValida := 0;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace('return => '||nuValida, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            return nuValida;
        WHEN OTHERS THEN
            nuValida := 0;
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace('return => '||nuValida, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            return nuValida;
END fnuValiUsuSinLectPromediado;
/
begin
    pkg_utilidades.prAplicarPermisos('FNUVALIUSUSINLECTPROMEDIADO','OPEN');
end;
/