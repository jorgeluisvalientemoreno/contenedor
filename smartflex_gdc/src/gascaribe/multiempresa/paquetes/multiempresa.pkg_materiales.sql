CREATE OR REPLACE PACKAGE multiempresa.pkg_materiales IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_materiales
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   10/04/2025
    Descripcion :   Paquete para el acceso a los datos de multiempresa.materiales
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     10/04/2025  OSF-4204 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;

    -- Retorna Verdadero si el material existe para la empresa
    FUNCTION fblExiste
    (
        inuMaterial IN  materiales.material%TYPE,    
        isbEmpresa  IN  materiales.empresa%TYPE
    )
    RETURN BOOLEAN;
        
    -- Inserta un registro en multiempresa.materiales
    PROCEDURE prcInsRegistro
    (
        inuMaterial     IN  materiales.material%TYPE,    
        isbEmpresa      IN  materiales.empresa%TYPE,
        isbHabilitado   IN  materiales.habilitado%TYPE
    );

    -- Actualiza multiempresa.materiales.habilitado
    PROCEDURE prcActHabilitado
    (
        inuMaterial     IN  materiales.material%TYPE,    
        isbEmpresa      IN  materiales.empresa%TYPE,
        isbHabilitado   IN  materiales.habilitado%TYPE
    );
    
    -- Retorna S si el material es usado por la empresa
    FUNCTION fsbObtHabilitado
    (
        inuMaterial IN  materiales.material%TYPE,    
        isbEmpresa  IN  materiales.empresa%TYPE
    )
    RETURN VARCHAR2;

END pkg_materiales;
/

CREATE OR REPLACE PACKAGE BODY multiempresa.pkg_materiales IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-4204';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 10/04/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     10/04/2025  OSF-4204 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fblExiste 
    Descripcion     : Retorna Verdadero si el material existe para la empresa
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 11/04/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     11/04/2025  OSF-4204 Creacion
    ***************************************************************************/    
    FUNCTION fblExiste
    (
        inuMaterial IN  materiales.material%TYPE,    
        isbEmpresa  IN  materiales.empresa%TYPE
    )
    RETURN BOOLEAN
    IS
    
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
                       
        blExiste        BOOLEAN;

        nuMaterial      materiales.material%TYPE;
        
        CURSOR cuMaterial
        IS
        SELECT material
        FROM materiales
        WHERE material = inuMaterial
        AND empresa = isbEmpresa;
        
        PROCEDURE prcCierraCursor
        IS
            -- Nombre de este mtodo
            csbMetodo1        CONSTANT VARCHAR2(70) := csbMetodo || '.prcCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);
            
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  
                
            IF cuMaterial%ISOPEN THEN
                CLOSE cuMaterial;
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
        
        OPEN cuMaterial;
        FETCH cuMaterial INTO nuMaterial;
        CLOSE cuMaterial;

        blExiste := nuMaterial IS NOT NULL;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN blExiste;             
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN blExiste;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;            
            RETURN blExiste;
    END fblExiste;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prcInsRegistro 
    Descripcion     : Inserta un registro en multiempresa.materiales
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 10/04/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     10/04/2025  OSF-4204 Creacion
    ***************************************************************************/ 
    PROCEDURE prcInsRegistro
    (
        inuMaterial     IN  materiales.material%TYPE,    
        isbEmpresa      IN  materiales.empresa%TYPE,
        isbHabilitado   IN  materiales.habilitado%TYPE
    )
    IS
    
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        INSERT INTO materiales
        (
            material,
            empresa,
            habilitado
        )
        VALUES
        (
            inuMaterial,
            isbEmpresa,
            isbHabilitado
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
    END prcInsRegistro;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prcActHabilitado 
    Descripcion     : Actualiza multiempresa.materiales.habilitado
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 10/04/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     10/04/2025  OSF-4204 Creacion
    ***************************************************************************/
    PROCEDURE prcActHabilitado
    (
        inuMaterial     IN  materiales.material%TYPE,    
        isbEmpresa      IN  materiales.empresa%TYPE,
        isbHabilitado   IN  materiales.habilitado%TYPE
    )
    IS

        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcActHabilitado';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
            
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        UPDATE materiales
        SET habilitado = isbHabilitado
        WHERE material = inuMaterial
        AND empresa = isbEmpresa
        AND habilitado <> isbHabilitado;
        
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
    END prcActHabilitado;    
        
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbObtHabilitado 
    Descripcion     : Retorna S si el material es usado por la empresa
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 10/04/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     10/04/2025  OSF-4204 Creacion
    ***************************************************************************/    
    FUNCTION fsbObtHabilitado
    (
        inuMaterial IN  materiales.material%TYPE,    
        isbEmpresa  IN  materiales.empresa%TYPE
    )
    RETURN VARCHAR2
    IS
    
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtHabilitado';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        sbHabilitado    materiales.habilitado%TYPE;
        
        CURSOR cuObtHabilitado
        IS
        SELECT habilitado
        FROM materiales
        WHERE material = inuMaterial
        AND empresa = isbEmpresa;
        
        PROCEDURE prcCierraCursor
        IS
            -- Nombre de este mtodo
            csbMetodo1        CONSTANT VARCHAR2(70) := csbMetodo || '.prcCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);
            
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  
                
            IF cuObtHabilitado%ISOPEN THEN
                CLOSE cuObtHabilitado;
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
        
        OPEN cuObtHabilitado;
        FETCH cuObtHabilitado INTO sbHabilitado;
        CLOSE cuObtHabilitado;

        sbHabilitado := NVL( sbHabilitado, 'N' );
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbHabilitado;             
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN sbHabilitado;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;            
            RETURN sbHabilitado;
    END fsbObtHabilitado;
      
END pkg_materiales;
/

Prompt Otorgando permisos sobre multiempresa.pkg_materiales
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_materiales'), upper('multiempresa'));
END;
/

