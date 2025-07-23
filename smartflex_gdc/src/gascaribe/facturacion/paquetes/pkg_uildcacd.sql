CREATE OR REPLACE PACKAGE pkg_UILDCACD IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Fuente      :   pkg_UILDCACD
    Autor       :   Lubin Pineda - MVM
    Fecha       :   09/12/2024
    Descripcion :   Paquete de usado por el PB LDCACD
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     09/12/2024  OSF-3694 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Ejecuta el proceso de LDCACD
    PROCEDURE prcObjeto;

END pkg_UILDCACD;
/

CREATE OR REPLACE PACKAGE BODY pkg_UILDCACD IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-3694';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

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
    Programa        : prcValidaProducto 
    Descripcion     : Valida el producto digitado en LDCACD    
    Autor           : Lubin Pineda - MVM 
    Fecha           : 09/12/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     09/12/2024  OSF-3694 Creacion
    ***************************************************************************/
    PROCEDURE prcValidaProducto( onuProducto    OUT pr_product.product_id%TYPE)
    IS

        -- Nombre de este metodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcValidaProducto';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
            
        cnuNULL_ATTRIBUTE constant number := 2126;

    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        onuProducto := ge_boInstanceControl.fsbGetFieldValue ('SERVSUSC', 'SESUNUSE');

        IF (onuProducto is null) THEN
            pkg_Error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Numero de producto:');
        END IF;
        
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
    END prcValidaProducto;
        
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prcObjeto 
    Descripcion     : Ejecuta el proceso de LDCACD
    Autor           : Lubin Pineda - MVM 
    Fecha           : 09/12/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     09/12/2024  OSF-3694 Creacion
    ***************************************************************************/                     
    PROCEDURE prcObjeto
    IS
        -- Nombre de este metodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcObjeto';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        nuProducto      pr_product.product_id%TYPE;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        prcValidaProducto( nuProducto );
                
        pkg_BOLDCACD.prcBORRA_CARGOS_DUPL_FACT_PEND( nuProducto );  

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
    END prcObjeto;
       
END pkg_UILDCACD;
/

Prompt Otorgando permisos sobre pkg_UILDCACD
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_UILDCACD'), 'OPEN');
END;
/

