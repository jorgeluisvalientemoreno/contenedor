CREATE OR REPLACE FUNCTION personalizaciones.fnuPermiteFacturar(inuSubscriptionId   suscripc.susccodi%type)  RETURN  NUMBER IS
/*****************************************************************
    Propiedad intelectual de Gases del Caribe

    Unidad         : fnuPermiteFacturar
    Descripcion    : Funcion encargada de Validar si la hora del sistema es menor que la configurada 
                     en el párametro HORA_RESTRICCION_FINANCIACION. 
                     Retorna
                      1 si la hora es valida para creación de notas/facturas 
                      0 si la hora no es válido para creación de notas/facturas.
                    Si el contrato se encuentra en la tabla OMITIR_FACTURA_TEMP  con el flag CONDICION en Y, 
                    se debe omitir la validación y retornar 1. Esta tabla se crea de parte de Sebastian Tapias.
    Autor          : Dsaltarin
    Fecha          :29/07/2024

    Parámetros              Descripcion
    ============            ===================
        
    Fecha           Autor               Modificación
    =========       =========           ====================
	29-07-2024      dsaltarin         OSF-3038: Creación
******************************************************************/
    -- Constantes para el control de la traza
    csbMetodo           CONSTANT VARCHAR2(32)       :='FNUPERMITEFACTURAR';                -- Constante para nombre de función    
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
    --Variables generales
    sberror             varchar2(4000);
    nuerror             number;
    nuPermiteFac        number := 1;
    nuHoraActual        number;
    nuHoraRestriccion   parametros.valor_numerico%type:=PKG_PARAMETROS.fnuGetValorNumerico('HORA_RESTRICCION_FINANCIACION');
    sbOmitirValid       omitir_factura_temp.condicion%type := 'N';
    
    cursor cuOmiteRestriccion(nuContrato suscripc.susccodi%type) is
    select condicion 
      into sbOmitirValid 
      from omitir_factura_temp 
     where idcontrato = nuContrato;
BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);

        pkg_traza.trace('inuSubscriptionId: ' || inuSubscriptionId, pkg_traza.cnuNivelTrzDef);
        nuHoraActual := to_number(to_char(sysdate,'hh24'));
        pkg_traza.trace('nuHoraRestriccion: ' || nuHoraRestriccion, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('nuHoraActual: ' || nuHoraActual, pkg_traza.cnuNivelTrzDef);
        
        if cuOmiteRestriccion%isopen then
            close cuOmiteRestriccion;
        end if;

        open cuOmiteRestriccion(inuSubscriptionId);
        fetch cuOmiteRestriccion into sbOmitirValid;
        if cuOmiteRestriccion%notfound then 
            sbOmitirValid := 'N';
        end if;
        close cuOmiteRestriccion;
            
        pkg_traza.trace('sbOmitirValid: ' || sbOmitirValid, pkg_traza.cnuNivelTrzDef);
        if sbOmitirValid = 'N' then
            if nuHoraActual >= nuHoraRestriccion  then 
                nuPermiteFac := 0;
            else
                nuPermiteFac := 1;
            end if;
        else
            nuPermiteFac := 1;
        end if;
        
        pkg_traza.trace('return => '||nuPermiteFac, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        return nuPermiteFac;
        
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            nuPermiteFac := 0;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace('return => '||nuPermiteFac, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            return nuPermiteFac;
        WHEN OTHERS THEN
            nuPermiteFac := 0;
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace('return => '||nuPermiteFac, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            return nuPermiteFac;
END fnuPermiteFacturar;
/
begin
    pkg_utilidades.prAplicarPermisos('FNUPERMITEFACTURAR','PERSONALIZACIONES');
end;
/