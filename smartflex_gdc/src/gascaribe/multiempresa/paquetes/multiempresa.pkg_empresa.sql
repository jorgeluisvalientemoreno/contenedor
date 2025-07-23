CREATE OR REPLACE PACKAGE multiempresa.pkg_empresa IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_empresa
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   06/02/2025
    Descripcion :   Paquete de acceso a los datos de multiempresa.empresa
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     06/02/2025  OSF-3940    Creacion
    jpinedc     20/02/2025  OSF-3956    Se crea fsbObtEmpresaDepartamento
    jpinedc     26/03/2025  OSF-4010    Se cambia el nombre la funcion
                                        prObtieneRegisto 
                                        por frcObtieneRegistro
    cgonzalez   28/03/2025  OSF-4010    Se crea frcObtieneInfoEmpresas
    jpinedc     23/04/2025  OSF-4259    Se crea fsbObtOrganizacionVenta
    jpinedc     17/06/2025  OSF-4555    * Se crea fsbObtNombreEmpresa
                                        * Se crea fsbObtNitEmpresa
                                        * Se crea fsbObtDireccionEmpresa
                                        * Se agrega permiso para Reportes
*******************************************************************************/

    TYPE tytbInfoEmpresas IS TABLE OF empresa%ROWTYPE INDEX BY empresa.codigo%TYPE;

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Retorna un registro de la tabla empresa
    FUNCTION frcObtieneRegistro(isbCodigo   empresa.codigo%TYPE)
    RETURN empresa%ROWTYPE;

    -- Retorna el mnemonico de la empresa para el departamento
    FUNCTION fsbObtEmpresaDepartamento
    (
        inuDepartamento IN  ge_geogra_location.geograp_location_id%TYPE
    ) RETURN empresa.codigo%TYPE;
    
    -- Retorna todos los registros de la entidad EMPRESA
    FUNCTION frcObtieneInfoEmpresas
    RETURN tytbInfoEmpresas;
    
    -- Obtiene la organizacion de venta para la empresa
    FUNCTION fsbObtOrganizacionVenta(isbEmpresa   empresa.codigo%TYPE)
    RETURN empresa.organizacion_venta%TYPE;

    -- Obtiene el nombre de la empresa
    FUNCTION fsbObtNombreEmpresa(isbEmpresa   empresa.codigo%TYPE)
    RETURN empresa.nombre%TYPE;
    
    -- Obtiene el nit de la empresa
    FUNCTION fsbObtNitEmpresa(isbEmpresa   empresa.codigo%TYPE)
    RETURN empresa.nit%TYPE;  

    -- Obtiene la direccion de la empresa
    FUNCTION fsbObtDireccionEmpresa(isbEmpresa   empresa.codigo%TYPE)
    RETURN empresa.direccion%TYPE;  
    
END pkg_empresa;
/

