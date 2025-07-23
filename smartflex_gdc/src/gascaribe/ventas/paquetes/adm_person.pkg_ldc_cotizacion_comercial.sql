CREATE OR REPLACE PACKAGE adm_person.pkg_ldc_cotizacion_comercial IS
  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas
  
  Unidad         : pkg_ldc_cotizacion_comercial
  Descripcion    : Paquete para el acceso a los datos de la tabla 
                    open.ldc_cotizacion_comercial
  Autor          : Lubin Pineda
  Fecha          : 18-06-2025
  Caso           : OSF-4608
  
  Historia de Modificaciones
  Fecha         Autor       Caso        Modificacion
  ===============================================================
  18/06/2025    jpinedc     OSF-4608    Creación
  ******************************************************************/
  
    -- Obtiene el id de la dirección de la cotizacion
    FUNCTION fnuObtieneDireccion(inuCotizacion IN number) 
    RETURN ldc_cotizacion_comercial.id_direccion%TYPE;
      
END pkg_ldc_cotizacion_comercial;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldc_cotizacion_comercial IS

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
  
    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : fnuObtieneDireccion
    Descripcion    : Metodo para Obtener el id de la dirección de la cotizacion
    Autor          : Lubin Pineda
    Fecha          : 18-06-2025
    Caso           : OSF-4555

    Parametros           Descripcion
    ============         ===================

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    ******************************************************************/  
    FUNCTION fnuObtieneDireccion(inuCotizacion IN number) 
    RETURN ldc_cotizacion_comercial.id_direccion%TYPE
    IS
    
        csbMetodo CONSTANT VARCHAR2(100) := csbSP_NAME ||'fnuObtieneDireccion';
  
        nuId_Direccion  ldc_cotizacion_comercial.id_direccion%TYPE;
        
        onuErrorCode    number;
        osbErrorMessage varchar2(4000);  
        
        cursor cuObtieneDireccion is
        select id_direccion
        from ldc_cotizacion_comercial dcc
        where ID_COT_COMERCIAL = inuCotizacion;
        
        PROCEDURE prcCierraCursor
        IS
        BEGIN
        
            IF cuObtieneDireccion%ISOPEN THEN
                CLOSE cuObtieneDireccion;
            END IF;
        
        END prcCierraCursor;
          
    BEGIN

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
        prcCierraCursor;
        
        OPEN cuObtieneDireccion;
        FETCH cuObtieneDireccion INTO nuId_Direccion;
        
        prcCierraCursor;
    
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN nuId_Direccion;

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
            pkg_traza.trace('sberror: ' || OsbErrorMessage, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
            prcCierraCursor;
            RETURN nuId_Direccion;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
            pkg_traza.trace('sberror: ' || OsbErrorMessage,pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
            prcCierraCursor;
            RETURN nuId_Direccion;
    END fnuObtieneDireccion;
    
END pkg_ldc_cotizacion_comercial;
/

BEGIN
    -- OSF-4608
    pkg_utilidades.prAplicarPermisos(upper('pkg_ldc_cotizacion_comercial'),upper('adm_person'));
END;
/