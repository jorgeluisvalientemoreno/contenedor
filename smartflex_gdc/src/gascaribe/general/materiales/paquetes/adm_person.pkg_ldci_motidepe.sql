CREATE OR REPLACE PACKAGE ADM_PERSON.pkg_ldci_motidepe IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_ldci_motidepe
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   23/04/2025
    Descripcion :   Paquete
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     23/04/2025  OSF-4259 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Obtiene la empresa del motivo
    FUNCTION fsbObtEmpresa
    (
        inuMotivoPedido            IN  ldci_motidepe.mdpecodi%TYPE
    )
    RETURN ldci_motidepe.empresa%TYPE;

END pkg_ldci_motidepe;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.pkg_ldci_motidepe IS

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
    Descripcion     : Obtiene la empresa del motivo
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 23/04/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     23/04/2025  OSF-4259 Creacion
    ***************************************************************************/
    FUNCTION fsbObtEmpresa
    (
        inuMotivoPedido            IN  ldci_motidepe.mdpecodi%TYPE
    )
    RETURN ldci_motidepe.empresa%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtEmpresa';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        sbEmpresa   ldci_motidepe.empresa%TYPE;
        
        CURSOR cuObtEmpresa
        IS
        SELECT empresa
        FROM ldci_motidepe
        WHERE mdpecodi = inuMotivoPedido;
        
        PROCEDURE prcCierraCursor
        IS
            -- Nombre de este mtodo
            csbMetodo1        CONSTANT VARCHAR2(105) := csbSP_NAME || 'prcCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);
        BEGIN

            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
            
            IF cuObtEmpresa%ISOPEN THEN
                CLOSE cuObtEmpresa;
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
        END prcCierraCursor;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        OPEN cuObtEmpresa;
        FETCH cuObtEmpresa  INTO sbEmpresa;
        prcCierraCursor;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbEmpresa;           
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN sbEmpresa;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN sbEmpresa;
    END fsbObtEmpresa;
      
END pkg_ldci_motidepe;
/
Prompt Otorgando permisos sobre ADM_PERSON.pkg_ldci_motidepe
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_ldci_motidepe'), 'ADM_PERSON');
    
    EXECUTE IMMEDIATE ('GRANT EXECUTE ON ADM_PERSON.pkg_ldci_motidepe TO MULTIEMPRESA' );
END;
/