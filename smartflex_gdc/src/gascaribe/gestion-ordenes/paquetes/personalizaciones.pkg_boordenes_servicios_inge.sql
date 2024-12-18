CREATE OR REPLACE PACKAGE personalizaciones.pkg_boordenes_servicios_inge IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_boordenes_servicios_inge
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

    FUNCTION fblExisteOrdenActividad
    ( 
        inuProducto     IN  or_order_activity.product_id%TYPE,
        inuActividad    IN  or_task_types_items.items_id%TYPE
    ) 
    RETURN BOOLEAN;

END pkg_boordenes_servicios_inge;

/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_boordenes_servicios_inge IS

	-- Constantes para el control de la traza
	csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
    csbNivelTraza           CONSTANT NUMBER(2)     := pkg_traza.fnuNivelTrzDef;
	
	-- Identificador del ultimo caso que hizo cambios
	csbVersion     CONSTANT VARCHAR2(15) := 'OSF-2197';

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
        Programa        : fblExisteOrdenActividad
        Descripcion     : funcion que valida si la actividad a generar esta 
                          parametrizada por tipo de trabajo
        Autor           : Luis Felipe Valencia Hurtado
        Fecha           : 29-01-2024
        Parametros de Entrada
            inuProducto             Producto
            inuActividad         codigo de la actividad
        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/
    FUNCTION fblExisteOrdenActividad
    ( 
        inuProducto     IN  or_order_activity.product_id%TYPE,
        inuActividad    IN  or_task_types_items.items_id%TYPE
    ) 
    RETURN BOOLEAN
    IS
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblExisteOrdenActividad';   

        sbError         VARCHAR2(4000);
        nuError         NUMBER;   
        nuOrden         or_order.order_id%TYPE;    

        blExiste BOOLEAN :=FALSE;     
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pkg_traza.trace('inuProducto: ' || inuProducto , pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('inuActividad: ' || inuActividad , pkg_traza.cnuNivelTrzDef);

        nuOrden := pkg_bcordenes_servicios_inge.fnuConsultaOrdenActividad(inuProducto,inuActividad);

        pkg_traza.trace('nuOrden: ' || nuOrden , pkg_traza.cnuNivelTrzDef);

        IF (nuOrden IS NOT NULL) THEN
            pkg_traza.trace('Existe orden retorna true.', pkg_traza.cnuNivelTrzDef);
            blExiste := TRUE;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN blExiste;
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
    END fblExisteOrdenActividad;
END pkg_boordenes_servicios_inge;
/

PROMPT Otorgando permisos de ejecución para personalizaciones.pkg_boordenes_servicios_inge
BEGIN
    pkg_utilidades.prAplicarPermisos(UPPER('pkg_boordenes_servicios_inge'), 'PERSONALIZACIONES');
END;
/