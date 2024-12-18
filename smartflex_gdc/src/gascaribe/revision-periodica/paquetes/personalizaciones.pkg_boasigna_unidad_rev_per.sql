CREATE OR REPLACE PACKAGE PERSONALIZACIONES.pkg_BOASIGNA_UNIDAD_REV_PER IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    Paquete     :   pkg_BOASIGNA_UNIDAD_REV_PER
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   25-09-2024
    Descripcion :   Paquete con los objetos del negocio para asignar ordenes
                    a unidades de revisión periódica
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     25-09-2024  OSF-3368    Creacion
    jpinedc     28-10-2024  OSF-3532    Se ajusta por cambios en 
                                        PKG_LDC_ASIGNA_UNIDAD_REV_PER  
*******************************************************************************/

    -- Retona Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
        
    -- Inserta en LDC_ASIGNA_UNIDAD_REV_PER
    PROCEDURE prcBuscaUnidadReparaciones
    (
        inuProducto     IN  pr_product.product_id%TYPE,
        inuSolicitud    IN  mo_packages.package_id%TYPE
    );

END pkg_BOASIGNA_UNIDAD_REV_PER;
/

CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.pkg_BOASIGNA_UNIDAD_REV_PER IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-3368';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    cnuCON_DEFECTOS_OIA     CONSTANT ldc_marca_producto.suspension_type_id%TYPE := 104;
    
    cnuTT_SUSP_CM_REV_PERI  CONSTANT or_order.task_type_id%TYPE :=10450;
    
    cnuTT_REPA_DEFE_CRIT_RP CONSTANT or_order.task_type_id%TYPE :=10833;
    
    cnuCAUS_SERV_SUSP_CM    CONSTANT or_order.causal_id%TYPE    := 9809; 
    
    csbTOKEN_LEGA_ORDEN     CONSTANT VARCHAR2(20):= 'LEGALIZACION ORDEN[';

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 01-12-2022 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     01-12-2022  OSF-740 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcBuscaUnidadReparaciones 
    Descripcion     : Inserta en LDC_ASIGNA_UNIDAD_REV_PER
    
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 25-09-2024 
    
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     25-09-2024  OSF-3368    Creacion
    ***************************************************************************/                     
    PROCEDURE prcBuscaUnidadReparaciones
    (
        inuProducto     IN  pr_product.product_id%TYPE,
        inuSolicitud    IN  mo_packages.package_id%TYPE
    )
    IS
        csbMetodo                   CONSTANT VARCHAR2(70) :=  csbSP_NAME || 'prcInsLDC_ASIGNA_UNIDAD_REV_PER';
        nuError                     NUMBER;
        sbError                     VARCHAR2(4000);
            
        nuMarcaProducto             ldc_marca_producto.suspension_type_id%TYPE;
        
        nuIdActivOrdenSusp          pr_product.suspen_ord_act_id%TYPE;

        nuOrdenSusp                 or_order.order_id%TYPE;
        
        nuTiTrOrdenSusp             or_order.task_type_id%TYPE;
        
        nuSoliSusp                  mo_packages.package_id%TYPE;
                
        nuOrdEnComeSoliSusp         or_order.order_id%TYPE;
        
        nuTiTrOrdEnComeSoliSusp     or_order.task_type_id%TYPE;
        
        nuCauOrdEnComeSoliSusp      or_order.causal_id%TYPE;
        
        nuUnidadOperOrdenSusp       or_order.operating_unit_id%TYPE;
        
        rcldc_asigna_unidad_rev_per ldc_asigna_unidad_rev_per%ROWTYPE;
            
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 

        pkg_traza.trace('inuProducto|'|| inuProducto, csbNivelTraza); 
            
        nuMarcaProducto := pkg_BCProducto.fnuObtieneMarcaProducto( inuProducto );
        
        pkg_traza.trace('nuMarcaProducto|'|| nuMarcaProducto, csbNivelTraza); 
                
        CASE nuMarcaProducto WHEN cnuCON_DEFECTOS_OIA THEN

            pkg_traza.trace('nuMarcaProducto('|| nuMarcaProducto || ') = cnuCON_DEFECTOS_OIA(' || cnuCON_DEFECTOS_OIA || ')' , csbNivelTraza); 
        
            nuIdActivOrdenSusp := pkg_BCProducto.fnuIdActivOrdenSusp( inuProducto );

            pkg_traza.trace('nuIdActivOrdenSusp|'|| nuIdActivOrdenSusp, csbNivelTraza);
            
            CASE WHEN nuIdActivOrdenSusp IS NOT NULL THEN
            
                nuOrdenSusp := pkg_BCOrdenes.fnuObtieneOrdenDeActividad(nuIdActivOrdenSusp);

                pkg_traza.trace('nuOrdenSusp|'|| nuOrdenSusp, csbNivelTraza);
                    
                nuTiTrOrdenSusp := pkg_BCOrdenes.fnuObtieneTipoTrabajo(nuOrdenSusp);

                pkg_traza.trace('nuTiTrOrdenSusp|'|| nuTiTrOrdenSusp, csbNivelTraza);        
                
                CASE nuTiTrOrdenSusp WHEN cnuTT_SUSP_CM_REV_PERI THEN

                    pkg_traza.trace('nuTiTrOrdenSusp('|| nuTiTrOrdenSusp || ') = cnuTT_SUSP_CM_REV_PERI(' || cnuTT_SUSP_CM_REV_PERI || ')' , csbNivelTraza); 
                 
                    nuSoliSusp := pkg_BCOrdenes.fnuObtieneSolicitud(nuOrdenSusp);

                    pkg_traza.trace('nuSoliSusp|'|| nuSoliSusp, csbNivelTraza);  
                                    
                    nuOrdEnComeSoliSusp   := pkg_BCSolicitudes.fnuObtieneOrdenEnComentario ( nuSoliSusp );

                    pkg_traza.trace('nuOrdEnComeSoliSusp|'|| nuOrdEnComeSoliSusp, csbNivelTraza);
                        
                    nuTiTrOrdEnComeSoliSusp := pkg_BCOrdenes.fnuObtieneTipoTrabajo(nuOrdEnComeSoliSusp);

                    pkg_traza.trace('nuTiTrOrdEnComeSoliSusp|'|| nuTiTrOrdEnComeSoliSusp, csbNivelTraza);        
                
                    CASE WHEN nuTiTrOrdEnComeSoliSusp = cnuTT_REPA_DEFE_CRIT_RP THEN

                        pkg_traza.trace('nuTiTrOrdEnComeSoliSusp('|| nuTiTrOrdEnComeSoliSusp || ') = cnuTT_REPA_DEFE_CRIT_RP(' || cnuTT_REPA_DEFE_CRIT_RP ||')', csbNivelTraza); 
                    
                        nuCauOrdEnComeSoliSusp := pkg_BCOrdenes.fnuObtieneCausal( nuOrdEnComeSoliSusp );

                        pkg_traza.trace('nuCauOrdEnComeSoliSusp|'|| nuCauOrdEnComeSoliSusp, csbNivelTraza); 
                        
                        CASE WHEN nuCauOrdEnComeSoliSusp  = cnuCAUS_SERV_SUSP_CM THEN 
                        
                            pkg_traza.trace('nuCauOrdEnComeSoliSusp(' || nuCauOrdEnComeSoliSusp || ') = cnuCAUS_SERV_SUSP_CM(' || cnuCAUS_SERV_SUSP_CM || ')',  csbNivelTraza); 
                        
                            nuUnidadOperOrdenSusp := pkg_BCOrdenes.fnuObtieneUnidadOperativa(nuOrdenSusp);

                            pkg_traza.trace('nuUnidadOperOrdenSusp|'|| nuUnidadOperOrdenSusp, csbNivelTraza); 
                        
                            rcldc_asigna_unidad_rev_per.UNIDAD_OPERATIVA    := nuUnidadOperOrdenSusp;
                            rcldc_asigna_unidad_rev_per.PRODUCTO            := inuProducto;
                            rcldc_asigna_unidad_rev_per.TIPO_TRABAJO        := cnuTT_REPA_DEFE_CRIT_RP;
                            rcldc_asigna_unidad_rev_per.ORDEN_TRABAJO       := nuOrdEnComeSoliSusp;
                            rcldc_asigna_unidad_rev_per.SOLICITUD_GENERADA  := inuSolicitud;

                            pkg_ldc_asigna_unidad_rev_per.prinsRegistro( rcldc_asigna_unidad_rev_per );

                        ELSE
                                pkg_traza.trace('nuCauOrdEnComeSoliSusp(' || nuCauOrdEnComeSoliSusp || ') <> cnuCAUS_SERV_SUSP_CM(' || cnuCAUS_SERV_SUSP_CM || ')',  csbNivelTraza); 
                        END CASE;
                    ELSE
                        pkg_traza.trace('nuTiTrOrdEnComeSoliSusp('|| nuTiTrOrdEnComeSoliSusp || ') <> cnuTT_REPA_DEFE_CRIT_RP(' || cnuTT_REPA_DEFE_CRIT_RP ||')', csbNivelTraza); 
                    END CASE;
                ELSE    
                    pkg_traza.trace('nuTiTrOrdenSusp('|| nuTiTrOrdenSusp || ') <> cnuTT_SUSP_CM_REV_PERI(' || cnuTT_SUSP_CM_REV_PERI || ')' , csbNivelTraza); 
                END CASE;
            ELSE
                    pkg_traza.trace('El producto '|| inuProducto || ' no tiene actividad de orden suspensión en pr_product' , csbNivelTraza);             
            END CASE;
        ELSE
            pkg_traza.trace('nuMarcaProducto('|| nuMarcaProducto || ') <> cnuCON_DEFECTOS_OIA(' || cnuCON_DEFECTOS_OIA || ')' , csbNivelTraza); 
        END CASE;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;      
    END prcBuscaUnidadReparaciones;
   
END pkg_BOASIGNA_UNIDAD_REV_PER;
/

Prompt Otorgando permisos sobre PERSONALIZACIONES.pkg_BOASIGNA_UNIDAD_REV_PER
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_BOASIGNA_UNIDAD_REV_PER'), 'PERSONALIZACIONES');
END;
/

