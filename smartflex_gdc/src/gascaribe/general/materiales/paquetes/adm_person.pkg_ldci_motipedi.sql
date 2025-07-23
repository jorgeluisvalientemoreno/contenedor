CREATE OR REPLACE PACKAGE adm_person.pkg_ldci_motipedi IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_ldci_motipedi
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   23/04/2025
    Descripcion :   Paquete para acceso a los datos de adm_person.ldci_motipedi
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     23/04/2025  OSF-4259    Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Obtiene la empresa a la que esta asociado el motivo de venta
    FUNCTION fsbObtEmpresa
    (
        inuMotivoVenta  IN  ldci_motipedi.mopecodi%TYPE
    )
    RETURN ldci_motipedi.empresa%TYPE;


END pkg_ldci_motipedi;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldci_motipedi IS

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
    Programa        : prReferenciaCupon 
    Descripcion     : Retorna una tabla pl con los diferidos con saldo del contrato
                      que tengan plan de alivio por contingencia
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 23/04/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     23/04/2025  OSF-4259 Creacion
    ***************************************************************************/                     
    -- Obtiene la empresa a la que esta asociado el motivo de venta
    FUNCTION fsbObtEmpresa
    (
        inuMotivoVenta  IN  ldci_motipedi.mopecodi%TYPE
    )
    RETURN ldci_motipedi.empresa%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtEmpresa';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
        sbEmpresa       ldci_motipedi.empresa%TYPE;   

        CURSOR cuObtEmpresa
        IS
        SELECT empresa
        FROM ldci_motipedi
        WHERE mopecodi = inuMotivoVenta;
        
        PROCEDURE prcCierraCursor
        IS
            -- Nombre de este mtodo
            csbMetodo1        CONSTANT VARCHAR2(105) := csbMetodo || '.prcCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);        

        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);
            
            IF cuObtEmpresa%ISOPEN THEN
                CLOSE cuObtEmpresa;
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
        
        OPEN cuObtEmpresa;
        FETCH cuObtEmpresa INTO sbEmpresa;
        CLOSE cuObtEmpresa;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbEmpresa;           
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresa;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresa;
    END fsbObtEmpresa;
      
END pkg_ldci_motipedi;
/
Prompt Otorgando permisos sobre adm_person.pkg_ldci_motipedi
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_ldci_motipedi'), 'adm_person');
    
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON adm_person.pkg_ldci_motipedi TO MULTIEMPRESA';
    
END;
/