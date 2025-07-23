CREATE OR REPLACE PACKAGE adm_person.pkg_or_order_items IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_or_order_items
    Autor       :   Luis Felipe Valencia Hurtado
    Fecha       :   09/01/2024
    Descripcion :   Paquete con los metodos para manejo de información sobre las 
                    tablas OPEN.OR_ORDER_ITEMS
    Modificaciones  :
    Autor               Fecha           Caso        Descripcion
    PAcosta             04/12/2024      OSF-3612    Creacion metodo PRCACTUALIZAITEMSERIADO
    felipe.valencia     09/01/2024      OSF-1909    Creacion
    jpinedc             10/03/2025      OSF-4042    * fnuObtieneCantLegalizada
                                                    * fnuObtieneItem
                                                    * prc_actual_item_orden por item de orden
                                                    * frcObtRegistroConOrderEitem
                                                    * fblExisteItemOrden
                                                    * prcActCantLegValorPrecTotal por orden e item
    PAcosta             13/05/2025      OSF-4336    * Creacion metodo fnuObtValorOrden                                                     
*******************************************************************************/

    -- Retona el identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion 
    RETURN VARCHAR2;

    subtype TYTBOR_ORDER_ITEMS IS DAOR_ORDER_ITEMS.TYTBOR_ORDER_ITEMS;

	PROCEDURE prc_actual_item_orden
    (
        inuOrden            IN  or_order_items.order_id%TYPE,
        inuItem             IN  or_order_items.items_id%TYPE,
        inuCantidadAsignada IN  or_order_items.assigned_item_amount%TYPE,
        inuCantidad         IN  or_order_items.legal_item_amount%TYPE,
        inuValor            IN  or_order_items.value%TYPE,
        inuPrecioTotal      IN  or_order_items.total_price%TYPE DEFAULT 0,
        isbElemennto        IN  or_order_items.element_code%TYPE DEFAULT NULL,
        inuOrdenIdActividad IN  or_order_items.order_activity_id%TYPE DEFAULT NULL,
        inuCodigoElemento   IN  or_order_items.element_id%TYPE DEFAULT NULL,
        isbReutilizado      IN  or_order_items.reused%TYPE DEFAULT NULL,
        inuItemSeriado      IN  or_order_items.serial_items_id%TYPE DEFAULT NULL,
        isbSerie            IN  or_order_items.serie%TYPE DEFAULT NULL,
        isbSalida           IN  or_order_items.out_%TYPE DEFAULT NULL
    );
    
    -- Procedimiento que se encarga de actualizar serial_items_id en los items de la orden
    PROCEDURE prcActualizaItemSeriado(inuOrden           IN or_order.order_id%type,
                                      inuItemSeriado	 IN or_order_activity.serial_items_id%type,
                                      onuError           OUT NUMBER,
                                      osbError           OUT VARCHAR2);


    -- Obtiene la cantidad legalizada para el item
    FUNCTION fnuObtieneCantLegalizada( inuIdItemOrden   IN  or_order_items.order_items_id%TYPE)
    RETURN or_order_items.LEGAL_ITEM_AMOUNT%TYPE;

    -- Obtiene el item
    FUNCTION fnuObtieneItem( inuIdItemOrden   IN  or_order_items.order_items_id%TYPE)
    RETURN or_order_items.items_id%TYPE;

    -- Actualiza cantidad legalizada, valor, precio total, salida, item serido y serie por Item de Orden
	PROCEDURE prcActCantLegValPrecTotSalSer
    (
        inuItemOrden        IN  or_order_items.order_items_id%TYPE,
        inuCantidad         IN  or_order_items.legal_item_amount%TYPE,
        inuValor            IN  or_order_items.value%TYPE,
        inuPrecioTotal      IN  or_order_items.total_price%TYPE,
        isbSalida           IN  or_order_items.out_%TYPE,
        inuItemSeriado      IN  or_order_items.serial_items_id%TYPE,
        isbSerie            IN  or_order_items.serie%TYPE
    );
    
    -- Obtiene el registro del item de la orden
    FUNCTION frcObtRegistroConOrderEitem
    ( 
        inuOrder    IN  or_order_items.order_id%TYPE,
        inuItem     IN  or_order_items.items_id%TYPE
    ) RETURN or_order_items%ROWTYPE;

    -- Retorna verdadero si existe el item en la orden
    FUNCTION fblExisteItemEnOrden
    (
        inuOrden                IN  or_order_items.order_id%TYPE,
        inuItem                 IN  or_order_items.items_id%TYPE
    ) 
    RETURN BOOLEAN;

    -- Actualiza cantidad legalizada, valor y precio total
	PROCEDURE prcActCantLegValorPrecTotal
    (
        inuItemOrden            IN  or_order_items.order_items_id%TYPE,
        inuCantidadLegalizada   IN  or_order_items.legal_item_amount%TYPE,
        inuValor                IN  or_order_items.value%TYPE,
        inuPrecioTotal          IN  or_order_items.total_price%TYPE
    ); 
    
    -- Retorna verdadero si existe el item de la orden
    FUNCTION fblExisteItemOrden
    (
        inuItemOrden    IN  or_order_items.order_items_id%TYPE
    ) 
    RETURN BOOLEAN;    

    -- Obtiene el registro del item de la orden
    FUNCTION frcObtRegistroConItemOrden
    ( 
        inuItemOrden    IN  or_order_items.order_items_id%TYPE
    ) RETURN or_order_items%ROWTYPE;

    -- Actualiza datos del registro consultando con el item de la orden
    PROCEDURE prcActDatosConItemOrden
    (
        inuItemOrden                or_order_items.order_items_id%TYPE,
        inuCantidadAsignada         or_order_items.assigned_item_amount%TYPE,
        inuCantidadLegalizada       or_order_items.legal_item_amount%TYPE,
        inuValor                    or_order_items.value%TYPE,
        inuPrecioTotal              or_order_items.total_price%TYPE,
        isbElemento                 or_order_items.element_code%TYPE,
        inuOrdenIdActividad         or_order_items.order_activity_id%TYPE,
        inuCodigoElemento           or_order_items.element_id%TYPE,
        isbReutilizado              or_order_items.reused%TYPE,
        inuItemSeriado              or_order_items.serial_items_id%TYPE,
        isbSerie                    or_order_items.serie%TYPE,
        isbSalida                   or_order_items.out_%TYPE
    );

    -- Inserta un registro de item para la orden    
    PROCEDURE prcInsRegistro
    (
        inuOrden                    or_order_items.order_id%TYPE,
        inuItem                     or_order_items.items_id%TYPE,
        inuCantidadAsignada         or_order_items.assigned_item_amount%TYPE,
        inuCantidadLegalizada       or_order_items.legal_item_amount%TYPE,
        inuValor                    or_order_items.value%TYPE,
        inuItemOrden                or_order_items.order_items_id%TYPE,        
        inuPrecioTotal              or_order_items.total_price%TYPE,
        isbElemento                 or_order_items.element_code%TYPE,
        inuOrdenIdActividad         or_order_items.order_activity_id%TYPE,
        inuCodigoElemento           or_order_items.element_id%TYPE,
        isbReutilizado              or_order_items.reused%TYPE,
        inuItemSeriado              or_order_items.serial_items_id%TYPE,
        isbSerie                    or_order_items.serie%TYPE,
        isbSalida                   or_order_items.out_%TYPE
    );
    
    -- Obtiene el máximo identificador del item en la orden
    FUNCTION fnuObtMaximoItemOrden( inuOrden NUMBER, inuItem NUMBER)
    RETURN or_order_items.order_items_id%TYPE;
    
    -- Obtiene la cantidad de items de la orden
    FUNCTION fnuObtCantItemsEnOrden( inuOrden IN  or_order_items.order_id%TYPE )
    RETURN NUMBER;  
    
    --Obtiene el valor de la orden
    FUNCTION fnuObtValorOrden(inuIdOrden IN or_order.order_id%type)
    RETURN NUMBER;      
    
