CREATE OR REPLACE PACKAGE adm_person.pkg_ldci_actacont IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_ldci_actacont
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   21/01/2025
    Descripcion :   Paquete acceso a datos de la tabla ldci_actacont
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     21/01/2025  OSF-3879 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Actualiza datos dado el codigo de la interfaz contable
    PROCEDURE prActDatosConCodigoInterfaz
    (
        inuCodigoInterfaz   IN  ldci_actacont.codocont%TYPE, 
        isbContabiliza      IN  ldci_actacont.actcontabiliza%TYPE,
        isbUsuario          IN  ldci_actacont.usuario%TYPE DEFAULT USER,
        idtFechaContabiliza IN  ldci_actacont.fechcontabiliza%TYPE DEFAULT SYSDATE
    );

END pkg_ldci_actacont;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldci_actacont IS

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
    Descripcion     : Retorna una tabla pl con los diferidos con saldo del contrato
                      que tengan plan de alivio por contingencia
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 21/01/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     21/01/2025  OSF-3879 Creacion
    ***************************************************************************/
    -- Actualiza datos dado el codigo de la interfaz contable
    PROCEDURE prActDatosConCodigoInterfaz
    (
        inuCodigoInterfaz   IN  ldci_actacont.codocont%TYPE, 
        isbContabiliza      IN  ldci_actacont.actcontabiliza%TYPE,
        isbUsuario          IN  ldci_actacont.usuario%TYPE DEFAULT USER,
        idtFechaContabiliza IN  ldci_actacont.fechcontabiliza%TYPE DEFAULT SYSDATE
    )
        IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prActDatosConCodigoInterfaz';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        UPDATE ldci_actacont 
        SET actcontabiliza = isbContabiliza, 
            usuario = isbUsuario, 
            fechcontabiliza = idtFechaContabiliza
        WHERE codocont = inuCodigoInterfaz;
            
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
      
END pkg_ldci_actacont;
/

Prompt Otorgando permisos sobre adm_person.pkg_ldci_actacont
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_ldci_actacont'), 'adm_person');
END;
/

