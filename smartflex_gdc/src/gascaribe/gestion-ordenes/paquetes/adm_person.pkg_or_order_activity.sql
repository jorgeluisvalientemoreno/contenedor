CREATE OR REPLACE PACKAGE adm_person.pkg_or_order_activity IS
    /*******************************************************************************
        Propiedad Intelectual de Gases del Caribe
        
        Programa  : pkg_or_order_activity
        Autor       : Luis Felipe Valencia Hurtado
        Fecha       : 12-03-2024
        Descripcion : Paquete con servicios CRUD sobre la entidad OPEN.OR_ORDER_ACTIVITY
        
        Modificaciones  :
        Autor                 Fecha         Caso        Descripcion
        felipe.valencia       12-03-2024    OSF-2623    Creacion
        jose.pineda           09-07-2024    OSF-2204    Se crea prActComNovedadesOrden
    *******************************************************************************/

    FUNCTION fsbVersion RETURN VARCHAR2;
    
    PROCEDURE prcactualizaDireccActividad
    (
        inuOrden     IN or_order.order_id%type,
        isbDireccion IN or_order.external_address_id%type,
        onuError     OUT NUMBER,
        osbError     OUT VARCHAR2
    );

    --procedimiento que se encarga de actualizar sector operativo de la orden
    PROCEDURE prcActualizaSectorOperativo(inuOrden           IN or_order.order_id%type,
                                        inuSectorOperativo IN or_order.operating_sector_id%type,
                                        onuError           OUT NUMBER,
                                        osbError           OUT VARCHAR2);

    -- Actualiza la actividad de la ordene de novedad
    PROCEDURE prActActivOrdenNovedad( inuOrden              IN  or_order_activity.order_id%type,
                                        isbComment_         IN  or_order_activity.comment_%type,
                                        inuValorReferencia  IN  or_order_activity.value_reference%type,
                                        onuError            OUT NUMBER,
                                        osbError            OUT VARCHAR2                                      
                                     );

END pkg_or_order_activity;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_or_order_activity IS

    -- Constantes para el control de la traza
    csbSP_NAME CONSTANT VARCHAR2(100) := $$PLSQL_UNIT;

    -- Identificador del ultimo caso que hizo cambios
    csbVersion CONSTANT VARCHAR2(15) := 'OSF-2204';
    
    -- Tipo de novedad
    cnuTipoNovedad CONSTANT NUMBER := 14;

    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
        Autor         : Luis Felipe Valencia Hurtado
        Fecha         : 12-03-2024
    
        Modificaciones  :
        Autor           Fecha       Caso      Descripcion
        felipe.valencia     12-03-2024  OSF-2623  Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        
    Programa        : prc_ActualizaDireccionActividad
        Descripcion     : Actualizar la dirección de la actividad de la orden
    
        Autor         :   Luis Felipe Valencia Hurtado
        Fecha         :   12-03-2024
    
        Parametros de Entrada
        inuOrden          Identificador de la orden
        isbDireccion    Identificador de la Direccion
        Parametros de Salida
        onuError       codigo de error
        osbError       mensaje de error
        
    Modificaciones  :
        Autor           Fecha       Caso      Descripcion
        felipe.valencia     12-03-2024  OSF-2623  Creación
    ***************************************************************************/
    PROCEDURE prcactualizaDireccActividad(inuOrden     IN or_order.order_id%type,
                                            isbDireccion IN or_order.external_address_id%type,
                                            onuError     OUT NUMBER,
                                            osbError     OUT VARCHAR2) IS
        csbMT_NAME VARCHAR2(100) := csbSP_NAME ||
                                    '.prcactualizaDireccActividad';
    BEGIN
        pkg_traza.trace(csbMT_NAME,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden => ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('isbDireccion => ' || isbDireccion,
                        pkg_traza.cnuNivelTrzDef);
        pkg_error.prInicializaError(onuError, osbError);
    
        UPDATE or_order_activity
        SET address_id = isbDireccion
        WHERE order_id = inuOrden;
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(onuError, osbError);
        pkg_traza.trace(' osbError => ' || osbError,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(onuError, osbError);
        pkg_traza.trace(' osbError => ' || osbError,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERR);
    END prcactualizaDireccActividad;

    /**************************************************************************
    Autor       : Ernesto Santiago / Horbath
    Fecha       : 13/03/2024
    Ticket      : OSF-2411
    Proceso     : prcActualizaSectorOperativo
    Descripcion : procedimiento que se encarga de actualizar sector operativo de la orden
    
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE prcActualizaSectorOperativo(inuOrden           IN or_order.order_id%type,
                                            inuSectorOperativo IN or_order.operating_sector_id%type,
                                            onuError           OUT NUMBER,
                                            osbError           OUT VARCHAR2) IS
        csbMT_NAME VARCHAR2(100) := csbSP_NAME ||
                                    '.prcActualizaSectorOperativo';
    BEGIN
        pkg_traza.trace(csbMT_NAME,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbINICIO);
        pkg_traza.trace('Orden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('Sector Operativo: ' || inuSectorOperativo,
                        pkg_traza.cnuNivelTrzDef);
        pkg_error.prInicializaError(onuError, osbError);
    
        UPDATE or_order_activity
        SET operating_sector_id = inuSectorOperativo
        WHERE order_id = inuOrden;
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(onuError, osbError);
        pkg_traza.trace(' osbError => ' || osbError,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(onuError, osbError);
        pkg_traza.trace(' osbError => ' || osbError,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERR);
    END prcActualizaSectorOperativo;
    
    -- Actualiza la actividad de la ordene de novedad
    PROCEDURE prActActivOrdenNovedad( inuOrden              IN  or_order_activity.order_id%type,
                                        isbComment_         IN  or_order_activity.comment_%type,
                                        inuValorReferencia  IN  or_order_activity.value_reference%type,
                                        onuError            OUT NUMBER,
                                        osbError            OUT VARCHAR2                                      
                                     )
    IS
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prActActivOrdenNovedad';
          
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
        UPDATE or_order_activity
        SET comment_        =  isbComment_ ,
            value_reference = inuValorReferencia       
        WHERE 
            order_id = inuOrden;        
        
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_Error.getError(onuError, osbError);
            pkg_traza.trace('onuError: ' || onuError || ', ' || 'osbError: ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        WHEN others THEN
            Pkg_Error.seterror;
            pkg_error.geterror(onuError, osbError);
            pkg_traza.trace('onuError: ' || onuError || ', ' || 'osbError: ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END prActActivOrdenNovedad;                                         

END pkg_or_order_activity;
/

BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_OR_ORDER_ACTIVITY', 'ADM_PERSON');
END;
/

