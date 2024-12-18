CREATE OR REPLACE PACKAGE personalizaciones.pkg_detalle_ot_agrupada IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bccontrato
    Autor       :   Luis Felipe Valencia - MVM
    Fecha       :   13-12-2023
    Descripcion :   Paquete con los métodos CRUD para manejo de información
                    sobre la tabla PERSONALIZACIONES.detalle_ot_agrupada
    Modificaciones  :
    Autor               Fecha       Caso        Descripcion
    felipe.valencia     13-12-2023  OSF-1909    Creación
*******************************************************************************/

    -- Retona Identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion RETURN VARCHAR2;


	PROCEDURE prcActualizaordenagrupadora
    (
        inuOrdenAgrupa   IN  detalle_ot_agrupada.orden_agrupadora%TYPE,
        isbestado        IN  detalle_ot_agrupada.estado%TYPE
    );

    PROCEDURE prcProcesaOrdenesIndividuales
    (
        inuOrdenAgrupadora  IN or_order.order_id%TYPE,
        idtFechaLegal 		IN or_order.legalization_date%TYPE,
        inuUnidadOperativa  IN or_order.operating_unit_id%TYPE,
        inuContratoId 		IN or_order.defined_contract_id%TYPE,
        inLocalidad 	    IN ab_address.geograp_location_id%TYPE,
        inuTipoTrabajo      IN or_order.task_type_id%TYPE,
        inuActividad        IN or_order_activity.activity_id%TYPE
    );
END pkg_detalle_ot_agrupada;
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_detalle_ot_agrupada IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion                 VARCHAR2(15) := 'OSF-1909';

    -- Constantes para el control de la traza
    csbSP_NAME            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Luis Felipe Valencia Hurtado - MVM 
    Fecha           : 27-07-2023 
    Modificaciones  :
    Autor               Fecha       Caso        Descripcion
    felipe.valencia     13-12-2023  OSF-1909    Creación
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;


    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcActualizaordenagrupadora 
    Descripcion     : Registra en la tabla en la tabla detalle_ot_agrupada
    Autor           : Luis Felipe Valencia Hurtado - MVM 
    Fecha           : 13-12-2023 
    Modificaciones  :
    Autor               Fecha       Caso        Descripcion
    felipe.valencia     13-12-2023  OSF-1909    Creación
    ***************************************************************************/      
	PROCEDURE prcActualizaordenagrupadora
    (
        inuOrdenAgrupa   IN  detalle_ot_agrupada.orden_agrupadora%TYPE,
        isbestado        IN  detalle_ot_agrupada.estado%TYPE
    )
    IS

        -----------------------------------------------------------------------------
        --                              CONSTANTES                                 --
        -----------------------------------------------------------------------------
        csbMetodo   CONSTANT VARCHAR2(100) := csbSP_NAME||'prcActualizaordenagrupadora';
        ------------------------------------------------------------------------------


        -----------------------------------------------------------------------------
        --                              VARIABLES                                  --
        -----------------------------------------------------------------------------
        nuExiste                NUMBER;  
        sbError                 VARCHAR2(4000);
        nuError                 NUMBER;        
        -----------------------------------------------------------------------------

        -----------------------------------------------------------------------------
        --                              CURSORES                                   --
        -----------------------------------------------------------------------------
        CURSOR cuValidaExisteRegistro
        IS
        SELECT  COUNT(1)
        FROM    detalle_ot_agrupada
        WHERE   orden_agrupadora = inuOrdenAgrupa;
        -----------------------------------------------------------------------------

    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        OPEN cuValidaExisteRegistro;
        FETCH cuValidaExisteRegistro INTO nuExiste;
        CLOSE cuValidaExisteRegistro;

        IF (nuExiste > 0) THEN
            UPDATE detalle_ot_agrupada
            SET     fecha_procesada = sysdate,
                    estado = isbestado
            WHERE   orden_agrupadora = inuOrdenAgrupa;
        END IF;

        COMMIT;

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);        
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
    END prcActualizaordenagrupadora;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcProcesaOrdenesIndividuales 
    Descripcion     : Registra ordenes individuales en la tabla en la tabla 
                      detalle_ot_agrupada
    Autor           : Luis Felipe Valencia Hurtado - MVM 
    Fecha           : 13-12-2023 
    Modificaciones  :
    Autor               Fecha       Caso        Descripcion
    felipe.valencia     13-12-2023  OSF-1909    Creación
    ***************************************************************************/  
    PROCEDURE prcProcesaOrdenesIndividuales
    (
        inuOrdenAgrupadora  IN or_order.order_id%TYPE,
        idtFechaLegal 		IN or_order.legalization_date%TYPE,
        inuUnidadOperativa  IN or_order.operating_unit_id%TYPE,
        inuContratoId 		IN or_order.defined_contract_id%TYPE,
        inLocalidad 	    IN ab_address.geograp_location_id%TYPE,
        inuTipoTrabajo      IN or_order.task_type_id%TYPE,
        inuActividad        IN or_order_activity.activity_id%TYPE
    )
    IS 
        -------------------------------------------------------------------------
        --                             CONSTANTES                              --
        -------------------------------------------------------------------------
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcProcesaOrdenesIndividuales';

        -------------------------------------------------------------------------
        --                            VARIABLES                                --
        -------------------------------------------------------------------------
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
    BEGIN 
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        INSERT INTO detalle_ot_agrupada (orden_agrupadora, orden, fecha_procesada, estado)
        SELECT  DISTINCT inuOrdenAgrupadora orden_agrupadora,
                oo.order_id orden,
                NULL fecha_procesada,
                'R' estado
        FROM    or_order oo,
                or_order_activity ot,
                ab_address aa
        WHERE   ot.order_id = oo.order_id
        AND aa.address_id = oo.external_address_id
        AND TRUNC(oo.legalization_date) = TRUNC(idtFechaLegal)
        AND oo.operating_unit_id 		= inuUnidadOperativa
        AND oo.defined_contract_id 		= inuContratoId
        AND aa.geograp_location_id		= inLocalidad
        AND oo.task_type_id 			= inuTipoTrabajo
        AND oo.order_status_id 			= 8
        AND ot.activity_id              = inuActividad
        AND NVL(oo.IS_PENDING_LIQ,'N') = 'N' 
        AND (SAVED_DATA_VALUES IS NULL OR  SAVED_DATA_VALUES != 'ORDER_GROUPED');
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END prcProcesaOrdenesIndividuales;


END pkg_detalle_ot_agrupada;
/

PROMPT Otorgando permisos de ejecución para personalizaciones.pkg_detalle_ot_agrupada
BEGIN
    pkg_utilidades.prAplicarPermisos(upper('pkg_detalle_ot_agrupada'),'PERSONALIZACIONES');
END;
/