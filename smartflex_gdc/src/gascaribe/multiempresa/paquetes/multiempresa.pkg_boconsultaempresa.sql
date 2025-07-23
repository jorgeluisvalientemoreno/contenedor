CREATE OR REPLACE PACKAGE multiempresa.pkg_boconsultaempresa IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_boconsultaempresa
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   21/03/2025
    Descripcion :   Paquete con las consultas para obtener la empresa
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     21/03/2025  OSF-4010    Creacion
    jpinedc     10/04/2025  OSF-4204    Se crea fsbMaterialHabilitado	    
    jpinedc     18/06/2025  OSF-4555    * Se crea fsbObtNombreEmpresaContrato
                                        * Se agrega permiso para Reportes
                                        * Se crea fsbObtNombreLocalidad    	
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Obtiene la empresa de un contrato 
    FUNCTION fsbObtEmpresaContrato
    (
        inuContrato     IN  contrato.contrato%TYPE
    )
    RETURN empresa.codigo%TYPE;

    -- Obtiene la empresa de un producto 
    FUNCTION fsbObtEmpresaProducto
    (
        inuProducto     IN  pr_product.product_id%TYPE
    )
    RETURN empresa.codigo%TYPE;

    -- Obtiene la empresa de una dirección
    FUNCTION fsbObtEmpresaDireccion
    (
        inuIdDireccion     IN  ab_address.address_id%TYPE
    )
    RETURN empresa.codigo%TYPE;

    -- Obtiene la empresa de una localidad
    FUNCTION fsbObtEmpresaLocalidad
    (
        inuLocalidad     IN  ge_geogra_location.geograp_location_id%TYPE
    )
    RETURN empresa.codigo%TYPE;

    -- Obtiene la empresa de un departamento
    FUNCTION fsbObtEmpresaDepartamento
    (
        inuDepartamento     IN  ge_geogra_location.geograp_location_id%TYPE
    )
    RETURN empresa.codigo%TYPE;

    -- Obtiene la empresa de un ciclo
    FUNCTION fsbObtEmpresaCiclo
    (
        inuCiclo     IN  ciclo.ciclcodi%TYPE
    )
    RETURN empresa.codigo%TYPE;
    
    -- Obtiene la empresa de un contrato de contratistas
    FUNCTION fsbObtEmpresaGe_Contrato
    (
        inuGe_Contrato  IN  ge_contrato.id_contrato%TYPE  
    )
    RETURN empresa.codigo%TYPE;

    -- Obtiene la empresa de un contratista    
    FUNCTION fsbObtEmpresaContratista
    (
        inuContratista  IN  ge_contratista.id_contratista%TYPE  
    )
    RETURN empresa.codigo%TYPE;

    -- Obtiene la empresa de la unidad operativa    
    FUNCTION fsbObtEmpresaUnidadOper
    (
        inuUnidadOperativa  IN  or_operating_unit.operating_unit_id%TYPE  
    )
    RETURN empresa.codigo%TYPE;
    
    -- Obtiene la empresa de la base administrativa
    FUNCTION fsbObtEmpresaBaseAdmin   
    (
        inuBaseAdministrativa  IN  ge_base_administra.id_base_administra%TYPE 
    )
    RETURN empresa.codigo%TYPE;

    -- Obtiene la empresa del area organizacional    
    FUNCTION fsbObtEmpresaAreaOrg    
    (
        inuAreaOrganizacional  IN  ge_organizat_area.organizat_area_id%TYPE
    )
    RETURN empresa.codigo%TYPE;

    -- Obtiene la empresa del funcionario usuario de SmartFlex   
    FUNCTION fsbObtEmpresaUsuario
    (
        inuFuncionario  IN  ge_person.person_id%TYPE  
    )
    RETURN empresa.codigo%TYPE;
    
    -- Obtiene información general de la empresa
    FUNCTION frcObtInfoEmpresa
    (
        isbEmpresa  IN   empresa.codigo%TYPE
    )
    RETURN empresa%ROWTYPE;
	
    FUNCTION fsbObtEmpresaFactura
	(
		inuIdFactura		IN  factura.factcodi%TYPE
	)
	RETURN VARCHAR2;

    -- Retorna S si el material es usado por la empresa
    FUNCTION fsbMaterialHabilitado
    (
        inuMaterial IN  materiales.material%TYPE,    
        isbEmpresa  IN  materiales.empresa%TYPE
    )
    RETURN VARCHAR2;	
	
    -- Obtiene la empresa de la sucursal bancaria
	FUNCTION fsbObtEmpresaSucursal
	(
		inuCodBanco		IN  sucursal_bancaria.banco%TYPE,
		isbCodSucursal	IN	sucursal_bancaria.sucursal%TYPE
	)
	RETURN VARCHAR2;
	
	-- Obtiene el nombre de la empresa del contrato
	FUNCTION fsbObtNombreEmpresaContrato
    (
        inuContrato     IN  contrato.contrato%TYPE
    )
    RETURN empresa.nombre%TYPE;
    
    -- Obtiene el nombre de la localidad capital de la empresa
    FUNCTION fsbObtNombreLocalidad
    (
        isbEmpresa    IN  empresa.codigo%TYPE
    )
    RETURN ge_geogra_location.description%TYPE;
    
