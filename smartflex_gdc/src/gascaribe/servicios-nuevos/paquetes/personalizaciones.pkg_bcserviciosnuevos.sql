CREATE OR REPLACE PACKAGE personalizaciones.pkg_bcserviciosnuevos IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_bcserviciosnuevos
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   09/01/2025
    Descripcion :   Paquete con servicios de consulta sobre Servicios Nuevos
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     09/01/2025  OSF-3828 Creacion
*******************************************************************************/

    nuTipoTrab      number :=  pkg_BCLD_Parameter.fnuObtieneValorNumerico('TT_VEN_INI');
    sbTitrServNue   VARCHAR2(4000) := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_TITRSERNUEV');

    CURSOR cugetOrdeSev( inuProducto NUMBER)
    IS
    SELECT O.ORDER_ID, 
            decode(o.task_type_id,nuTipoTrab, 1,0) ttcert,  
            OA.PACKAGE_ID, 
            pkg_bcsolicitudes.fnuGetTipoSolicitud(oa.package_id) tiposoli, 
            pkg_or_operating_unit.fsbObtE_MAIL(o.operating_unit_id) correo
    FROM or_order o, or_order_activity oa
    WHERE o.order_id = oa.order_id
     AND o.task_type_id IN ( SELECT to_number(regexp_substr(sbTitrServNue,'[^,]+', 1, LEVEL)) AS titr
                             FROM   dual
                             CONNECT BY regexp_substr(sbTitrServNue, '[^,]+', 1, LEVEL) IS NOT NULL)
     AND o.order_status_id NOT IN ( SELECT order_status_id
                                    FROM or_order_status
                                    WHERE IS_FINAL_STATUS = 'Y')
    AND oa.product_id = inuProducto;

    TYPE tytbOrdenServicio IS TABLE OF cugetOrdeSev%ROWTYPE INDEX BY BINARY_INTEGER;
    
    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Obtiene una tabla pl con las ordenes TT Servicio Nuevo no finalizadas
    PROCEDURE prcObtenerOrdenes
    (
        inuProducto         IN  NUMBER,
        otbOrdenServicio    OUT tytbOrdenServicio
    );


END pkg_bcserviciosnuevos;
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bcserviciosnuevos IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-3828';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 09/01/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     09/01/2025  OSF-3828 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prcObtenerOrdenes 
    Descripcion     : Obtiene una tabla pl con las ordenes TT Servicio Nuevo no finalizadas
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 09/01/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     09/01/2025  OSF-3828 Creacion
    ***************************************************************************/                     
    PROCEDURE prcObtenerOrdenes
    (
        inuProducto         IN  NUMBER,
        otbOrdenServicio    OUT tytbOrdenServicio
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcObtenerOrdenes';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        OPEN cugetOrdeSev( inuProducto);
        FETCH cugetOrdeSev BULK COLLECT INTO otbOrdenServicio;
        CLOSE cugetOrdeSev;

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
    END prcObtenerOrdenes;
      
END pkg_bcserviciosnuevos;
/

Prompt Otorgando permisos sobre personalizaciones.pkg_bcserviciosnuevos
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_bcserviciosnuevos'), upper('personalizaciones'));
END;
/

