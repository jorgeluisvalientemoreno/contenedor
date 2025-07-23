CREATE OR REPLACE PROCEDURE adm_person.API_ActualizaCiclo(inuContrato IN NUMBER, inuCiclo IN NUMBER, inuOrden IN NUMBER, onuCodigoError OUT NUMBER, osbMensajeError OUT VARCHAR2) IS
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
	17/12/2024      jcatuche            OSF-3758: Se agrega parámetro inuOrden, se ajusta cursor cuproductos para restringir productos retirados
                                        Se agrega cursor cuDireccion para obtener información del predio y la dirección del producto de gas activo para el contrato
                                        Se agregan validación adicionales
                                        Se agrega llamado a procedimiento de integración ldci_pkg_bointegragis.prccambiociclo para actualizar ciclo en Gis
	05/05/2025      jpinedc             OSF-4299: Se valida que la empresa del contrato sea igual a la empresa del ciclo 
******************************************************************/
    -- Constantes para el control de la traza
    csbMetodo           CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;                -- Constante para nombre de función    
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
    --Variables generales
    nuerror             NUMBER;
    sberror             VARCHAR2(4000);
    nuServicioGas       parametros.valor_numerico%type := pkg_parametros.fnuGetValorNumerico('SERVICIO_GAS_CLM');
    
    cursor cuCiclo is
    select ciclcodi,ciclcico
    from ciclo 
    where ciclcodi = inuCiclo;
    
    cursor cuproductos (inususc in number) is
    select sesususc,sesunuse,sesuserv,sesuesco,sesucicl,sesucico
    from servsusc
    where sesususc = inususc
    and not exists
    (
        select 'x'
        from pr_product
        where product_id = sesunuse
        and subscription_id = sesususc
        and product_status_id in (3,16)
    );
    
    type typrod is table of cuproductos%rowtype index by binary_integer;
    tbprod          typrod;
    
    nuciclcodi      NUMBER;
    nuciclcons      NUMBER;
    
    nuContrato      NUMBER;
    
    cursor cuDireccion (inususc in number) is
    select p.subscription_id,p.product_id,p.product_type_id,p.product_status_id,p.address_id,a.estate_number
    from pr_product p,ab_address a
    where subscription_id = inususc
    and a.address_id = p.address_id
    and p.product_type_id = nuServicioGas
    and p.product_status_id not in (3,16);
    
    rcDireccion     cuDireccion%rowtype;
    
    clRespuesta     clob;
    
    sbEmpresaContrato       empresa.codigo%TYPE;
    sbEmpresaCicloDestino   empresa.codigo%TYPE; 
    
BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuContrato <= '||inuContrato, csbNivelTraza);
        pkg_traza.trace('inuCiclo    <= '||inuCiclo, csbNivelTraza);
        pkg_traza.trace('inuOrden    <= '||inuOrden, csbNivelTraza);
        
        --Inicialización variables
        pkg_error.prInicializaError(onuCodigoError,osbMensajeError);
        
        --Cierre cursores
        if cuCiclo%isopen then 
            close cuCiclo;
        end if;
        
        if cuproductos%isopen then 
            close cuproductos;
        end if;
        
        if cuDireccion%isopen then 
            close cuDireccion;
        end if;
        
        --validación del contrato
        IF NOT pkg_bccontrato.fblExiste(inuContrato) then
            sberror := 'El contrato '||inuContrato||' no existe en la BD';
            pkg_Error.setErrorMessage( isbMsgErrr => sberror);
        END IF;
        
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
        
        --Validación de la orden
        PKG_OR_ORDER.prValExiste(inuOrden);
        
        sbEmpresaContrato := pkg_BOConsultaEmpresa.fsbObtEmpresaContrato( inuContrato );
        IF  sbEmpresaContrato IS NULL THEN
            sberror := 'El contrato['|| inuContrato ||'] no esta asociado a una empresa';
            pkg_Error.setErrorMessage( isbMsgErrr => sberror);        
        END IF;        
        
        sbEmpresaCicloDestino := pkg_BOConsultaEmpresa.fsbObtEmpresaCiclo ( inuCiclo );
        IF  sbEmpresaCicloDestino IS NULL THEN
            sberror := 'El ciclo['|| inuCiclo ||'] no esta asociado a una empresa';
            pkg_Error.setErrorMessage( isbMsgErrr => sberror);        
        END IF;     
        
        -- Valida que la empresa del contrato sea igual a la empresa del ciclo
        IF  sbEmpresaContrato <> sbEmpresaCicloDestino             
        THEN
            sberror := 'La empresa [' || sbEmpresaContrato || '] del contrato ['|| inuContrato ||'] es diferente a la empresa [' || sbEmpresaCicloDestino || '] del ciclo [' || inuCiclo ||']';
            pkg_Error.setErrorMessage( isbMsgErrr => sberror);        
        END IF;
        
        IF NOT fblValidaProcesoFact(inuContrato,onuCodigoError,osbMensajeError) THEN
           
            
            --Validación de productos a actualizar
            tbprod.delete;
            open cuproductos (inuContrato);
            fetch cuproductos bulk collect into tbprod;
            close cuproductos;
            
            if tbprod.count = 0 then
                sberror := 'Para el contrato '||inuContrato||' no hay productos activos para actualizar ciclo';
                pkg_Error.setErrorMessage( isbMsgErrr => sberror);
            end if;
            
            --Obtiene predio y dirección servicio gas            
            rcDireccion := null;
            open cuDireccion(inuContrato);
            fetch cuDireccion into rcDireccion;
            close cuDireccion;
            
            if rcDireccion.product_id is null then
                sberror := 'No fue posible determinar un producto activo de Gas para el contrato '||inuContrato;
                pkg_Error.setErrorMessage( isbMsgErrr => sberror);
            end if;
            
            ldci_pkg_bointegragis.prccambiociclo
            (
                rcDireccion.estate_number,  --identificador del predio
                rcDireccion.address_id,     --identificador de la dirección
                nuciclcodi,                 --identificador del ciclo a cambiar
                inuOrden,                   --identificador de la orden
                clRespuesta,                --Clob respuesta
                nuerror,
                sberror
            );
            
            if nuerror != constants_per.ok then
                pkg_Error.setErrorMessage( isbMsgErrr => 'Error integración GIS: '||sberror);
            end if;
            
            --Actualización de ciclo a productos del contrato
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