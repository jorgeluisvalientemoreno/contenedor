CREATE OR REPLACE PACKAGE multiempresa.pkg_auditoria_contrato IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_auditoria_contrato
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   11/03/2025
    Descripcion :   Paquete
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     11/03/2025  OSF-3956 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Inserta un registro de auditoria en auditoria_contrato
    PROCEDURE prInsRegistro
    (
        inuContrato         IN  contrato.contrato%TYPE,
        isbEvento           IN  VARCHAR2,
        isbEmpresaAnterior  IN  contrato.empresa%TYPE,
        isbEmpresaNueva     IN  contrato.empresa%TYPE,
        isbUsuario          IN  auditoria_contrato.usuario%TYPE DEFAULT pkg_session.getUser,
        isbTerminal         IN  auditoria_contrato.usuario%TYPE DEFAULT pkg_session.fsbgetTerminal
    );


END pkg_auditoria_contrato;
/

CREATE OR REPLACE PACKAGE BODY multiempresa.pkg_auditoria_contrato IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-3956';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 11/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     11/03/2025  OSF-3956 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prInsRegistro 
    Descripcion     : Inserta un registro de auditoria en auditoria_contrato
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 11/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     11/03/2025  OSF-3956 Creacion
    ***************************************************************************/
    PROCEDURE prInsRegistro
    (
        inuContrato         IN  contrato.contrato%TYPE,
        isbEvento           IN  VARCHAR2,
        isbEmpresaAnterior  IN  contrato.empresa%TYPE,
        isbEmpresaNueva     IN  contrato.empresa%TYPE,
        isbUsuario          IN  auditoria_contrato.usuario%TYPE DEFAULT pkg_session.getUser,
        isbTerminal         IN  auditoria_contrato.usuario%TYPE DEFAULT pkg_session.fsbgetTerminal
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        INSERT INTO auditoria_contrato
        (
            contrato,
            evento,
            empresa_anterior,
            empresa_nueva,
            usuario,
            terminal
        )
        VALUES
        (
            inuContrato,
            isbEvento,
            isbEmpresaAnterior,
            isbEmpresaNueva,
            isbUsuario,
            isbTerminal
        );

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
    END prInsRegistro;
      
END pkg_auditoria_contrato;
/
Prompt Otorgando permisos sobre multiempresa.pkg_auditoria_contrato
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_auditoria_contrato'), 'multiempresa');
END;
/