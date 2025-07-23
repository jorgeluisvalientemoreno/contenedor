create or replace PACKAGE adm_person.pkg_or_order_activity IS
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
        jsoto		          13-12-2024    OSF-3805	Agregar funcionalidades de primer nivel
        jose.pineda           30-12-2024    OSF-3722    Se crea prcActEstado_Orden  
        jose.pineda           18-03-2025    OSF-4042    * Se crea fnuObtIdActividadOrden  
                                                        * Se crea fnuObtIdDireccion
                                                        * Se crea fnuObtProducto 
    *******************************************************************************/

    TYPE tytbRegistros IS TABLE OF OR_ORDER_ACTIVITY%ROWTYPE INDEX BY BINARY_INTEGER;


    CURSOR cuOR_ORDER_ACTIVITY IS SELECT * FROM OR_ORDER_ACTIVITY;

	CURSOR cuRegistroRId
    (
        inuORDER_ACTIVITY_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM OR_ORDER_ACTIVITY tb
        WHERE
        ORDER_ACTIVITY_ID = inuORDER_ACTIVITY_ID;


    SUBTYPE STYOR_ORDER_ACTIVITY  IS  cuRegistroRId%ROWTYPE;

    CURSOR cuRegistroRIdLock
    (
        inuORDER_ACTIVITY_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM OR_ORDER_ACTIVITY tb
        WHERE
        ORDER_ACTIVITY_ID = inuORDER_ACTIVITY_ID
        FOR UPDATE NOWAIT;

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

    PROCEDURE prcActualizaItemSeriado(inuOrden           IN or_order.order_id%type,
					inuItemSeriado	 IN or_order_activity.serial_items_id%type,
					onuError         OUT NUMBER,
					osbError         OUT VARCHAR2);


    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuRegistroRId%ROWTYPE);

	-- Obtiene el valor de la columna PROCESS_ID
    FUNCTION fnuObtPROCESS_ID(
        inuORDER_ACTIVITY_ID    NUMBER
        ) RETURN OR_ORDER_ACTIVITY.PROCESS_ID%TYPE;

	     -- Obtiene el valor de la columna ACTIVITY_ID
    FUNCTION fnuObtACTIVITY_ID(
        inuORDER_ACTIVITY_ID    NUMBER
        ) RETURN OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE;

	    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuORDER_ACTIVITY_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;

    -- Obtiene el valor de la columna SERIAL_ITEMS_ID
    FUNCTION fnuObtSERIAL_ITEMS_ID(
        inuORDER_ACTIVITY_ID    NUMBER
        ) RETURN OR_ORDER_ACTIVITY.SERIAL_ITEMS_ID%TYPE;

    -- Actualiza el estado de la actividad de la orden
    PROCEDURE prcActEstado_Orden( inuOrden  IN  NUMBER, isbEstado   IN  VARCHAR2 );
    
    -- Obtiene el id de la actividad asociado a la orden
    FUNCTION fnuObtIdActividadOrden( inuOrden   IN  NUMBER)
    RETURN OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;

    -- Obtiene el id de la direcciÃ³n asociada a la activad de la orden
    FUNCTION fnuObtIdDireccion( inuActividadOrden   IN  NUMBER)
    RETURN OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE;

    -- Obtiene el producto asociado a la actividad de la orden
    FUNCTION fnuObtProducto( inuActividadOrden   IN  NUMBER)
    RETURN OR_ORDER_ACTIVITY.PRODUCT_ID%TYPE;
        
END pkg_or_order_activity;
/

create or replace PACKAGE BODY adm_person.pkg_or_order_activity IS

    -- Constantes para el control de la traza
    csbSP_NAME CONSTANT VARCHAR2(100) := $$PLSQL_UNIT;

    -- Identificador del ultimo caso que hizo cambios
    csbVersion CONSTANT VARCHAR2(15) := 'OSF-4042';

    -- Tipo de novedad
    cnuTipoNovedad CONSTANT NUMBER := 14;

	csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

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
        Descripcion     : Actualizar la direcciÃ³n de la actividad de la orden

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
        felipe.valencia     12-03-2024  OSF-2623  CreaciÃ³n
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

    /**************************************************************************
    Autor       : Jhon Soto
    Fecha       : 21/11/2024
    Ticket      : OSF-3591
    Proceso     : prcActualizaItemSeriado
    Descripcion : procedimiento que se encarga de actualizar serial_items_id de la orden

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE prcActualizaItemSeriado(inuOrden           IN or_order.order_id%type,
				  	inuItemSeriado	 IN or_order_activity.serial_items_id%type,
					onuError         OUT NUMBER,
					osbError         OUT VARCHAR2) IS

        csbMT_NAME VARCHAR2(100) := csbSP_NAME ||
                                    '.prcActualizaItemSeriado';
    BEGIN
        pkg_traza.trace(csbMT_NAME,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbINICIO);
        pkg_traza.trace('Orden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('Item Seriado: ' || inuItemSeriado,
                        pkg_traza.cnuNivelTrzDef);
        pkg_error.prInicializaError(onuError, osbError);

        UPDATE or_order_activity
        SET serial_items_id = inuItemSeriado
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
    END prcActualizaItemSeriado;


	    -- Actualiza por RowId el valor de la columna ORDER_ITEM_ID
    PROCEDURE prAcORDER_ITEM_ID_RId(
        iRowId ROWID,
        inuORDER_ITEM_ID_O    NUMBER,
        inuORDER_ITEM_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORDER_ITEM_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuORDER_ITEM_ID_O,-1) <> NVL(inuORDER_ITEM_ID_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET ORDER_ITEM_ID=inuORDER_ITEM_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcORDER_ITEM_ID_RId;

    -- Actualiza por RowId el valor de la columna ORDER_ID
    PROCEDURE prAcORDER_ID_RId(
        iRowId ROWID,
        inuORDER_ID_O    NUMBER,
        inuORDER_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORDER_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuORDER_ID_O,-1) <> NVL(inuORDER_ID_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET ORDER_ID=inuORDER_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcORDER_ID_RId;

    -- Actualiza por RowId el valor de la columna STATUS
    PROCEDURE prAcSTATUS_RId(
        iRowId ROWID,
        isbSTATUS_O    VARCHAR2,
        isbSTATUS_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSTATUS_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbSTATUS_O,'-') <> NVL(isbSTATUS_N,'-') THEN
            UPDATE OR_ORDER_ACTIVITY
            SET STATUS=isbSTATUS_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcSTATUS_RId;

    -- Actualiza por RowId el valor de la columna TASK_TYPE_ID
    PROCEDURE prAcTASK_TYPE_ID_RId(
        iRowId ROWID,
        inuTASK_TYPE_ID_O    NUMBER,
        inuTASK_TYPE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTASK_TYPE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuTASK_TYPE_ID_O,-1) <> NVL(inuTASK_TYPE_ID_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET TASK_TYPE_ID=inuTASK_TYPE_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcTASK_TYPE_ID_RId;

    -- Actualiza por RowId el valor de la columna PACKAGE_ID
    PROCEDURE prAcPACKAGE_ID_RId(
        iRowId ROWID,
        inuPACKAGE_ID_O    NUMBER,
        inuPACKAGE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPACKAGE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPACKAGE_ID_O,-1) <> NVL(inuPACKAGE_ID_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET PACKAGE_ID=inuPACKAGE_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcPACKAGE_ID_RId;

    -- Actualiza por RowId el valor de la columna MOTIVE_ID
    PROCEDURE prAcMOTIVE_ID_RId(
        iRowId ROWID,
        inuMOTIVE_ID_O    NUMBER,
        inuMOTIVE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcMOTIVE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuMOTIVE_ID_O,-1) <> NVL(inuMOTIVE_ID_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET MOTIVE_ID=inuMOTIVE_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcMOTIVE_ID_RId;

    -- Actualiza por RowId el valor de la columna COMPONENT_ID
    PROCEDURE prAcCOMPONENT_ID_RId(
        iRowId ROWID,
        inuCOMPONENT_ID_O    NUMBER,
        inuCOMPONENT_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOMPONENT_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCOMPONENT_ID_O,-1) <> NVL(inuCOMPONENT_ID_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET COMPONENT_ID=inuCOMPONENT_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCOMPONENT_ID_RId;

    -- Actualiza por RowId el valor de la columna INSTANCE_ID
    PROCEDURE prAcINSTANCE_ID_RId(
        iRowId ROWID,
        inuINSTANCE_ID_O    NUMBER,
        inuINSTANCE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcINSTANCE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuINSTANCE_ID_O,-1) <> NVL(inuINSTANCE_ID_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET INSTANCE_ID=inuINSTANCE_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcINSTANCE_ID_RId;

    -- Actualiza por RowId el valor de la columna ADDRESS_ID
    PROCEDURE prAcADDRESS_ID_RId(
        iRowId ROWID,
        inuADDRESS_ID_O    NUMBER,
        inuADDRESS_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcADDRESS_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuADDRESS_ID_O,-1) <> NVL(inuADDRESS_ID_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET ADDRESS_ID=inuADDRESS_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcADDRESS_ID_RId;

    -- Actualiza por RowId el valor de la columna ELEMENT_ID
    PROCEDURE prAcELEMENT_ID_RId(
        iRowId ROWID,
        inuELEMENT_ID_O    NUMBER,
        inuELEMENT_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcELEMENT_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuELEMENT_ID_O,-1) <> NVL(inuELEMENT_ID_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET ELEMENT_ID=inuELEMENT_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcELEMENT_ID_RId;

    -- Actualiza por RowId el valor de la columna SUBSCRIBER_ID
    PROCEDURE prAcSUBSCRIBER_ID_RId(
        iRowId ROWID,
        inuSUBSCRIBER_ID_O    NUMBER,
        inuSUBSCRIBER_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSUBSCRIBER_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuSUBSCRIBER_ID_O,-1) <> NVL(inuSUBSCRIBER_ID_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET SUBSCRIBER_ID=inuSUBSCRIBER_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcSUBSCRIBER_ID_RId;

    -- Actualiza por RowId el valor de la columna SUBSCRIPTION_ID
    PROCEDURE prAcSUBSCRIPTION_ID_RId(
        iRowId ROWID,
        inuSUBSCRIPTION_ID_O    NUMBER,
        inuSUBSCRIPTION_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSUBSCRIPTION_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuSUBSCRIPTION_ID_O,-1) <> NVL(inuSUBSCRIPTION_ID_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET SUBSCRIPTION_ID=inuSUBSCRIPTION_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcSUBSCRIPTION_ID_RId;

    -- Actualiza por RowId el valor de la columna PRODUCT_ID
    PROCEDURE prAcPRODUCT_ID_RId(
        iRowId ROWID,
        inuPRODUCT_ID_O    NUMBER,
        inuPRODUCT_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPRODUCT_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPRODUCT_ID_O,-1) <> NVL(inuPRODUCT_ID_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET PRODUCT_ID=inuPRODUCT_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcPRODUCT_ID_RId;

    -- Actualiza por RowId el valor de la columna OPERATING_SECTOR_ID
    PROCEDURE prAcOPERATING_SECTOR_ID_RId(
        iRowId ROWID,
        inuOPERATING_SECTOR_ID_O    NUMBER,
        inuOPERATING_SECTOR_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPERATING_SECTOR_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuOPERATING_SECTOR_ID_O,-1) <> NVL(inuOPERATING_SECTOR_ID_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET OPERATING_SECTOR_ID=inuOPERATING_SECTOR_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcOPERATING_SECTOR_ID_RId;

    -- Actualiza por RowId el valor de la columna EXEC_ESTIMATE_DATE
    PROCEDURE prAcEXEC_ESTIMATE_DATE_RId(
        iRowId ROWID,
        idtEXEC_ESTIMATE_DATE_O    DATE,
        idtEXEC_ESTIMATE_DATE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcEXEC_ESTIMATE_DATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtEXEC_ESTIMATE_DATE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtEXEC_ESTIMATE_DATE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET EXEC_ESTIMATE_DATE=idtEXEC_ESTIMATE_DATE_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcEXEC_ESTIMATE_DATE_RId;

    -- Actualiza por RowId el valor de la columna OPERATING_UNIT_ID
    PROCEDURE prAcOPERATING_UNIT_ID_RId(
        iRowId ROWID,
        inuOPERATING_UNIT_ID_O    NUMBER,
        inuOPERATING_UNIT_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPERATING_UNIT_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuOPERATING_UNIT_ID_O,-1) <> NVL(inuOPERATING_UNIT_ID_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET OPERATING_UNIT_ID=inuOPERATING_UNIT_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcOPERATING_UNIT_ID_RId;

    -- Actualiza por RowId el valor de la columna COMMENT_
    PROCEDURE prAcCOMMENT__RId(
        iRowId ROWID,
        isbCOMMENT__O    VARCHAR2,
        isbCOMMENT__N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOMMENT__RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbCOMMENT__O,'-') <> NVL(isbCOMMENT__N,'-') THEN
            UPDATE OR_ORDER_ACTIVITY
            SET COMMENT_=isbCOMMENT__N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCOMMENT__RId;

    -- Actualiza por RowId el valor de la columna PROCESS_ID
    PROCEDURE prAcPROCESS_ID_RId(
        iRowId ROWID,
        inuPROCESS_ID_O    NUMBER,
        inuPROCESS_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPROCESS_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPROCESS_ID_O,-1) <> NVL(inuPROCESS_ID_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET PROCESS_ID=inuPROCESS_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcPROCESS_ID_RId;

    -- Actualiza por RowId el valor de la columna ACTIVITY_ID
    PROCEDURE prAcACTIVITY_ID_RId(
        iRowId ROWID,
        inuACTIVITY_ID_O    NUMBER,
        inuACTIVITY_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcACTIVITY_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuACTIVITY_ID_O,-1) <> NVL(inuACTIVITY_ID_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET ACTIVITY_ID=inuACTIVITY_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcACTIVITY_ID_RId;

    -- Actualiza por RowId el valor de la columna ORIGIN_ACTIVITY_ID
    PROCEDURE prAcORIGIN_ACTIVITY_ID_RId(
        iRowId ROWID,
        inuORIGIN_ACTIVITY_ID_O    NUMBER,
        inuORIGIN_ACTIVITY_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORIGIN_ACTIVITY_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuORIGIN_ACTIVITY_ID_O,-1) <> NVL(inuORIGIN_ACTIVITY_ID_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET ORIGIN_ACTIVITY_ID=inuORIGIN_ACTIVITY_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcORIGIN_ACTIVITY_ID_RId;

    -- Actualiza por RowId el valor de la columna ACTIVITY_GROUP_ID
    PROCEDURE prAcACTIVITY_GROUP_ID_RId(
        iRowId ROWID,
        inuACTIVITY_GROUP_ID_O    NUMBER,
        inuACTIVITY_GROUP_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcACTIVITY_GROUP_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuACTIVITY_GROUP_ID_O,-1) <> NVL(inuACTIVITY_GROUP_ID_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET ACTIVITY_GROUP_ID=inuACTIVITY_GROUP_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcACTIVITY_GROUP_ID_RId;

    -- Actualiza por RowId el valor de la columna SEQUENCE_
    PROCEDURE prAcSEQUENCE__RId(
        iRowId ROWID,
        inuSEQUENCE__O    NUMBER,
        inuSEQUENCE__N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSEQUENCE__RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuSEQUENCE__O,-1) <> NVL(inuSEQUENCE__N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET SEQUENCE_=inuSEQUENCE__N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcSEQUENCE__RId;

    -- Actualiza por RowId el valor de la columna REGISTER_DATE
    PROCEDURE prAcREGISTER_DATE_RId(
        iRowId ROWID,
        idtREGISTER_DATE_O    DATE,
        idtREGISTER_DATE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcREGISTER_DATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtREGISTER_DATE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtREGISTER_DATE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET REGISTER_DATE=idtREGISTER_DATE_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcREGISTER_DATE_RId;

    -- Actualiza por RowId el valor de la columna FINAL_DATE
    PROCEDURE prAcFINAL_DATE_RId(
        iRowId ROWID,
        idtFINAL_DATE_O    DATE,
        idtFINAL_DATE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFINAL_DATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFINAL_DATE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFINAL_DATE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET FINAL_DATE=idtFINAL_DATE_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcFINAL_DATE_RId;

    -- Actualiza por RowId el valor de la columna VALUE1
    PROCEDURE prAcVALUE1_RId(
        iRowId ROWID,
        isbVALUE1_O    VARCHAR2,
        isbVALUE1_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALUE1_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbVALUE1_O,'-') <> NVL(isbVALUE1_N,'-') THEN
            UPDATE OR_ORDER_ACTIVITY
            SET VALUE1=isbVALUE1_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcVALUE1_RId;

    -- Actualiza por RowId el valor de la columna VALUE2
    PROCEDURE prAcVALUE2_RId(
        iRowId ROWID,
        isbVALUE2_O    VARCHAR2,
        isbVALUE2_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALUE2_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbVALUE2_O,'-') <> NVL(isbVALUE2_N,'-') THEN
            UPDATE OR_ORDER_ACTIVITY
            SET VALUE2=isbVALUE2_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcVALUE2_RId;

    -- Actualiza por RowId el valor de la columna VALUE3
    PROCEDURE prAcVALUE3_RId(
        iRowId ROWID,
        isbVALUE3_O    VARCHAR2,
        isbVALUE3_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALUE3_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbVALUE3_O,'-') <> NVL(isbVALUE3_N,'-') THEN
            UPDATE OR_ORDER_ACTIVITY
            SET VALUE3=isbVALUE3_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcVALUE3_RId;

    -- Actualiza por RowId el valor de la columna VALUE4
    PROCEDURE prAcVALUE4_RId(
        iRowId ROWID,
        isbVALUE4_O    VARCHAR2,
        isbVALUE4_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALUE4_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbVALUE4_O,'-') <> NVL(isbVALUE4_N,'-') THEN
            UPDATE OR_ORDER_ACTIVITY
            SET VALUE4=isbVALUE4_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcVALUE4_RId;

    -- Actualiza por RowId el valor de la columna COMPENSATED
    PROCEDURE prAcCOMPENSATED_RId(
        iRowId ROWID,
        isbCOMPENSATED_O    VARCHAR2,
        isbCOMPENSATED_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOMPENSATED_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbCOMPENSATED_O,'-') <> NVL(isbCOMPENSATED_N,'-') THEN
            UPDATE OR_ORDER_ACTIVITY
            SET COMPENSATED=isbCOMPENSATED_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCOMPENSATED_RId;

    -- Actualiza por RowId el valor de la columna ORDER_TEMPLATE_ID
    PROCEDURE prAcORDER_TEMPLATE_ID_RId(
        iRowId ROWID,
        inuORDER_TEMPLATE_ID_O    NUMBER,
        inuORDER_TEMPLATE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORDER_TEMPLATE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuORDER_TEMPLATE_ID_O,-1) <> NVL(inuORDER_TEMPLATE_ID_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET ORDER_TEMPLATE_ID=inuORDER_TEMPLATE_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcORDER_TEMPLATE_ID_RId;

    -- Actualiza por RowId el valor de la columna CONSECUTIVE
    PROCEDURE prAcCONSECUTIVE_RId(
        iRowId ROWID,
        inuCONSECUTIVE_O    NUMBER,
        inuCONSECUTIVE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCONSECUTIVE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCONSECUTIVE_O,-1) <> NVL(inuCONSECUTIVE_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET CONSECUTIVE=inuCONSECUTIVE_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCONSECUTIVE_RId;

    -- Actualiza por RowId el valor de la columna SERIAL_ITEMS_ID
    PROCEDURE prAcSERIAL_ITEMS_ID_RId(
        iRowId ROWID,
        inuSERIAL_ITEMS_ID_O    NUMBER,
        inuSERIAL_ITEMS_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSERIAL_ITEMS_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuSERIAL_ITEMS_ID_O,-1) <> NVL(inuSERIAL_ITEMS_ID_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET SERIAL_ITEMS_ID=inuSERIAL_ITEMS_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcSERIAL_ITEMS_ID_RId;

    -- Actualiza por RowId el valor de la columna LEGALIZE_TRY_TIMES
    PROCEDURE prAcLEGALIZE_TRY_TIMES_RId(
        iRowId ROWID,
        inuLEGALIZE_TRY_TIMES_O    NUMBER,
        inuLEGALIZE_TRY_TIMES_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcLEGALIZE_TRY_TIMES_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuLEGALIZE_TRY_TIMES_O,-1) <> NVL(inuLEGALIZE_TRY_TIMES_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET LEGALIZE_TRY_TIMES=inuLEGALIZE_TRY_TIMES_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcLEGALIZE_TRY_TIMES_RId;

    -- Actualiza por RowId el valor de la columna WF_TAG_NAME
    PROCEDURE prAcWF_TAG_NAME_RId(
        iRowId ROWID,
        isbWF_TAG_NAME_O    VARCHAR2,
        isbWF_TAG_NAME_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcWF_TAG_NAME_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbWF_TAG_NAME_O,'-') <> NVL(isbWF_TAG_NAME_N,'-') THEN
            UPDATE OR_ORDER_ACTIVITY
            SET WF_TAG_NAME=isbWF_TAG_NAME_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcWF_TAG_NAME_RId;

    -- Actualiza por RowId el valor de la columna VALUE_REFERENCE
    PROCEDURE prAcVALUE_REFERENCE_RId(
        iRowId ROWID,
        inuVALUE_REFERENCE_O    NUMBER,
        inuVALUE_REFERENCE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALUE_REFERENCE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuVALUE_REFERENCE_O,-1) <> NVL(inuVALUE_REFERENCE_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET VALUE_REFERENCE=inuVALUE_REFERENCE_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcVALUE_REFERENCE_RId;

    -- Actualiza por RowId el valor de la columna ACTION_ID
    PROCEDURE prAcACTION_ID_RId(
        iRowId ROWID,
        inuACTION_ID_O    NUMBER,
        inuACTION_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcACTION_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuACTION_ID_O,-1) <> NVL(inuACTION_ID_N,-1) THEN
            UPDATE OR_ORDER_ACTIVITY
            SET ACTION_ID=inuACTION_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcACTION_ID_RId;


    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuRegistroRId%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.ORDER_ACTIVITY_ID,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcORDER_ITEM_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ORDER_ITEM_ID,
                ircRegistro.ORDER_ITEM_ID
            );

            prAcORDER_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ORDER_ID,
                ircRegistro.ORDER_ID
            );

            prAcSTATUS_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.STATUS,
                ircRegistro.STATUS
            );

            prAcTASK_TYPE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.TASK_TYPE_ID,
                ircRegistro.TASK_TYPE_ID
            );

            prAcPACKAGE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PACKAGE_ID,
                ircRegistro.PACKAGE_ID
            );

            prAcMOTIVE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.MOTIVE_ID,
                ircRegistro.MOTIVE_ID
            );

            prAcCOMPONENT_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.COMPONENT_ID,
                ircRegistro.COMPONENT_ID
            );

            prAcINSTANCE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.INSTANCE_ID,
                ircRegistro.INSTANCE_ID
            );

            prAcADDRESS_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ADDRESS_ID,
                ircRegistro.ADDRESS_ID
            );

            prAcELEMENT_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ELEMENT_ID,
                ircRegistro.ELEMENT_ID
            );

            prAcSUBSCRIBER_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SUBSCRIBER_ID,
                ircRegistro.SUBSCRIBER_ID
            );

            prAcSUBSCRIPTION_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SUBSCRIPTION_ID,
                ircRegistro.SUBSCRIPTION_ID
            );

            prAcPRODUCT_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PRODUCT_ID,
                ircRegistro.PRODUCT_ID
            );

            prAcOPERATING_SECTOR_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OPERATING_SECTOR_ID,
                ircRegistro.OPERATING_SECTOR_ID
            );

            prAcEXEC_ESTIMATE_DATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.EXEC_ESTIMATE_DATE,
                ircRegistro.EXEC_ESTIMATE_DATE
            );

            prAcOPERATING_UNIT_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OPERATING_UNIT_ID,
                ircRegistro.OPERATING_UNIT_ID
            );

            prAcCOMMENT__RId(
                rcRegistroAct.RowId,
                rcRegistroAct.COMMENT_,
                ircRegistro.COMMENT_
            );

            prAcPROCESS_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PROCESS_ID,
                ircRegistro.PROCESS_ID
            );

            prAcACTIVITY_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ACTIVITY_ID,
                ircRegistro.ACTIVITY_ID
            );

            prAcORIGIN_ACTIVITY_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ORIGIN_ACTIVITY_ID,
                ircRegistro.ORIGIN_ACTIVITY_ID
            );

            prAcACTIVITY_GROUP_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ACTIVITY_GROUP_ID,
                ircRegistro.ACTIVITY_GROUP_ID
            );

            prAcSEQUENCE__RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SEQUENCE_,
                ircRegistro.SEQUENCE_
            );

            prAcREGISTER_DATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.REGISTER_DATE,
                ircRegistro.REGISTER_DATE
            );

            prAcFINAL_DATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FINAL_DATE,
                ircRegistro.FINAL_DATE
            );

            prAcVALUE1_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.VALUE1,
                ircRegistro.VALUE1
            );

            prAcVALUE2_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.VALUE2,
                ircRegistro.VALUE2
            );

            prAcVALUE3_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.VALUE3,
                ircRegistro.VALUE3
            );

            prAcVALUE4_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.VALUE4,
                ircRegistro.VALUE4
            );

            prAcCOMPENSATED_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.COMPENSATED,
                ircRegistro.COMPENSATED
            );

            prAcORDER_TEMPLATE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ORDER_TEMPLATE_ID,
                ircRegistro.ORDER_TEMPLATE_ID
            );

            prAcCONSECUTIVE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CONSECUTIVE,
                ircRegistro.CONSECUTIVE
            );

            prAcSERIAL_ITEMS_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SERIAL_ITEMS_ID,
                ircRegistro.SERIAL_ITEMS_ID
            );

            prAcLEGALIZE_TRY_TIMES_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.LEGALIZE_TRY_TIMES,
                ircRegistro.LEGALIZE_TRY_TIMES
            );

            prAcWF_TAG_NAME_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.WF_TAG_NAME,
                ircRegistro.WF_TAG_NAME
            );

            prAcVALUE_REFERENCE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.VALUE_REFERENCE,
                ircRegistro.VALUE_REFERENCE
            );

            prAcACTION_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ACTION_ID,
                ircRegistro.ACTION_ID
            );

        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prActRegistro;	

    -- Obtiene el valor de la columna PROCESS_ID
    FUNCTION fnuObtPROCESS_ID(
        inuORDER_ACTIVITY_ID    NUMBER
        ) RETURN OR_ORDER_ACTIVITY.PROCESS_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPROCESS_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ACTIVITY_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PROCESS_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtPROCESS_ID;

     -- Obtiene el valor de la columna ACTIVITY_ID
    FUNCTION fnuObtACTIVITY_ID(
        inuORDER_ACTIVITY_ID    NUMBER
        ) RETURN OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtACTIVITY_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ACTIVITY_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ACTIVITY_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtACTIVITY_ID;

    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuORDER_ACTIVITY_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuORDER_ACTIVITY_ID);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuORDER_ACTIVITY_ID);
            FETCH cuRegistroRId INTO rcRegistroRId;
            CLOSE cuRegistroRId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END frcObtRegistroRId;

    -- Obtiene el valor de la columna SERIAL_ITEMS_ID
    FUNCTION fnuObtSERIAL_ITEMS_ID(
        inuORDER_ACTIVITY_ID    NUMBER
        ) RETURN OR_ORDER_ACTIVITY.SERIAL_ITEMS_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtSERIAL_ITEMS_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ACTIVITY_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SERIAL_ITEMS_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtSERIAL_ITEMS_ID;

    -- Actualiza el estado de la actividad de la orden
    PROCEDURE prcActEstado_Orden( inuOrden  IN  NUMBER, isbEstado   IN  VARCHAR2 )
    IS
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcActEstado_Orden';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
          
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
        UPDATE or_order_activity
        SET status        =  isbEstado      
        WHERE 
        order_id = inuOrden;        
        
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.CONTROLLED_ERROR;
        WHEN others THEN
            Pkg_Error.seterror;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.CONTROLLED_ERROR;            
    END prcActEstado_Orden;

    -- Obtiene el id de la actividad asociado a la orden
    FUNCTION fnuObtIdActividadOrden( inuOrden   IN  NUMBER)
    RETURN OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE
    IS
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fnuObtIdActividadOrden';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        nuIdActividadOrden  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;
                
        CURSOR cuObtIdActividadOrden
        IS
        SELECT oa.order_activity_id
        FROM or_order_activity oa
        WHERE oa.order_id = inuOrden;
        
        PROCEDURE prcCierraCursor
        IS
            csbMT_NAME1      VARCHAR2(100) := csbMT_NAME || '.prcCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);        
        BEGIN

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
                
            IF cuObtIdActividadOrden%ISOPEN THEN
                CLOSE cuObtIdActividadOrden;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        EXCEPTION
            WHEN pkg_error.CONTROLLED_ERROR THEN
                pkg_Error.getError(nuError1, sbError1);
                pkg_traza.trace('nuError1: ' || nuError1 || ', ' || 'sbError1: ' || sbError1, pkg_traza.cnuNivelTrzDef);
                pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
                RAISE pkg_error.CONTROLLED_ERROR;
            WHEN others THEN
                Pkg_Error.seterror;
                pkg_error.geterror(nuError1, sbError1);
                pkg_traza.trace('nuError1: ' || nuError1 || ', ' || 'sbError1: ' || sbError1, pkg_traza.cnuNivelTrzDef);
                pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
                RAISE pkg_error.CONTROLLED_ERROR;
        END prcCierraCursor;
          
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
        OPEN cuObtIdActividadOrden;
        FETCH cuObtIdActividadOrden INTO nuIdActividadOrden;
        CLOSE cuObtIdActividadOrden;
        
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN nuIdActividadOrden;
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            prcCierraCursor;
            RETURN nuIdActividadOrden;
        WHEN others THEN
            Pkg_Error.seterror;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            prcCierraCursor;            
            RETURN nuIdActividadOrden;        
    END fnuObtIdActividadOrden;

    -- Obtiene el id de la direcciÃ³n asociada a la activad de la orden
    FUNCTION fnuObtIdDireccion( inuActividadOrden   IN  NUMBER)
    RETURN OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE
    IS
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fnuObtIdDireccion';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        nutIdDireccion  OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE;
                
        CURSOR cuObtIdDireccion
        IS
        SELECT oa.address_id
        FROM or_order_activity oa
        WHERE oa.order_id = inuActividadOrden;
        
        PROCEDURE prcCierraCursor
        IS
            csbMT_NAME1      VARCHAR2(100) := csbMT_NAME || '.prcCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);        
        BEGIN

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
                
            IF cuObtIdDireccion%ISOPEN THEN
                CLOSE cuObtIdDireccion;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        EXCEPTION
            WHEN pkg_error.CONTROLLED_ERROR THEN
                pkg_Error.getError(nuError1, sbError1);
                pkg_traza.trace('nuError1: ' || nuError1 || ', ' || 'sbError1: ' || sbError1, pkg_traza.cnuNivelTrzDef);
                pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
                RAISE pkg_error.CONTROLLED_ERROR;
            WHEN others THEN
                Pkg_Error.seterror;
                pkg_error.geterror(nuError1, sbError1);
                pkg_traza.trace('nuError1: ' || nuError1 || ', ' || 'sbError1: ' || sbError1, pkg_traza.cnuNivelTrzDef);
                pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
                RAISE pkg_error.CONTROLLED_ERROR;
        END prcCierraCursor;
          
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
        OPEN cuObtIdDireccion;
        FETCH cuObtIdDireccion INTO nutIdDireccion;
        CLOSE cuObtIdDireccion;
        
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN nutIdDireccion;
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            prcCierraCursor;
            RETURN nutIdDireccion;
        WHEN others THEN
            Pkg_Error.seterror;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            prcCierraCursor;            
            RETURN nutIdDireccion;        
    END fnuObtIdDireccion;
    
    -- Obtiene el producto asociado a la actividad de la orden
    FUNCTION fnuObtProducto( inuActividadOrden   IN  NUMBER)
    RETURN OR_ORDER_ACTIVITY.PRODUCT_ID%TYPE
    IS
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fnuObtProducto';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        nuProducto  OR_ORDER_ACTIVITY.PRODUCT_ID%TYPE;
                
        CURSOR cuObtProducto
        IS
        SELECT oa.product_id
        FROM or_order_activity oa
        WHERE oa.order_id = inuActividadOrden;
        
        PROCEDURE prcCierraCursor
        IS
            csbMT_NAME1      VARCHAR2(100) := csbMT_NAME || '.prcCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);        
        BEGIN

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
                
            IF cuObtProducto%ISOPEN THEN
                CLOSE cuObtProducto;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        EXCEPTION
            WHEN pkg_error.CONTROLLED_ERROR THEN
                pkg_Error.getError(nuError1, sbError1);
                pkg_traza.trace('nuError1: ' || nuError1 || ', ' || 'sbError1: ' || sbError1, pkg_traza.cnuNivelTrzDef);
                pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
                RAISE pkg_error.CONTROLLED_ERROR;
            WHEN others THEN
                Pkg_Error.seterror;
                pkg_error.geterror(nuError1, sbError1);
                pkg_traza.trace('nuError1: ' || nuError1 || ', ' || 'sbError1: ' || sbError1, pkg_traza.cnuNivelTrzDef);
                pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
                RAISE pkg_error.CONTROLLED_ERROR;
        END prcCierraCursor;
          
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
        OPEN cuObtProducto;
        FETCH cuObtProducto INTO nuProducto;
        CLOSE cuObtProducto;
        
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN nuProducto;
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            prcCierraCursor;
            RETURN nuProducto;
        WHEN others THEN
            Pkg_Error.seterror;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            prcCierraCursor;            
            RETURN nuProducto;        
    END fnuObtProducto;             
        
END pkg_or_order_activity;
/

BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_OR_ORDER_ACTIVITY', 'ADM_PERSON');
END;
/

