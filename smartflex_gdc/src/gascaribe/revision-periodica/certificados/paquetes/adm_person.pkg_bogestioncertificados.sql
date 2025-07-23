CREATE OR REPLACE PACKAGE adm_person.pkg_bogestioncertificados IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_bogestioncertificados
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   20/01/2025
    Descripcion :   Paquete
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     20/01/2025  OSF-3859 Creacion
    jpinedc     20/01/2025  OSF-3828 Se entrega para GdC
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Anula los certificados pendientes de un producto
    PROCEDURE prcAnulaCertificadosProducto 
    (
        inuProducto     IN  NUMBER,
        inuIdActOrdenes IN  NUMBER      
    );

END pkg_bogestioncertificados;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bogestioncertificados IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-3828';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    cnuTIPO_REF_CUPON   CONSTANT NUMBER(1) := 1;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 20/01/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     20/01/2025  OSF-3859 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prcAnulaCertificadosProducto  
    Descripcion     : Anula los certificados pendientes de un producto
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 20/01/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     20/01/2025  OSF-3859 Creacion
    ***************************************************************************/                     
    PROCEDURE prcAnulaCertificadosProducto 
    (
        inuProducto     IN  NUMBER,
        inuIdActOrdenes IN  NUMBER      
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcAnulaCertificadosProducto ';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        pr_BOCertificate.AnullCertificate( inuProducto, inuIdActOrdenes );
                        
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
    END prcAnulaCertificadosProducto ;
      
END pkg_bogestioncertificados;
/
Prompt Otorgando permisos sobre adm_person.pkg_bogestioncertificados
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_bogestioncertificados'), 'ADM_PERSON');
END;
/