CREATE OR REPLACE PACKAGE ADM_PERSON.pkg_BOLDCACD IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Fuente      :   pkg_BOLDCACD
    Autor       :   Lubin Pineda - MVM
    Fecha       :   09/12/2024
    Descripcion :   Paquete para proceso en la forma LDCACD
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     09/12/2024  OSF-3694 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Borra cargos de duplicado de factura pendientes por facturar
    PROCEDURE prcBORRA_CARGOS_DUPL_FACT_PEND
    (
        inuProducto            IN  NUMBER
    );

END pkg_BOLDCACD;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.pkg_BOLDCACD IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-3694';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    -- Cuenta de cobro con cargos pendientes por facturar
    cnuCUENTA_PENDIENTES_FACTURAR   CONSTANT    cuencobr.cucocodi%TYPE  := -1;
    
    -- DUPLICADO DE FACTURA
    cnuCONCEPTO_DUPLICADO_FACTURA   CONSTANT    concepto.conccodi%TYPE  := 24; 

    -- API_REGCHR - API para el registro de cargo a facturar.
    cnuPROCESO_API_REGCHR           CONSTANT    procesos.proccons%TYPE  := 2038; 
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 09/12/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     09/12/2024  OSF-3694 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prcBORRA_CARGOS_DUPL_FACT_PEND 
    Descripcion     : Borra cargos de duplicado de factura pendientes por facturar
    Autor           : Lubin Pineda - MVM 
    Fecha           : 09/12/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     09/12/2024  OSF-3694 Creacion
    ***************************************************************************/                     
    PROCEDURE prcBORRA_CARGOS_DUPL_FACT_PEND
    (
        inuProducto            IN  NUMBER
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcBORRA_CARGOS_DUPL_FACT_PEND';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        pkg_traza.trace('inuProducto|' || inuProducto , csbNivelTraza );         
    
        pkg_Cargos.prBorraCargos
        (
            inuProducto,
            cnuCUENTA_PENDIENTES_FACTURAR, 
            cnuCONCEPTO_DUPLICADO_FACTURA,  
            cnuPROCESO_API_REGCHR 
        );
            
        COMMIT;

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
    END prcBORRA_CARGOS_DUPL_FACT_PEND;
       
END pkg_BOLDCACD;
/

Prompt Otorgando permisos sobre ADM_PERSON.pkg_BOLDCACD
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_BOLDCACD'), 'ADM_PERSON');
END;
/

