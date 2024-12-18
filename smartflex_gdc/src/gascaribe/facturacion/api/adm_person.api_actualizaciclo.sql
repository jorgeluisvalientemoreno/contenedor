CREATE OR REPLACE PROCEDURE adm_person.API_ActualizaCiclo(inuContrato IN NUMBER, inuCiclo IN NUMBER, onuCodigoError OUT NUMBER, osbMensajeError OUT VARCHAR2) IS
/*****************************************************************
    Propiedad intelectual de Gases del Caribe

    Unidad         : API_ActualizaCiclo
    Descripcion    : Api encargado de actualizar ciclo de facturación a contrato y productos del contrato para uso desde el GIS
    Autor          :
    Fecha          :

    Parámetros              Descripcion
    ============            ===================
    inuContrato              Número del contrato
    inuCiclo                 Ciclo a cambiar
    onuCodigoError           Código de error
    osbMensajeError          Mensaje de error
    
    
    Fecha           Autor               Modificación
    =========       =========           ====================
	14-06-2024      jcatuche            OSF-2685: Creación
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
    
    cursor cuCiclo is
    select ciclcodi,ciclcico
    from ciclo 
    where ciclcodi = inuCiclo;
    
    cursor cuproductos (inususc in number) is
    select sesususc,sesunuse,sesuserv,sesuesco,sesucicl,sesucico
    from servsusc
    where sesususc = inususc;
    
    type typrod is table of cuproductos%rowtype index by binary_integer;
    tbprod          typrod;
    
    nuciclcodi      NUMBER;
    nuciclcons      NUMBER;
    
BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuContrato <= '||inuContrato, csbNivelTraza);
        pkg_traza.trace('inuCiclo    <= '||inuCiclo, csbNivelTraza);
        
        --Inicialización variables
        pkg_error.prInicializaError(onuCodigoError,osbMensajeError);
        
        --Cierre cursores
        if cuCiclo%isopen then 
            close cuCiclo;
        end if;
        
        if cuproductos%isopen then 
            close cuproductos;
        end if;
        
        IF NOT pkg_bccontrato.fblExiste(inuContrato) then
            sberror := 'El contrato '||inuContrato||' no existe en la BD';
            pkg_Error.setErrorMessage( isbMsgErrr => sberror);
        END IF;
        
        IF NOT fblValidaProcesoFact(inuContrato,onuCodigoError,osbMensajeError) THEN
            --Validación de ciclo 
            nuciclcodi := null;
            nuciclcons := null;
            open cuCiclo;
            fetch cuCiclo into nuciclcodi,nuciclcons;
            close cuCiclo;
            
            if nuciclcodi is null or nuciclcons is null then
                sberror := 'El ciclo '||inuCiclo||' no existe en la BD';
                pkg_Error.setErrorMessage( isbMsgErrr => sberror);
            end if;
            
            --Actualización de ciclo a productos del contrato
            tbprod.delete;
            open cuproductos (inuContrato);
            fetch cuproductos bulk collect into tbprod;
            close cuproductos;
            
            for i in 1..tbprod.count loop
                --Actualización de ciclos a producto
                Pkg_Producto.prActualizaCiclos(tbprod(i).sesunuse,nuciclcodi,nuciclcons);
            end loop;
            --Actualización de ciclo a contrato
            pkg_suscripc.prActualizaCiclo(inuContrato,nuciclcodi);
        
        END IF;
        
        pkg_traza.trace('onuCodigoError     => '||onuCodigoError, csbNivelTraza);
        pkg_traza.trace('osbMensajeError    => '||osbMensajeError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(onuCodigoError, osbMensajeError);
            pkg_traza.trace('onuCodigoError     => '||onuCodigoError, csbNivelTraza);
            pkg_traza.trace('osbMensajeError    => '||osbMensajeError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(onuCodigoError, osbMensajeError);
            pkg_traza.trace('onuCodigoError     => '||onuCodigoError, csbNivelTraza);
            pkg_traza.trace('osbMensajeError    => '||osbMensajeError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
END API_ActualizaCiclo;
/
begin
    pkg_utilidades.prAplicarPermisos('API_ACTUALIZACICLO','ADM_PERSON');    
    execute immediate 'GRANT EXECUTE ON ADM_PERSON.API_ACTUALIZACICLO TO RGISOSF';
end;
/