END pkg_boconsultaempresa;
/

CREATE OR REPLACE PACKAGE BODY multiempresa.pkg_boconsultaempresa IS

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
    Fecha           : 21/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     21/03/2025  OSF-4010 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbObtEmpresaContrato 
    Descripcion     : Obtiene la empresa de un contrato 
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 21/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     21/03/2025  OSF-4010 Creacion
    ***************************************************************************/
    FUNCTION fsbObtEmpresaContrato
    (
        inuContrato     IN  contrato.contrato%TYPE
    )
    RETURN empresa.codigo%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtEmpresaContrato';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        sbEmpresaContrato   empresa.codigo%TYPE;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        sbEmpresaContrato := pkg_Contrato.fsbObtieneEmpresa( inuContrato );
       
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbEmpresaContrato;              
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaContrato;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaContrato;
    END fsbObtEmpresaContrato;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbObtEmpresaProducto 
    Descripcion     : Obtiene la empresa de un producto
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 21/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     21/03/2025  OSF-4010 Creacion
    ***************************************************************************/
    FUNCTION fsbObtEmpresaProducto
    (
        inuProducto     IN  pr_product.product_id%TYPE
    )
    RETURN empresa.codigo%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtEmpresaProducto';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        nuContrato          contrato.contrato%TYPE;        
        sbEmpresaProducto   empresa.codigo%TYPE;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        nuContrato  := pkg_bcProducto.fnuContrato( inuProducto );
        
        pkg_traza.trace('nuContrato|'|| nuContrato , csbNivelTraza );
        
        sbEmpresaProducto := pkg_Contrato.fsbObtieneEmpresa( nuContrato );
       
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbEmpresaProducto;              
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaProducto;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaProducto;
    END fsbObtEmpresaProducto;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbObtEmpresaDireccion 
    Descripcion     : Obtiene la empresa de una dirección
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 21/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     21/03/2025  OSF-4010 Creacion
    ***************************************************************************/
    FUNCTION fsbObtEmpresaDireccion
    (
        inuIdDireccion     IN  ab_address.address_id%TYPE
    )
    RETURN empresa.codigo%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtEmpresaDireccion';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
                
        nuDepartamento      ge_geogra_location.geograp_location_id%TYPE;
               
        sbEmpresaDireccion   empresa.codigo%TYPE;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        nuDepartamento  := pkg_BCDirecciones.fnuGetDepartamento( inuIdDireccion );

        pkg_traza.trace('nuDepartamento|'|| nuDepartamento , csbNivelTraza );
       
        sbEmpresaDireccion   := pkg_Empresa.fsbObtEmpresaDepartamento( nuDepartamento );
               
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbEmpresaDireccion;              
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaDireccion;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaDireccion;
    END fsbObtEmpresaDireccion; 

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbObtEmpresaLocalidad 
    Descripcion     : Obtiene la empresa de una localidad
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 21/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     21/03/2025  OSF-4010 Creacion
    ***************************************************************************/    
    FUNCTION fsbObtEmpresaLocalidad
    (
        inuLocalidad     IN  ge_geogra_location.geograp_location_id%TYPE
    )
    RETURN empresa.codigo%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtEmpresaLocalidad';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        nuDepartamento      ge_geogra_location.geograp_location_id%TYPE;
               
        sbEmpresaLocalidad   empresa.codigo%TYPE;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        nuDepartamento  := pkg_BCDirecciones.fnuGetUbicaGeoPadre( inuLocalidad );

        pkg_traza.trace('nuDepartamento'|| nuDepartamento, csbNivelTraza );
       
        sbEmpresaLocalidad   := pkg_Empresa.fsbObtEmpresaDepartamento( nuDepartamento );
               
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbEmpresaLocalidad;              
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaLocalidad;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaLocalidad;
    END fsbObtEmpresaLocalidad;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbObtEmpresaDepartamento 
    Descripcion     : Obtiene la empresa de un departamento
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 21/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     21/03/2025  OSF-4010 Creacion
    ***************************************************************************/    
    FUNCTION fsbObtEmpresaDepartamento
    (
        inuDepartamento     IN  ge_geogra_location.geograp_location_id%TYPE
    )
    RETURN empresa.codigo%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtEmpresaDepartamento';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
                       
        sbEmpresaDepartamento   empresa.codigo%TYPE;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
       
        sbEmpresaDepartamento   := pkg_Empresa.fsbObtEmpresaDepartamento( inuDepartamento );
               
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbEmpresaDepartamento;              
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaDepartamento;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaDepartamento;
    END fsbObtEmpresaDepartamento;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbObtEmpresaCiclo 
    Descripcion     : Obtiene la empresa de un ciclo
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 21/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     21/03/2025  OSF-4010 Creacion
    ***************************************************************************/
    FUNCTION fsbObtEmpresaCiclo
    (
        inuCiclo     IN  ciclo.ciclcodi%TYPE
    )
    RETURN empresa.codigo%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtEmpresaCiclo';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
                       
        sbEmpresaCiclo   empresa.codigo%TYPE;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
       
        sbEmpresaCiclo   := pkg_ciclo_facturacion.fsbObtEmpresa( inuCiclo );
               
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbEmpresaCiclo;              
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaCiclo;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaCiclo;
    END fsbObtEmpresaCiclo;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbObtEmpresaGe_Contrato 
    Descripcion     : Obtiene la empresa de un contrato de contratistas
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 21/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     21/03/2025  OSF-4010    Creacion
    ***************************************************************************/        
    FUNCTION fsbObtEmpresaGe_Contrato
    (
        inuGe_Contrato  IN  ge_contrato.id_contrato%TYPE  
    )
    RETURN empresa.codigo%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtEmpresaGe_Contrato';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
                       
        sbEmpresaGe_Contrato   empresa.codigo%TYPE;
        
        nuContratista       ge_contrato.id_contratista%TYPE;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        nuContratista   := pkg_ge_Contrato.fnuObtId_Contratista( inuGe_Contrato );
        
        pkg_traza.trace('nuContratista|' || nuContratista, csbNivelTraza );
       
        sbEmpresaGe_Contrato   := pkg_contratista.fsbObtEmpresa( nuContratista );
               
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbEmpresaGe_Contrato;              
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaGe_Contrato;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaGe_Contrato;
    END fsbObtEmpresaGe_Contrato;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbObtEmpresaContratista 
    Descripcion     : Obtiene la empresa de un contratista 
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 21/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     21/03/2025  OSF-4010    Creacion
    ***************************************************************************/     
    FUNCTION fsbObtEmpresaContratista
    (
        inuContratista  IN  ge_contratista.id_contratista%TYPE  
    )
    RETURN empresa.codigo%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtEmpresaContratista';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
                       
        sbEmpresaContratista   empresa.codigo%TYPE;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
       
        sbEmpresaContratista   := pkg_contratista.fsbObtEmpresa( inuContratista );
               
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbEmpresaContratista;              
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaContratista;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaContratista;
    END fsbObtEmpresaContratista;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbObtEmpresaUnidadOper 
    Descripcion     : Obtiene la empresa de la unidad operativa  
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 21/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     21/03/2025  OSF-4010    Creacion
    ***************************************************************************/
    FUNCTION fsbObtEmpresaUnidadOper
    (
        inuUnidadOperativa  IN  or_operating_unit.operating_unit_id%TYPE  
    )
    RETURN empresa.codigo%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtEmpresaUnidadOper';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
                       
        sbEmpresaUnidadOperativa   empresa.codigo%TYPE;

        nuBaseAdministrativa    NUMBER;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        nuBaseAdministrativa    :=  pkg_Or_Operating_Unit.fnuObtAdmin_Base_id( inuUnidadOperativa);

        pkg_traza.trace('nuBaseAdministrativa|'|| nuBaseAdministrativa, csbNivelTraza );
       
        sbEmpresaUnidadOperativa   := pkg_Base_Admin.fsbObtieneEmpresa( nuBaseAdministrativa );
               
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbEmpresaUnidadOperativa;              
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaUnidadOperativa;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaUnidadOperativa;
    END fsbObtEmpresaUnidadOper;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbObtEmpresaBaseAdmin 
    Descripcion     : Obtiene la empresa de la base administrativa  
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 21/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     21/03/2025  OSF-4010    Creacion
    ***************************************************************************/    
    FUNCTION fsbObtEmpresaBaseAdmin   
    (
        inuBaseAdministrativa  IN  ge_base_administra.id_base_administra%TYPE 
    )
    RETURN empresa.codigo%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtEmpresaBaseAdmin';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
                       
        sbEmpresaBaseAdmin   empresa.codigo%TYPE;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
       
        sbEmpresaBaseAdmin   := pkg_Base_Admin.fsbObtieneEmpresa( inuBaseAdministrativa );
               
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbEmpresaBaseAdmin;              
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaBaseAdmin;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaBaseAdmin;
    END fsbObtEmpresaBaseAdmin;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbObtEmpresaAreaOrg 
    Descripcion     : Obtiene la empresa del area organizacional  
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 21/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     21/03/2025  OSF-4010    Creacion
    ***************************************************************************/     
    FUNCTION fsbObtEmpresaAreaOrg    
    (
        inuAreaOrganizacional  IN  ge_organizat_area.organizat_area_id%TYPE
    )
    RETURN empresa.codigo%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtEmpresaAreaOrg';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

        nuUnidadOperativa       or_operating_unit.operating_unit_id%TYPE;

        nuBaseAdministrativa    NUMBER;      
                                       
        sbEmpresaAreaOrg   empresa.codigo%TYPE;
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
       
        nuUnidadOperativa       :=  inuAreaOrganizacional;

        pkg_traza.trace('nuUnidadOperativa|'|| nuUnidadOperativa, csbNivelTraza );
            
        IF nuUnidadOperativa IS NOT NULL THEN
                        
            nuBaseAdministrativa    :=  pkg_Or_Operating_Unit.fnuObtAdmin_Base_id( nuUnidadOperativa);

            pkg_traza.trace('nuBaseAdministrativa|'|| nuBaseAdministrativa, csbNivelTraza );
                   
            sbEmpresaAreaOrg    := pkg_Base_Admin.fsbObtieneEmpresa( nuBaseAdministrativa );
                        
        END IF;
               
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbEmpresaAreaOrg;              
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaAreaOrg;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaAreaOrg;
    END fsbObtEmpresaAreaOrg;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbObtEmpresaFuncionario 
    Descripcion     : Obtiene la empresa del funcionario usuario de SmartFlex    
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 21/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     21/03/2025  OSF-4010    Creacion
    ***************************************************************************/
    FUNCTION fsbObtEmpresaUsuario
    (
        inuFuncionario  IN  ge_person.person_id%TYPE  
    )
    RETURN empresa.codigo%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtEmpresaUsuario';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
                       
        sbEmpresaFuncionario   empresa.codigo%TYPE;
        
        nuAreaOrganizacional    NUMBER;
        
        nuUnidadOperativa       or_operating_unit.operating_unit_id%TYPE;
        
        nuBaseAdministrativa    NUMBER;               

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        nuAreaOrganizacional    := pkg_BCPersonal.fnuObtAreaOrganizacional (inuFuncionario);

        pkg_traza.trace('nuAreaOrganizacional|'|| nuAreaOrganizacional, csbNivelTraza );
                
        nuUnidadOperativa       :=  nuAreaOrganizacional;

        pkg_traza.trace('nuUnidadOperativa|'|| nuUnidadOperativa, csbNivelTraza );
            
        IF nuUnidadOperativa IS NOT NULL THEN
                        
            nuBaseAdministrativa    :=  pkg_Or_Operating_Unit.fnuObtAdmin_Base_id( nuUnidadOperativa);

            pkg_traza.trace('nuBaseAdministrativa|'|| nuBaseAdministrativa, csbNivelTraza );
                   
            sbEmpresaFuncionario    := pkg_Base_Admin.fsbObtieneEmpresa( nuBaseAdministrativa );
                        
        END IF;
               
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbEmpresaFuncionario;              
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaFuncionario;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbEmpresaFuncionario;
    END fsbObtEmpresaUsuario;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : frcObtInfoEmpresa 
    Descripcion     : Obtiene información general de la empresa   
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 21/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     21/03/2025  OSF-4010    Creacion
    ***************************************************************************/    
    FUNCTION frcObtInfoEmpresa
    (
        isbEmpresa  IN   empresa.codigo%TYPE
    )
    RETURN empresa%ROWTYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'frcObtInfoEmpresa';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
                       
        rcInfoEmpresa   empresa%ROWTYPE;
                     
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        rcInfoEmpresa := pkg_empresa.frcObtieneRegistro( isbEmpresa );
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN rcInfoEmpresa;              
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN rcInfoEmpresa;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN rcInfoEmpresa;
    END frcObtInfoEmpresa;
	
	
	 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbObtEmpresaFactura 
    Descripcion     : Obtener empresa de una factura 
    Autor           : Jhon Jairo Soto 
    Fecha           : 04/04/2025

	Parametros de entrada
		inuIdFactura 	Id de la factura

	Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
	jsoto		04/04/2025	OSF-4195	Se agrega fsbObtEmpresaFactura
    jsoto		22/04/2025  OSF-4279    Se cambia la consulta para usar el ciclo en vez del contrato    
    ***************************************************************************/ 
    FUNCTION fsbObtEmpresaFactura(inuIdFactura		IN  factura.factcodi%TYPE)
								  RETURN VARCHAR2
	IS

		csbMetodo  		VARCHAR2(70) := csbSP_NAME || 'fsbObtEmpresaFactura';

		nuError				NUMBER;  
		sbError				VARCHAR2(1000);
		sbEmpresa			empresa.codigo%TYPE;
		nuPeriodo			perifact.pefacodi%TYPE;
		nuCiclo				perifact.pefacicl%TYPE;


    BEGIN

		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
		
		nuPeriodo	:= pkg_factura.fnuObtfactpefa(inuIdFactura);
		        
        pkg_traza.trace('nuPeriodo|'|| nuPeriodo , csbNivelTraza );
		
		nuCiclo 	:= pkg_perifact.fnuObtCicloDelPeriodo(nuPeriodo);
        
        sbEmpresa := pkg_ciclo_facturacion.fsbObtEmpresa(nuCiclo);

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
    END fsbObtEmpresaFactura;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbMaterialHabilitado 
    Descripcion     : Retorna S si el material es usado por la empresa  
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 10/04/2025 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     10/04/2025  OSF-4204    Creación 
    ***************************************************************************/ 
    FUNCTION fsbMaterialHabilitado
    (
        inuMaterial IN  materiales.material%TYPE,    
        isbEmpresa  IN  materiales.empresa%TYPE
    )
    RETURN VARCHAR2
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbMaterialHabilitado';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
                       
        sbMaterialHabilitado   materiales.habilitado%TYPE; 
           
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        sbMaterialHabilitado := pkg_materiales.fsbObtHabilitado( inuMaterial, isbEmpresa ); 
            
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbMaterialHabilitado;              
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbMaterialHabilitado;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbMaterialHabilitado;
    END fsbMaterialHabilitado;


    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbObtEmpresaSucursal 
    Descripcion     : Obtener empresa de una sucursal bancaria 
    Autor           : Jhon Jairo Soto 
    Fecha           : 04/04/2025

	Parametros de entrada
		inuCodBanco 	Codigo del Banco
		isbCodSucursal	Codigo de la sucursal

	Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
	jsoto		04/04/2025	OSF-4134	Se agrega fsbObtEmpresaSucursal
    ***************************************************************************/ 
    FUNCTION fsbObtEmpresaSucursal(	inuCodBanco		IN  sucursal_bancaria.banco%TYPE,
									isbCodSucursal	IN	sucursal_bancaria.sucursal%TYPE)
								  RETURN VARCHAR2
	IS

		csbMetodo  		VARCHAR2(70) := csbSP_NAME || 'fsbObtEmpresaSucursal';

		nuError				NUMBER;  
		sbError				VARCHAR2(1000);
		sbEmpresa			empresa.codigo%TYPE;

    BEGIN

		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

		sbEmpresa := pkg_sucursal_bancaria.fsbobtempresa(inuCodBanco,isbCodSucursal);
		
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
    END fsbObtEmpresaSucursal;

	-- Obtiene el nombre de la empresa del contrato
	FUNCTION fsbObtNombreEmpresaContrato
    (
        inuContrato     IN  contrato.contrato%TYPE
    )
    RETURN empresa.nombre%TYPE
	IS

		csbMetodo  		VARCHAR2(70) := csbSP_NAME || 'fsbObtEmpresaSucursal';

		nuError				    NUMBER;  
		sbError				    VARCHAR2(1000);
		sbNombreEmpresaContrato empresa.nombre%TYPE;
		
		sbEmpresaContrato empresa.codigo%TYPE;

    BEGIN    

		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
		
		sbEmpresaContrato := fsbObtEmpresaContrato(inuContrato);

        sbNombreEmpresaContrato := pkg_Empresa.fsbObtNombreEmpresa(sbEmpresaContrato);
		
		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);		    

		RETURN sbNombreEmpresaContrato;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbNombreEmpresaContrato;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbNombreEmpresaContrato;
    END fsbObtNombreEmpresaContrato;

    -- Obtiene el nombre de la localidad capital de la empresa
    FUNCTION fsbObtNombreLocalidad
    (
        isbEmpresa    IN  empresa.codigo%TYPE
    )
    RETURN ge_geogra_location.description%TYPE
	IS

		csbMetodo  		VARCHAR2(70) := csbSP_NAME || 'fsbObtNombreLocalidad';

		nuError				    NUMBER;  
		sbError				    VARCHAR2(1000);
		
		rcEmpresa               empresa%ROWTYPE;
		
		sbNombreLocalidad       ge_geogra_location.description%TYPE;
		
    BEGIN    

		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
		
		rcEmpresa := pkg_Empresa.frcObtieneRegistro(isbEmpresa);

        sbNombreLocalidad := pkg_bcdirecciones.fsbGetDescripcionUbicaGeo(rcEmpresa.Localidad);
		
		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);		    

		RETURN sbNombreLocalidad;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbNombreLocalidad;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbNombreLocalidad;
    END fsbObtNombreLocalidad;    
              
END pkg_boconsultaempresa;
/

Prompt Otorgando permisos sobre multiempresa.pkg_boconsultaempresa
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_boconsultaempresa'), 'multiempresa');
    
    dbms_output.put_line('Otorgando permisos de ejecucion sobre MULTIEMPRESA.pkg_boconsultaempresa a REPORTES');    
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON MULTIEMPRESA.pkg_boconsultaempresa TO REPORTES';    
END;
/