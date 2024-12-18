CREATE OR REPLACE PACKAGE personalizaciones.pkg_bcordenes_servicios_inge IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bcordenes_servicios_inge
    Autor       :   Luis Felipe Valencia Hurtado
    Fecha       :   29-01-2024
    Descripcion :   Paquete con los metodos para manejo de información de generación  
                    de ordenes del venta de servicios de ingeniería

    Modificaciones  :
    Autor                   Fecha        Caso       Descripcion
    Felipe.valencia         29-01-2024   OSF-2197   Creación
*******************************************************************************/
    -- Retorna la causal de la orden
	FUNCTION fsbVersion 
	RETURN VARCHAR2;

    FUNCTION fnuConsultaOrdenActividad
    ( 
        inuProducto     IN  or_order_activity.product_id%TYPE,
        inuActividad    IN  or_task_types_items.items_id%TYPE
    ) 
    RETURN or_order.order_id%TYPE;

END pkg_bcordenes_servicios_inge;

/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bcordenes_servicios_inge IS

	-- Constantes para el control de la traza
	csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
    csbNivelTraza           CONSTANT NUMBER(2)     := pkg_traza.fnuNivelTrzDef;
	
	-- Identificador del ultimo caso que hizo cambios
	csbVersion     CONSTANT VARCHAR2(15) := 'OSF-2562';

	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : fsbVersion
	Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor       	: Luis Felipe Valencia Hurtado
    Fecha       	: 29-01-2024

    Modificaciones  :
    Autor                   Fecha        Caso       Descripcion
    Felipe.valencia         29-01-2024   OSF-2197   Creación
	***************************************************************************/
	FUNCTION fsbVersion 
	RETURN VARCHAR2 
	IS
	BEGIN
		RETURN csbVersion;
	END fsbVersion;

    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fnuConsultaOrdenActividad
        Descripcion     : funcion que obtiene la orden de acuerdo a la actividad a generar 
                          y los tipos de trabajo parametrizados
        Autor           : Luis Felipe Valencia Hurtado
        Fecha           : 29-01-2024
        Parametros de Entrada
            inuProducto             Producto
            inuActividad         codigo de la actividad
        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor               Fecha           Caso        Descripción
        felipe.valencia     10/05/2024      OSF-2562    Se modifica para evitar la orden 
                                                        que se esta legalizando
    ***************************************************************************/
    FUNCTION fnuConsultaOrdenActividad
    ( 
        inuProducto     IN  or_order_activity.product_id%TYPE,
        inuActividad    IN  or_task_types_items.items_id%TYPE
    ) 
    RETURN or_order.order_id%TYPE
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuConsultaOrdenActividad';   

        nuOrden or_order.order_id%TYPE;
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   

        sbTipoTrabajo  parametros.valor_cadena%TYPE := pkg_parametros.fsbgetvalorcadena('TIPOS_TRABAJO_ORD_SERVICIOS_ING');

        CURSOR cuObtieneOrden
        (
            inuProducto     IN  or_order_activity.product_id%TYPE,
            inuActividad    IN  or_task_types_items.items_id%TYPE
        )
        IS
        SELECT  a.order_id
        FROM    or_order a, or_order_activity b
        WHERE   b.order_id = a.order_id
        AND     a.task_type_id IN (
                                        SELECT to_number(regexp_substr(sbTipoTrabajo,'[^,]+', 1, LEVEL)) AS task_type_id
                                        FROM dual
                                        CONNECT BY regexp_substr(sbTipoTrabajo, '[^,]+', 1, LEVEL) IS NOT NULL
                                    )
        AND     a.order_status_id IN (
                                        SELECT  order_status_id
                                        FROM    or_order_status 
                                        WHERE   is_final_status = 'N'
                                )
        AND     b.product_id = inuProducto
        AND     exists  (
                            SELECT  task_type_id 
                            FROM    or_task_types_items 
                            WHERE   items_id = inuActividad
                            AND     task_type_id IN (
                                                        SELECT to_number(regexp_substr(sbTipoTrabajo,'[^,]+', 1, LEVEL)) AS task_type_id
                                                        FROM dual
                                                        CONNECT BY regexp_substr(sbTipoTrabajo, '[^,]+', 1, LEVEL) IS NOT NULL
                                                    )
                        )
        AND a.order_id NOT IN (SELECT nudato_01 FROM tmp_generica WHERE nudato_01 = a.order_id)
        AND ROWNUM = 1;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        IF (cuObtieneOrden%ISOPEN) THEN
            CLOSE cuObtieneOrden;
        END IF;

        OPEN cuObtieneOrden (inuProducto,inuActividad);
        FETCH cuObtieneOrden INTO nuOrden; 
        CLOSE cuObtieneOrden;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN nuOrden;
    EXCEPTION
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_Error.Controlled_Error;
    --Validación de error no controlado
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_Error.Controlled_Error;       
    END fnuConsultaOrdenActividad;
END pkg_bcordenes_servicios_inge;
/

PROMPT Otorgando permisos de ejecución para personalizaciones.pkg_bcordenes_servicios_inge
BEGIN
    pkg_utilidades.prAplicarPermisos(UPPER('pkg_bcordenes_servicios_inge'), 'PERSONALIZACIONES');
END;
/