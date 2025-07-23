CREATE OR REPLACE PACKAGE multiempresa.pkg_base_admin IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_base_admin
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   19/02/2024
    Descripcion :   Paquete para acceso a los datos de multiempresa.base_admin
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     19/02/2024  OSF-3988 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;

    -- Retorna verdadero si ya existe el registro en base_admin
    FUNCTION fblExiste
    (
        inuBaseAdministrativa   IN  base_admin.base_administrativa%TYPE
    )
    RETURN BOOLEAN;        
    
    -- Ingresa un registro en  multiempresa.base_admin
    PROCEDURE prcInsRegistro
    (
        inuBaseAdministrativa   IN  base_admin.base_administrativa%TYPE,
        isbEmpresa              IN  base_admin.empresa%TYPE
    );

    -- Retorna la empresa asociada a la base administrativa
    FUNCTION fsbObtieneEmpresa
    (
        inuBaseAdministrativa   IN  base_admin.base_administrativa%TYPE
    )
    RETURN base_admin.empresa%TYPE;

END pkg_base_admin;
/

CREATE OR REPLACE PACKAGE BODY multiempresa.pkg_base_admin IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-3988';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 19/02/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     19/02/2024  OSF-3988 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fblExiste 
    Descripcion     : Retorna verdadero si ya existe un registro en base_admin
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 19/02/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     19/02/2024  OSF-3988 Creacion
    ***************************************************************************/
    FUNCTION fblExiste
    (
        inuBaseAdministrativa   IN  base_admin.base_administrativa%TYPE
    )    
    RETURN BOOLEAN
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        blExiste        BOOLEAN;
        
        nuBaseAdministrativa        base_admin.base_administrativa%TYPE;
        
        CURSOR cuBaseAdmin
        IS
        SELECT ba.base_administrativa
        FROM base_admin ba
        WHERE ba.base_administrativa = inuBaseAdministrativa;
        
        PROCEDURE prCierraCursor
        IS
            -- Nombre de este mtodo
            csbMetodo1        CONSTANT VARCHAR2(105) := csbMetodo || '.prCierraCursor';
            nuError         NUMBER;
            sbError         VARCHAR2(4000);        
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO); 
            
            IF cuBaseAdmin%ISOPEN THEN
                CLOSE cuBaseAdmin;
            END IF;
        
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);                 

        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);        
                pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERR);          
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;        
        END prCierraCursor;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
             
        OPEN cuBaseAdmin;
        FETCH cuBaseAdmin INTO nuBaseAdministrativa;
        CLOSE cuBaseAdmin;
        
        blExiste    := nuBaseAdministrativa IS NOT NULL;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
         
        RETURN blExiste;           
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prCierraCursor;
            RETURN blExiste;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prCierraCursor;
            RETURN blExiste;
    END fblExiste;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prcInsRegistro 
    Descripcion     : Ingresa un registro en  multiempresa.base_admin
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 19/02/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     19/02/2024  OSF-3988 Creacion
    ***************************************************************************/
    PROCEDURE prcInsRegistro
    (
        inuBaseAdministrativa   IN  base_admin.base_administrativa%TYPE,
        isbEmpresa              IN  base_admin.empresa%TYPE
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        INSERT INTO base_admin
        (
            base_administrativa,
            empresa
        )
        VALUES
        (
            inuBaseAdministrativa,
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
    END prcInsRegistro;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbObtieneEmpresa 
    Descripcion     : Retorna la empresa asociada a la base administrativa
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 19/02/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     19/02/2024  OSF-3988 Creacion
    ***************************************************************************/
    FUNCTION fsbObtieneEmpresa
    (
        inuBaseAdministrativa   IN  base_admin.base_administrativa%TYPE
    )    
    RETURN base_admin.empresa%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtieneEmpresa';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        sbEmpresa        base_admin.empresa%TYPE;
        
        CURSOR cuEmpresa
        IS
        SELECT empresa
        FROM base_admin ba
        WHERE ba.base_administrativa = inuBaseAdministrativa;
        
        PROCEDURE prCierraCursor
        IS
            -- Nombre de este mtodo
            csbMetodo1        CONSTANT VARCHAR2(105) := csbMetodo || '.prCierraCursor';
            nuError         NUMBER;
            sbError         VARCHAR2(4000);        
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO); 
            
            IF cuEmpresa%ISOPEN THEN
                CLOSE cuEmpresa;
            END IF;
        
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);                 

        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);        
                pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERR);          
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;        
        END prCierraCursor;
      
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
            prCierraCursor;
            RETURN sbEmpresa;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prCierraCursor;
            RETURN sbEmpresa;
    END fsbObtieneEmpresa;        
              
END pkg_base_admin;
/

Prompt Otorgando permisos sobre multiempresa.pkg_base_admin
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_base_admin'), upper('multiempresa'));
END;
/