CREATE OR REPLACE PACKAGE BODY multiempresa.pkg_empresa IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-4555';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 06/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     06/02/2025  OSF-3940 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : frcObtieneRegistro 
    Descripcion     : Retorna un registro de la tabla empresa
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 06/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     06/02/2025  OSF-3940    Creacion
    jpinedc     26/03/2025  OSF-4010    Se cambia el nombre la funcion
                                        prObtieneRegisto 
                                        por frcObtieneRegistro    
    ***************************************************************************/                     
    FUNCTION frcObtieneRegistro(isbCodigo   empresa.codigo%TYPE)
    RETURN empresa%ROWTYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'frcObtieneRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        rcEmpresa   empresa%ROWTYPE;
        
        CURSOR cuEmpresa
        IS
        SELECT *
        FROM empresa
        where codigo = isbCodigo;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        OPEN cuEmpresa;
        FETCH cuEmpresa INTO rcEmpresa;
        CLOSE cuEmpresa;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
           
        RETURN rcEmpresa;
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN rcEmpresa;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN rcEmpresa;
    END frcObtieneRegistro;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbEmpresaDepartamento 
    Descripcion     : Retorna el mnemonico de la empresa para el departamento
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 17/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     17/02/2025  OSF-3956 Creacion
    ***************************************************************************/
    FUNCTION fsbObtEmpresaDepartamento
    (
        inuDepartamento IN  ge_geogra_location.geograp_location_id%TYPE
    ) RETURN empresa.codigo%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtEmpresaDepartamento';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
        sbEmpresa       empresa.codigo%TYPE;
        
        CURSOR cuEmpresa( inuDepart ge_geogra_location.geograp_location_id%TYPE)
        IS
        SELECT codigo
        FROM empresa
        WHERE departamento = inuDepart;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        OPEN cuEmpresa( inuDepartamento );
        FETCH cuEmpresa INTO sbEmpresa;
        CLOSE cuEmpresa;
        
        sbEmpresa := NVL( sbEmpresa, 'GDCA' );
                       
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
    END fsbObtEmpresaDepartamento;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : frcObtieneInfoEmpresas 
    Descripcion     : Retorna todos los registros de la entidad EMPRESA
    Autor           : Carlos Gonzalez - Horbath
    Fecha           : 28/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    cgonzalez   28/03/2025  OSF-4010    Creacion
    ***************************************************************************/
    FUNCTION frcObtieneInfoEmpresas
    RETURN tytbInfoEmpresas
    IS
        -- Nombre de este metodo
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'frcObtieneInfoEmpresas';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

        nuIndice    BINARY_INTEGER;
        TYPE tytbEmpresas IS TABLE OF empresa%ROWTYPE INDEX BY BINARY_INTEGER;
        
        tbInfoEmpresas            tytbEmpresas;
        tbInfoEmpresasOrdenadas   tytbInfoEmpresas;
        
        CURSOR cuInfoEmpresas IS
            SELECT *
            FROM empresa;
    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        OPEN cuInfoEmpresas;
        FETCH cuInfoEmpresas BULK COLLECT INTO tbInfoEmpresas;
        CLOSE cuInfoEmpresas;
        
        nuIndice := tbInfoEmpresas.FIRST;
        
        IF (nuIndice IS NOT NULL) THEN
            LOOP
                EXIT WHEN nuIndice IS NULL;
                
                tbInfoEmpresasOrdenadas(tbInfoEmpresas(nuIndice).codigo) := tbInfoEmpresas(nuIndice);
                
                nuIndice := tbInfoEmpresas.NEXT(nuIndice);
            END LOOP;
        END IF;
        
        pkg_traza.trace('tbInfoEmpresasOrdenadas.COUNT => ' || tbInfoEmpresasOrdenadas.COUNT, csbNivelTraza );
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
           
        RETURN tbInfoEmpresasOrdenadas;
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN tbInfoEmpresasOrdenadas;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN tbInfoEmpresasOrdenadas;
    END frcObtieneInfoEmpresas;
    
    -- Obtiene la organizacion de venta para la empresa
    FUNCTION fsbObtOrganizacionVenta(isbEmpresa   empresa.codigo%TYPE)
    RETURN empresa.organizacion_venta%TYPE
    IS
        -- Nombre de este metodo
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtOrganizacionVenta';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

        CURSOR cuObtOrganizacionVenta
        IS
        SELECT organizacion_venta
        FROM empresa
        WHERE codigo = isbEmpresa;
        
        sbOrganizacionVenta empresa.organizacion_venta%TYPE;

        PROCEDURE prcCierraCursor(isbCodigo   empresa.codigo%TYPE)
        IS
            -- Nombre de este metodo
            csbMetodo1       CONSTANT VARCHAR2(70) := csbMetodo || '.prcCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);
            
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);    

            IF cuObtOrganizacionVenta%ISOPEN THEN
                CLOSE cuObtOrganizacionVenta;
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

        OPEN cuObtOrganizacionVenta;
        FETCH cuObtOrganizacionVenta INTO sbOrganizacionVenta;
        CLOSE cuObtOrganizacionVenta;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbOrganizacionVenta;
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbOrganizacionVenta;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbOrganizacionVenta;
    END fsbObtOrganizacionVenta;        

    -- Obtiene el nombre la empresa
    FUNCTION fsbObtNombreEmpresa(isbEmpresa   empresa.codigo%TYPE)
    RETURN empresa.nombre%TYPE
    IS
        -- Nombre de este metodo
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtNombreEmpresa';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

        CURSOR cubObtNombre
        IS
        SELECT nombre
        FROM empresa
        WHERE codigo = isbEmpresa;
        
        sbNombre empresa.nombre%TYPE;

        PROCEDURE prcCierraCursor
        IS
            -- Nombre de este metodo
            csbMetodo1       CONSTANT VARCHAR2(70) := csbMetodo || '.prcCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);
            
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);    

            IF cubObtNombre%ISOPEN THEN
                CLOSE cubObtNombre;
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

        prcCierraCursor;
        
        OPEN cubObtNombre;
        FETCH cubObtNombre INTO sbNombre;
        
        prcCierraCursor;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbNombre;
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN sbNombre;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN sbNombre;
    END fsbObtNombreEmpresa;        
    
    -- Obtiene el nit de la empresa
    FUNCTION fsbObtNitEmpresa(isbEmpresa   empresa.codigo%TYPE)
    RETURN empresa.nit%TYPE
    IS
        -- Nombre de este metodo
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtNitEmpresa';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

        CURSOR cuObtNitEmpresa
        IS
        SELECT nit
        FROM empresa
        WHERE codigo = isbEmpresa;
        
        sbNit empresa.nit%TYPE;

        PROCEDURE prcCierraCursor
        IS
            -- Nombre de este metodo
            csbMetodo1       CONSTANT VARCHAR2(70) := csbMetodo || '.prcCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);
            
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);    

            IF cuObtNitEmpresa%ISOPEN THEN
                CLOSE cuObtNitEmpresa;
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

        prcCierraCursor;
        
        OPEN cuObtNitEmpresa;
        FETCH cuObtNitEmpresa INTO sbNit;
        
        prcCierraCursor;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbNit;
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN sbNit;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN sbNit;
    END fsbObtNitEmpresa;       

    -- Obtiene la direccion de la empresa
    FUNCTION fsbObtDireccionEmpresa(isbEmpresa   empresa.codigo%TYPE)
    RETURN empresa.direccion%TYPE
    IS
        -- Nombre de este metodo
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtDireccionEmpresa';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

        CURSOR cuObtDireccionEmpresa
        IS
        SELECT direccion
        FROM empresa
        WHERE codigo = isbEmpresa;
        
        sbDireccion empresa.direccion%TYPE;

        PROCEDURE prcCierraCursor
        IS
            -- Nombre de este metodo
            csbMetodo1       CONSTANT VARCHAR2(70) := csbMetodo || '.prcCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);
            
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);    

            IF cuObtDireccionEmpresa%ISOPEN THEN
                CLOSE cuObtDireccionEmpresa;
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

        prcCierraCursor;
        
        OPEN cuObtDireccionEmpresa;
        FETCH cuObtDireccionEmpresa INTO sbDireccion;
        
        prcCierraCursor;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbDireccion;
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN sbDireccion;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN sbDireccion;
    END fsbObtDireccionEmpresa;          
                          
END pkg_empresa;
/

Prompt Otorgando permisos sobre multiempresa.pkg_empresa
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('PKG_EMPRESA'), 'MULTIEMPRESA');

    dbms_output.put_line('Otorgando permisos de ejecucion sobre MULTIEMPRESA.PKG_EMPRESA a REPORTES');    
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON MULTIEMPRESA.PKG_EMPRESA TO REPORTES';
    
END;
/