END pkg_or_order_items;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_or_order_items IS

    --------------------------------------------
    -- Identificador del ultimo caso que hizo cambios
    --------------------------------------------
    csbVersion     VARCHAR2(15) := 'OSF-4336';

    --------------------------------------------
    -- Constantes para el control de la traza 
    --------------------------------------------  
    csbPqt_nombre   CONSTANT VARCHAR2(100) := $$PLSQL_UNIT;
    cnuNvlTrc       CONSTANT NUMBER        := pkg_traza.cnuNivelTrzDef;
    csbInicio       CONSTANT VARCHAR2(35)  := pkg_traza.csbInicio;
    csbFin          CONSTANT VARCHAR2(35)  := pkg_traza.csbFin;
    csbFin_err      CONSTANT VARCHAR2(35)  := pkg_traza.csbFin_err;
    csbFin_erc      CONSTANT VARCHAR2(35)  := pkg_traza.csbFin_erc;  
    
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
    nuError		NUMBER;  		
    sbMensaje   VARCHAR2(1000);  

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 09/02/2024
    Modificaciones  :
    Autor               Fecha       Caso     Descripcion
    felipe.valencia     09/02/2024  OSF-1909 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prc_actual_item_orden 
    Descripcion     : Registra en la tabla en la tabla or_order_items
    Autor           : Luis Felipe Valencia Hurtado - MVM 
    Fecha           : 13-12-2023 
    Modificaciones  :
    Autor               Fecha       Caso        Descripcion
    felipe.valencia     13-12-2023  OSF-1909    Creación
    ***************************************************************************/      
	PROCEDURE prc_actual_item_orden
    (
        inuOrden            IN  or_order_items.order_id%TYPE,
        inuItem             IN  or_order_items.items_id%TYPE,
        inuCantidadAsignada IN  or_order_items.assigned_item_amount%TYPE,
        inuCantidad         IN  or_order_items.legal_item_amount%TYPE,
        inuValor            IN  or_order_items.value%TYPE,
        inuPrecioTotal      IN  or_order_items.total_price%TYPE DEFAULT 0,
        isbElemennto        IN  or_order_items.element_code%TYPE DEFAULT NULL,
        inuOrdenIdActividad IN  or_order_items.order_activity_id%TYPE DEFAULT NULL,
        inuCodigoElemento   IN  or_order_items.element_id%TYPE DEFAULT NULL,
        isbReutilizado      IN  or_order_items.reused%TYPE DEFAULT NULL,
        inuItemSeriado      IN  or_order_items.serial_items_id%TYPE DEFAULT NULL,
        isbSerie            IN  or_order_items.serie%TYPE DEFAULT NULL,
        isbSalida           IN  or_order_items.out_%TYPE DEFAULT NULL
    )
    IS

        -----------------------------------------------------------------------------
        --                              CONSTANTES                                 --
        -----------------------------------------------------------------------------
        csbMT_NAME   CONSTANT VARCHAR2(100) := csbPqt_nombre||'prc_actual_item_orden';
        ------------------------------------------------------------------------------


        -----------------------------------------------------------------------------
        --                              VARIABLES                                  --
        -----------------------------------------------------------------------------
        nuExiste                NUMBER;  
        sbError                 VARCHAR2(4000);
        nuError                 NUMBER;     
        nuContar                NUMBER;   
        -----------------------------------------------------------------------------

        -----------------------------------------------------------------------------
        --                              CURSORES                                   --
        -----------------------------------------------------------------------------

        -----------------------------------------------------------------------------

        CURSOR cuItemsOrden 
        (
            inOrden             IN  or_order_items.order_id%TYPE,
            inuItem             IN  or_order_items.items_id%TYPE
        )
        IS
        SELECT  COUNT(1)
        FROM    or_order_items
        WHERE   order_id = inOrden
        AND     items_id = inuItem;

    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF (cuItemsOrden%ISOPEN) THEN
            CLOSE cuItemsOrden;
        END IF;

        OPEN cuItemsOrden(inuOrden, inuItem);
        FETCH cuItemsOrden INTO nuContar;
        CLOSE cuItemsOrden;

        IF (nuContar > 0) THEN
            UPDATE or_order_items
            SET     
                    assigned_item_amount = inuCantidadAsignada,
                    legal_item_amount 	 = inuCantidad,
                    value 				 = inuValor,
                    total_price          = inuPrecioTotal,
                    element_code         = isbElemennto,
                    order_activity_id    = inuOrdenIdActividad,
                    element_id           = inuCodigoElemento,
                    reused               = isbReutilizado,
                    serial_items_id      = inuItemSeriado,
                    serie                = isbSerie,
                    out_                 = isbSalida
            WHERE order_id = inuOrden
            AND   items_id = inuItem;
        ELSE 
            INSERT INTO or_order_items
            (
                order_id,
                items_id,
                assigned_item_amount,
                legal_item_amount,
                value,
                order_items_id,
                total_price,
                element_code,
                order_activity_id,
                element_id,
                reused,
                serial_items_id,
                serie,
                out_
            )
            VALUES
            (
                inuOrden,
                inuItem,
                inuCantidadAsignada,
                inuCantidad,
                inuValor,
                seq_or_order_items.nextval,
                inuPrecioTotal,
                isbElemennto,
                inuOrdenIdActividad,
                inuCodigoElemento,
                isbReutilizado,
                inuItemSeriado,
                isbSerie,
                isbSalida
            );
        END IF;

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);        
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;                
    END prc_actual_item_orden;
    
    /**************************************************************************
    Autor       : Jhon Soto
    Fecha       : 21/11/2024
    Ticket      : OSF-3591
    Proceso     : prcActualizaItemSeriado
    Descripcion : procedimiento que se encarga de actualizar serial_items_id en los items de la orden
    
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    04/12/2024   PAcosta     OSF-3612: Migración de la bd de EFG a GDC por ajustes de información de 
                                       la entidad HOMOLOGACION_SERVICIOS - GDC 
    ***************************************************************************/

    PROCEDURE prcActualizaItemSeriado(inuOrden           IN or_order.order_id%type,
									  inuItemSeriado	 IN or_order_activity.serial_items_id%type,
									  onuError           OUT NUMBER,
									  osbError           OUT VARCHAR2) IS

        csbMT_NAME VARCHAR2(100) := csbPqt_nombre ||
                                    '.prcActualizaItemSeriado';
    BEGIN
        pkg_traza.trace(csbMT_NAME,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbINICIO);
        pkg_traza.trace('Orden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('Item Seriado: ' || inuItemSeriado,
                        pkg_traza.cnuNivelTrzDef);
        pkg_error.prInicializaError(onuError, osbError);
    
			UPDATE or_order_items
			SET serial_items_id = inuItemSeriado
			WHERE ORDER_id = inuOrden;
    
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
    

    /**************************************************************************
    Autor       : Lubin Pineda
    Fecha       : 25/02/2025
    Ticket      : OSF-4042
    Proceso     : fnuObtieneCantLegalizada
    Descripcion : Obtiene la cantidad legalizada para el item
    
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/    
    FUNCTION fnuObtieneCantLegalizada( inuIdItemOrden   IN  or_order_items.order_items_id%TYPE)
    RETURN or_order_items.LEGAL_ITEM_AMOUNT%TYPE
    IS
        csbMT_NAME VARCHAR2(100) := csbPqt_nombre || '.fnuObtieneCantLegalizada';
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
        
        nuCantidadLegalizada    or_order_items.LEGAL_ITEM_AMOUNT%TYPE;
        
        CURSOR cuObtieneCantLegalizada
        IS
        SELECT LEGAL_ITEM_AMOUNT
        FROM or_order_items oi
        WHERE oi.order_items_id = inuIdItemOrden;
        
        PROCEDURE prcCierraCursor
        IS
            csbMT_NAME1 VARCHAR2(135) := csbMT_NAME || '.prcCierraCursor';

            nuError1     NUMBER;
            sbError1     VARCHAR2(4000);
                
        BEGIN
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO); 
                
            IF cuObtieneCantLegalizada%ISOPEN THEN
                CLOSE cuObtieneCantLegalizada;
            END IF;
            
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN); 

        EXCEPTION
            WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError1, sbError1);
            pkg_traza.trace(' sbError1 => ' || sbError1, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
            WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError1, sbError1);
            pkg_traza.trace(' sbError1 => ' || sbError1, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);            
        END prcCierraCursor;
        
    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);  

        OPEN cuObtieneCantLegalizada;
        FETCH cuObtieneCantLegalizada INTO  nuCantidadLegalizada;
        CLOSE cuObtieneCantLegalizada;
        
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN nuCantidadLegalizada;
    
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
            prcCierraCursor;
            RETURN nuCantidadLegalizada;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
            prcCierraCursor;
            RETURN nuCantidadLegalizada;
    END fnuObtieneCantLegalizada;

    -- Obtiene el item
    FUNCTION fnuObtieneItem( inuIdItemOrden   IN  or_order_items.order_items_id%TYPE)
    RETURN or_order_items.items_id%TYPE
    IS
        csbMT_NAME VARCHAR2(100) := csbPqt_nombre || '.fnuObtieneItem';
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
        
        nuItem    or_order_items.items_id%TYPE;
        
        CURSOR cuObtieneItem
        IS
        SELECT items_id
        FROM or_order_items oi
        WHERE oi.order_items_id = inuIdItemOrden;
        
        PROCEDURE prcCierraCursor
        IS
            csbMT_NAME1 VARCHAR2(135) := csbMT_NAME || '.prcCierraCursor';

            nuError1     NUMBER;
            sbError1     VARCHAR2(4000);
                
        BEGIN
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO); 
                
            IF cuObtieneItem%ISOPEN THEN
                CLOSE cuObtieneItem;
            END IF;
            
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN); 

        EXCEPTION
            WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError1, sbError1);
            pkg_traza.trace(' sbError1 => ' || sbError1, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
            WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError1, sbError1);
            pkg_traza.trace(' sbError1 => ' || sbError1, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);            
        END prcCierraCursor;
        
    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);  

        OPEN cuObtieneItem;
        FETCH cuObtieneItem INTO  nuItem;
        CLOSE cuObtieneItem;
        
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN nuItem;
    
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
            prcCierraCursor;
            RETURN nuItem;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
            prcCierraCursor;
            RETURN nuItem;
    END fnuObtieneItem;     

    -- Actualiza cantidad legalizada, valor, precio total, salida, item serido y serie por Item de Orden
    PROCEDURE prcActCantLegValPrecTotSalSer
    (
        inuItemOrden        IN  or_order_items.order_items_id%TYPE,
        inuCantidad         IN  or_order_items.legal_item_amount%TYPE,
        inuValor            IN  or_order_items.value%TYPE,
        inuPrecioTotal      IN  or_order_items.total_price%TYPE,
        isbSalida           IN  or_order_items.out_%TYPE,
        inuItemSeriado      IN  or_order_items.serial_items_id%TYPE,
        isbSerie            IN  or_order_items.serie%TYPE
    )
    IS
        csbMT_NAME VARCHAR2(100) := csbPqt_nombre || '.prc_actual_item_orden';
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
        UPDATE or_order_items
        SET
        legal_item_amount = inuCantidad,
        value   = inuValor,
        total_price = inuPrecioTotal,
        out_ = isbSalida,
        serial_items_id = inuItemSeriado,
        serie = isbSerie
        WHERE order_items_id = inuItemOrden;
                        
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;
    END prcActCantLegValPrecTotSalSer;     
    
    -- Obtiene el registro del item de la orden
    FUNCTION frcObtRegistroConOrderEitem
    ( 
        inuOrder    IN  or_order_items.order_id%TYPE,
        inuItem     IN  or_order_items.items_id%TYPE
    ) RETURN or_order_items%ROWTYPE    
    IS
        csbMT_NAME VARCHAR2(100) := csbPqt_nombre || '.frcObtRegistroConOrderEitem';
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
        
        rcRegistro  or_order_items%ROWTYPE;
        
        CURSOR cuObtRegistro
        IS
        SELECT *
        FROM or_order_items oi
        WHERE oi.order_id = inuOrder
        AND oi.items_id = inuItem;
        
        PROCEDURE prcCierraCursor
        IS
            csbMT_NAME1 VARCHAR2(135) := csbMT_NAME || '.prcCierraCursor';

            nuError1     NUMBER;
            sbError1     VARCHAR2(4000);
                
        BEGIN
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO); 
                
            IF cuObtRegistro%ISOPEN THEN
                CLOSE cuObtRegistro;
            END IF;
            
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN); 

        EXCEPTION
            WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError1, sbError1);
            pkg_traza.trace(' sbError1 => ' || sbError1, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
            WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError1, sbError1);
            pkg_traza.trace(' sbError1 => ' || sbError1, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);            
        END prcCierraCursor;
        
        
    BEGIN

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
        OPEN cuObtRegistro;
        FETCH cuObtRegistro INTO rcRegistro;
        CLOSE cuObtRegistro;

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN rcRegistro;
    
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
            RETURN rcRegistro;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
            RETURN rcRegistro;
    END frcObtRegistroConOrderEitem;

    -- Retorna verdadero si existe el item en la orden
    FUNCTION fblExisteItemEnOrden
    (
        inuOrden                IN  or_order_items.order_id%TYPE,
        inuItem                 IN  or_order_items.items_id%TYPE
    ) 
    RETURN BOOLEAN
    IS
        csbMT_NAME VARCHAR2(100) := csbPqt_nombre || '.fblExisteItemEnOrden';
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
        
        blExisteItemOrden   BOOLEAN;
        
        nuOrderItemsId      or_order_items.order_items_id%TYPE;

        CURSOR cuExisteItemOrden
        IS
        SELECT order_items_id
        FROM or_order_items oi
        WHERE oi.order_id = inuOrden
        AND oi.items_id = inuItem;
        
        PROCEDURE prcCierraCursor
        IS
            csbMT_NAME1 VARCHAR2(135) := csbMT_NAME || '.prcCierraCursor';

            nuError1     NUMBER;
            sbError1     VARCHAR2(4000);
                
        BEGIN
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO); 
                
            IF cuExisteItemOrden%ISOPEN THEN
                CLOSE cuExisteItemOrden;
            END IF;
            
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN); 

        EXCEPTION
            WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError1, sbError1);
            pkg_traza.trace(' sbError1 => ' || sbError1, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
            WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError1, sbError1);
            pkg_traza.trace(' sbError1 => ' || sbError1, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);            
        END prcCierraCursor;
                
    BEGIN

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
        OPEN cuExisteItemOrden;
        FETCH cuExisteItemOrden INTO nuOrderItemsId;
        CLOSE cuExisteItemOrden;
        
        blExisteItemOrden := nuOrderItemsId IS NOT NULL;
               
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN blExisteItemOrden;

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
            prcCierraCursor;
            RETURN blExisteItemOrden;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
            prcCierraCursor;
            RETURN blExisteItemOrden;          
    END fblExisteItemEnOrden;    
    
    -- Actualiza cantidad legalizada, valor y precio total por Orden e Item
	PROCEDURE prcActCantLegValorPrecTotal
    (
        inuItemOrden            IN  or_order_items.order_items_id%TYPE,
        inuCantidadLegalizada   IN  or_order_items.legal_item_amount%TYPE,
        inuValor                IN  or_order_items.value%TYPE,
        inuPrecioTotal          IN  or_order_items.total_price%TYPE
    )
    IS
        csbMT_NAME VARCHAR2(100) := csbPqt_nombre || '.prcActCantLegValorPrecTotal';
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        UPDATE or_order_items
        SET
        legal_item_amount = inuCantidadLegalizada,
        value   = inuValor,
        total_price = inuPrecioTotal
        WHERE order_items_id = inuItemOrden;
                
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);            
    
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;
    END prcActCantLegValorPrecTotal;    

    -- Retorna verdadero si existe el item de la orden
    FUNCTION fblExisteItemOrden
    (
        inuItemOrden    IN  or_order_items.order_items_id%TYPE
    ) 
    RETURN BOOLEAN
    IS
        csbMT_NAME VARCHAR2(100) := csbPqt_nombre || '.fblExisteItemOrden';
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
        
        blExisteItemOrden   BOOLEAN;
        
        nuOrderItemsId      or_order_items.order_items_id%TYPE;

        CURSOR cuExisteItemOrden
        IS
        SELECT order_items_id
        FROM or_order_items oi
        WHERE oi.order_items_id = inuItemOrden;
        
        PROCEDURE prcCierraCursor
        IS
            csbMT_NAME1 VARCHAR2(135) := csbMT_NAME || '.prcCierraCursor';

            nuError1     NUMBER;
            sbError1     VARCHAR2(4000);
                
        BEGIN
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO); 
                
            IF cuExisteItemOrden%ISOPEN THEN
                CLOSE cuExisteItemOrden;
            END IF;
            
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN); 

        EXCEPTION
            WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError1, sbError1);
            pkg_traza.trace(' sbError1 => ' || sbError1, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
            WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError1, sbError1);
            pkg_traza.trace(' sbError1 => ' || sbError1, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);            
        END prcCierraCursor;
                
    BEGIN

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
        OPEN cuExisteItemOrden;
        FETCH cuExisteItemOrden INTO nuOrderItemsId;
        CLOSE cuExisteItemOrden;
               
        blExisteItemOrden := nuOrderItemsId IS NOT NULL;
        
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN blExisteItemOrden;

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
            prcCierraCursor;
            RETURN blExisteItemOrden;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
            prcCierraCursor;
            RETURN blExisteItemOrden;          
    END fblExisteItemOrden;  

    -- Obtiene el registro del item de la orden
    FUNCTION frcObtRegistroConItemOrden
    ( 
        inuItemOrden    IN  or_order_items.order_items_id%TYPE
    ) RETURN or_order_items%ROWTYPE 
    IS
        csbMT_NAME VARCHAR2(100) := csbPqt_nombre || '.frcObtRegistroConItemOrden';
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
        
        rcRegistro  or_order_items%ROWTYPE;
        
        CURSOR cuObtRegistro
        IS
        SELECT *
        FROM or_order_items oi
        WHERE oi.order_items_id = inuItemOrden;
        
        PROCEDURE prcCierraCursor
        IS
            csbMT_NAME1 VARCHAR2(135) := csbMT_NAME || '.prcCierraCursor';

            nuError1     NUMBER;
            sbError1     VARCHAR2(4000);
                
        BEGIN
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO); 
                
            IF cuObtRegistro%ISOPEN THEN
                CLOSE cuObtRegistro;
            END IF;
            
            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN); 

        EXCEPTION
            WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError1, sbError1);
            pkg_traza.trace(' sbError1 => ' || sbError1, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
            WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError1, sbError1);
            pkg_traza.trace(' sbError1 => ' || sbError1, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);            
        END prcCierraCursor;
        
        
    BEGIN

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
        OPEN cuObtRegistro;
        FETCH cuObtRegistro INTO rcRegistro;
        CLOSE cuObtRegistro;

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN rcRegistro;
    
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
            RETURN rcRegistro;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
            RETURN rcRegistro;
    END frcObtRegistroConItemOrden;
    
    -- Actualiza datos del registro consultando con el item de la orden
    PROCEDURE prcActDatosConItemOrden
    (
        inuItemOrden                or_order_items.order_items_id%TYPE,
        inuCantidadAsignada         or_order_items.assigned_item_amount%TYPE,
        inuCantidadLegalizada       or_order_items.legal_item_amount%TYPE,
        inuValor                    or_order_items.value%TYPE,
        inuPrecioTotal              or_order_items.total_price%TYPE,
        isbElemento                 or_order_items.element_code%TYPE,
        inuOrdenIdActividad         or_order_items.order_activity_id%TYPE,
        inuCodigoElemento           or_order_items.element_id%TYPE,
        isbReutilizado              or_order_items.reused%TYPE,
        inuItemSeriado              or_order_items.serial_items_id%TYPE,
        isbSerie                    or_order_items.serie%TYPE,
        isbSalida                   or_order_items.out_%TYPE
    )
    IS
        csbMT_NAME VARCHAR2(100) := csbPqt_nombre || '.prcActDatosConItemOrden';
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
        Update or_order_items ooi
        Set ooi.assigned_item_amount = inuCantidadAsignada,
        ooi.legal_item_amount    = inuCantidadLegalizada,
        ooi.value                = inuValor,
        ooi.total_price          = inuPrecioTotal,
        ooi.element_code         = isbElemento,
        ooi.order_activity_id    = inuOrdenIdActividad,
        ooi.element_id           = inuCodigoElemento,
        ooi.reused               = isbReutilizado,
        ooi.serial_items_id      = inuItemSeriado,
        ooi.serie                = isbSerie,
        ooi.out_                 = isbSalida
        Where ooi.order_items_id = inuItemOrden;        

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);            
    
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;
    END prcActDatosConItemOrden; 
    
    -- Inserta un registro de item para la orden
    PROCEDURE prcInsRegistro
    (
        inuOrden                    or_order_items.order_id%TYPE,
        inuItem                     or_order_items.items_id%TYPE,
        inuCantidadAsignada         or_order_items.assigned_item_amount%TYPE,
        inuCantidadLegalizada       or_order_items.legal_item_amount%TYPE,
        inuValor                    or_order_items.value%TYPE,
        inuItemOrden                or_order_items.order_items_id%TYPE,        
        inuPrecioTotal              or_order_items.total_price%TYPE,
        isbElemento                 or_order_items.element_code%TYPE,
        inuOrdenIdActividad         or_order_items.order_activity_id%TYPE,
        inuCodigoElemento           or_order_items.element_id%TYPE,
        isbReutilizado              or_order_items.reused%TYPE,
        inuItemSeriado              or_order_items.serial_items_id%TYPE,
        isbSerie                    or_order_items.serie%TYPE,
        isbSalida                   or_order_items.out_%TYPE
    )
    IS
        csbMT_NAME VARCHAR2(100) := csbPqt_nombre || '.prcInsRegistro';
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);    

        INSERT INTO or_order_items
        (
            order_id
            ,items_id
            ,assigned_item_amount
            ,legal_item_amount
            ,value
            ,order_items_id
            ,total_price
            ,element_code
            ,order_activity_id
            ,element_id
            ,reused
            ,serial_items_id
            ,serie
            ,out_
        )
        VALUES
        (
            inuOrden,
            inuItem,
            inuCantidadAsignada,
            inuCantidadLegalizada,
            inuValor,
            inuItemOrden,
            inuPrecioTotal,
            isbElemento,
            inuOrdenIdActividad,
            inuCodigoElemento,
            isbReutilizado,
            inuItemSeriado,
            isbSerie,
            isbSalida
        );
        
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);            
    
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;
    END prcInsRegistro;       
         
    -- Obtiene el máximo identificador del item en la orden
    FUNCTION fnuObtMaximoItemOrden( inuOrden NUMBER, inuItem NUMBER)
    RETURN or_order_items.order_items_id%TYPE
    IS

        csbMT_NAME VARCHAR2(100) := csbPqt_nombre || '.fnuObtMaximoItemOrden';
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
            
        nuMaximoItemOrden   or_order_items.order_items_id%TYPE;
    
        CURSOR cuObtMaximoItemOrden
        IS
        SELECT MAX(ooi.order_items_id)
        FROM or_order_items ooi
        WHERE ooi.order_id = inuOrden
        AND ooi.items_id = inuItem;
        
        PROCEDURE prcCierraCursor
        IS

            csbMT_NAME1 VARCHAR2(100) := csbPqt_nombre || '.prcCierraCursor';
            
            nuError1     NUMBER;
            sbError1     VARCHAR2(4000);        
        
        BEGIN

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
                
            IF cuObtMaximoItemOrden%ISOPEN THEN
                CLOSE cuObtMaximoItemOrden;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        EXCEPTION
            WHEN pkg_error.CONTROLLED_ERROR THEN
                pkg_error.geterror(nuError, sbError);
                pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
                pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
                RAISE pkg_error.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                pkg_error.setError;
                pkg_error.geterror(nuError, sbError);
                pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
                pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
                RAISE pkg_error.CONTROLLED_ERROR;
        END prcCierraCursor;

    BEGIN


        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
        OPEN cuObtMaximoItemOrden;
        FETCH cuObtMaximoItemOrden  INTO    nuMaximoItemOrden;
        CLOSE cuObtMaximoItemOrden;    

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN nuMaximoItemOrden;            
    
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
            prcCierraCursor;
            RETURN nuMaximoItemOrden;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
            prcCierraCursor;
            RETURN nuMaximoItemOrden;   
    END fnuObtMaximoItemOrden;

    -- Obtiene la cantidad de items de la orden
    FUNCTION fnuObtCantItemsEnOrden( inuOrden IN  or_order_items.order_id%TYPE )
    RETURN NUMBER
    IS
        csbMT_NAME VARCHAR2(100) := csbPqt_nombre || '.fnuObtCantItemsEnOrden';
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
            
        nuCantItemsEnOrden   NUMBER := 0;
    
        CURSOR cuObtCantItemsEnOrden
        IS
        SELECT COUNT(1) cantidad
        FROM or_order_items ooi
        WHERE ooi.order_id = inuOrden;
        
        PROCEDURE prcCierraCursor
        IS

            csbMT_NAME1 VARCHAR2(100) := csbPqt_nombre || '.prcCierraCursor';
            
            nuError1     NUMBER;
            sbError1     VARCHAR2(4000);        
        
        BEGIN

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
                
            IF cuObtCantItemsEnOrden%ISOPEN THEN
                CLOSE cuObtCantItemsEnOrden;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        EXCEPTION
            WHEN pkg_error.CONTROLLED_ERROR THEN
                pkg_error.geterror(nuError, sbError);
                pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
                pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
                RAISE pkg_error.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                pkg_error.setError;
                pkg_error.geterror(nuError, sbError);
                pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
                pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
                RAISE pkg_error.CONTROLLED_ERROR;
        END prcCierraCursor;

    BEGIN


        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
        OPEN cuObtCantItemsEnOrden;
        FETCH cuObtCantItemsEnOrden  INTO    nuCantItemsEnOrden;
        CLOSE cuObtCantItemsEnOrden;    

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN nuCantItemsEnOrden;            
    
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
            prcCierraCursor;
            RETURN nuCantItemsEnOrden;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
            prcCierraCursor;
            RETURN nuCantItemsEnOrden;   
    END fnuObtCantItemsEnOrden;   
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fnuObtValorOrden 
    Descripcion     : Obtiene el valor de la orden
					  
    Autor           : Paola Acosta
    Fecha           : 13/05/2025
	
    Modificaciones  :
    Autor           Fecha       	Caso        Descripcion
    Paola.Acosta	13/05/2025   	OSF-4336    Creacion
    ***************************************************************************/  
    FUNCTION fnuObtValorOrden(inuIdOrden IN or_order.order_id%TYPE)
    RETURN NUMBER
    IS
        --Constantes
        csbMetodo CONSTANT VARCHAR2(70) := csbPqt_nombre||'fnuObtValorOrden';
        
        --Variables
        onuValorOrden NUMBER;
        
        --Cursores
        CURSOR cuValorOrden
        IS
        SELECT SUM(nvl(or_order_items.total_price, 0)) valor
        FROM or_order_items
        WHERE or_order_items.order_id = inuIdOrden
        AND or_order_items.out_ = 'Y';
        
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbInicio);
        
        OPEN cuValorOrden;
        FETCH cuValorOrden INTO onuValorOrden;
        CLOSE cuValorOrden;
        
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin);
        
        RETURN onuValorOrden;        
     
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin_erc);
            pkg_Error.getError(nuError,sbMensaje);
            pkg_traza.trace('sbMensaje => '||sbMensaje, cnuNvlTrc );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin_err);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbMensaje);
            pkg_traza.trace('sbMensaje => '||sbMensaje, cnuNvlTrc );
            RAISE pkg_error.Controlled_Error;
    END fnuObtValorOrden;     
                          
END pkg_or_order_items;
/

PROMPT Otorgando permisos de ejecución para adm_person.pkg_or_order_items
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_OR_ORDER_ITEMS', 'ADM_PERSON');
END;
/

