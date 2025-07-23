CREATE OR REPLACE PACKAGE multiempresa.pkg_contrato IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_contrato
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   07/02/2025
    Descripcion :   Paquete
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     07/02/2025  OSF-3956    Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Retorna verdadero si el contrato ya existe en multiempresa.contrato
    FUNCTION fblExiste( inuContrato     IN  contrato.contrato%TYPE )
    RETURN BOOLEAN;
    
    -- Inserta un registro en multiempresa.contrato
    PROCEDURE prInsRegistro
    (
        inuContrato     IN  contrato.contrato%TYPE,
        isbEmpresa      IN  contrato.empresa%TYPE          
    );

    -- Retorna la empresa a la que esta asociado un contrato
    FUNCTION fsbObtieneEmpresa
    (
        inuContrato     IN  contrato.contrato%TYPE         
    )
    RETURN contrato.empresa%type;
    
    -- Actualiza la empresa a la que está asociada el contrato
    PROCEDURE prcActualizaEmpresa
    (
        inuContrato IN  contrato.contrato%TYPE,
        isbEmpresa  IN  contrato.empresa%TYPE
    );

END pkg_contrato;
/

CREATE OR REPLACE PACKAGE BODY multiempresa.pkg_contrato IS

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
    Fecha           : 07/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/02/2025  OSF-3956 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fblExiste 
    Descripcion     : Retorna verdadero si el contrato ya existe en multiempresa.contrato
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 07/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/02/2025  OSF-3956 Creacion
    ***************************************************************************/
    FUNCTION fblExiste( inuContrato     IN  contrato.contrato%TYPE )
    RETURN BOOLEAN
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        blExiste        BOOLEAN;
        
        CURSOR cuContrato
        IS
        SELECT contrato
        FROM contrato
        WHERE contrato = inuContrato;
        
        nuContrato  NUMBER;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
                
        OPEN cuContrato;
        FETCH cuContrato INTO nuContrato;
        CLOSE cuContrato;
        
        blExiste := nuContrato IS NOT NULL;
        
        RETURN blExiste;
     
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN blExiste;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN blExiste;
    END fblExiste;
        
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prInsRegistro 
    Descripcion     : Inserta un registro en multiempresa.contrato
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 07/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/02/2025  OSF-3956 Creacion
    ***************************************************************************/                     
    PROCEDURE prInsRegistro
    (
        inuContrato     IN  contrato.contrato%TYPE,
        isbEmpresa      IN  contrato.empresa%TYPE          
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        INSERT INTO contrato
        (
            contrato,
            empresa
        )
        values
        (
            inuContrato,
            isbEmpresa
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

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prInsRegistro 
    Descripcion     : Retorna la empresa a la que esta asociado un contrato
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 07/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/02/2025  OSF-3956 Creacion
    ***************************************************************************/  
    FUNCTION fsbObtieneEmpresa
    (
        inuContrato     IN  contrato.contrato%TYPE         
    )
    RETURN contrato.empresa%type
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtieneEmpresa';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        sbEmpresa       contrato.empresa%TYPE;
        
        CURSOR cuEmpresa
        IS
        SELECT empresa
        FROM contrato
        WHERE contrato = inuContrato;
            
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        OPEN cuEmpresa;
        FETCH cuEmpresa INTO sbEmpresa;
        CLOSE cuEmpresa;  
            
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
    END fsbObtieneEmpresa;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prcActualizaEmpresa 
    Descripcion     : Actualiza la empresa a la que esta asociado un contrato
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 07/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/02/2025  OSF-3956 Creacion
    ***************************************************************************/  
    PROCEDURE prcActualizaEmpresa
    (
        inuContrato IN  contrato.contrato%TYPE,
        isbEmpresa  IN  contrato.empresa%TYPE
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcActualizaEmpresa';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        UPDATE contrato
        SET empresa = isbEmpresa
        WHERE contrato = inuContrato
        AND empresa <> isbEmpresa;
                
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
    END prcActualizaEmpresa;
           
              
END pkg_contrato;
/

Prompt Otorgando permisos sobre multiempresa.pkg_contrato
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_contrato'), upper('multiempresa'));
END;
/

