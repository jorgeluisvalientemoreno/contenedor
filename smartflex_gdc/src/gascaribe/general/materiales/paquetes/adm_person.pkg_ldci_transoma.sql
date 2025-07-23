CREATE OR REPLACE PACKAGE ADM_PERSON.pkg_ldci_transoma IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_ldci_transoma
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   23/04/2025
    Descripcion :   Paquete para acceso a los datos de ldci_transoma
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     23/04/2025  OSF-4259 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Obtiene el contratista
    FUNCTION fnuObtContratista
    (
        inuSolicitudMaterial            IN  NUMBER
    )
    RETURN ldci_transoma.trsmcont%TYPE;

END pkg_ldci_transoma;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.pkg_ldci_transoma IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-4259';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 23/04/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     23/04/2025  OSF-4259 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fnuObtContratista 
    Descripcion     : Obtiene el contratista
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 23/04/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     23/04/2025  OSF-4259 Creacion
    ***************************************************************************/
    FUNCTION fnuObtContratista
    (
        inuSolicitudMaterial            IN  NUMBER
    )
    RETURN ldci_transoma.trsmcont%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtContratista';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        nuContratista   ldci_transoma.trsmcont%TYPE;
        
        CURSOR cuObtContratista
        IS
        SELECT trsmcont
        FROM ldci_transoma
        WHERE trsmcodi = inuSolicitudMaterial;
        
        PROCEDURE prcCierraCursor
        IS
            -- Nombre de este mtodo
            csbMetodo1        CONSTANT VARCHAR2(105) := csbMetodo || '.prcCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  
            
            IF cuObtContratista%ISOPEN THEN
                CLOSE cuObtContratista;
            END IF;

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);          
               
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError1,sbError1);        
                pkg_traza.trace('sbError1 => ' || sbError1, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERR);          
                pkg_error.setError;
                pkg_Error.getError(nuError1,sbError1);
                pkg_traza.trace('sbError1 => ' || sbError1, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
        END prcCierraCursor;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        OPEN cuObtContratista;
        FETCH cuObtContratista  INTO nuContratista;
        prcCierraCursor;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN nuContratista;           
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN nuContratista;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN nuContratista;
    END fnuObtContratista;
      
END pkg_ldci_transoma;
/
Prompt Otorgando permisos sobre ADM_PERSON.pkg_ldci_transoma
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_ldci_transoma'), 'ADM_PERSON');
    
    EXECUTE IMMEDIATE ('GRANT EXECUTE ON ADM_PERSON.pkg_ldci_transoma TO MULTIEMPRESA' );
END;
/