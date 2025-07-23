CREATE OR REPLACE PACKAGE adm_person.pkg_ldci_registrainterfaz IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_ldci_registrainterfaz
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   21/01/2025
    Descripcion :   Paquete de acceso a datos de la tabla ldci_registrainterfaz
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     21/01/2025  OSF-3879 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Actualiza datos dado el codigo de la interfaz contable
    PROCEDURE prActDatosConCodigoInterfaz
    (
        inuCodigoInterfaz       IN  ldci_registrainterfaz.ldcodinterf%TYPE, 
        isbContabiliza          IN  ldci_registrainterfaz.ldflagcontabi%TYPE,
        isbUsuarioActualizacion IN  ldci_registrainterfaz.userupdate%TYPE DEFAULT USER,
        idtFechaActualizacion   IN  ldci_registrainterfaz.fechaupdate%TYPE DEFAULT SYSDATE,
        isbTerminal             IN  ldci_registrainterfaz.terminalupdate%TYPE DEFAULT USERENV('TERMINAL')
    );

END pkg_ldci_registrainterfaz;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldci_registrainterfaz IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-3879';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 21/01/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     21/01/2025  OSF-3879 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prActDatosConCodigoInterfaz 
    Descripcion     : Actualiza datos dado el codigo de la interfaz contable
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 21/01/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     21/01/2025  OSF-3879 Creacion
    ***************************************************************************/
    PROCEDURE prActDatosConCodigoInterfaz
    (
        inuCodigoInterfaz       IN  ldci_registrainterfaz.ldcodinterf%TYPE, 
        isbContabiliza          IN  ldci_registrainterfaz.ldflagcontabi%TYPE,
        isbUsuarioActualizacion IN  ldci_registrainterfaz.userupdate%TYPE DEFAULT USER,
        idtFechaActualizacion   IN  ldci_registrainterfaz.fechaupdate%TYPE DEFAULT SYSDATE,
        isbTerminal             IN  ldci_registrainterfaz.terminalupdate%TYPE DEFAULT USERENV('TERMINAL')
    )
        IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prActDatosConCodigoInterfaz';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        UPDATE ldci_registrainterfaz 
        SET ldflagcontabi = isbContabiliza, 
            userupdate = isbUsuarioActualizacion, 
            fechaupdate = idtFechaActualizacion,
            terminalupdate = isbTerminal
        WHERE ldcodinterf = inuCodigoInterfaz;
            
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
    END prActDatosConCodigoInterfaz;    
      
END pkg_ldci_registrainterfaz;
/
Prompt Otorgando permisos sobre adm_person.pkg_ldci_registrainterfaz
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_ldci_registrainterfaz'), upper('adm_person'));
END;
/