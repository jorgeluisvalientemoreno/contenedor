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
    felipe.valencia     09/01/2024      OSF-1909    Creacion
*******************************************************************************/

    -- Retona el identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion 
    RETURN VARCHAR2;

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

END pkg_or_order_items;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_or_order_items IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion     VARCHAR2(15) := 'OSF-1909';
    -- Constantes para el control de la traza
    csbSP_NAME     CONSTANT VARCHAR2(35):= $$PLSQL_UNIT;

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
        csbMT_NAME   CONSTANT VARCHAR2(100) := csbSP_NAME||'prc_actual_item_orden';
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
END pkg_or_order_items;
/
PROMPT Otorgando permisos de ejecución para adm_person.pkg_or_order_items
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_OR_ORDER_ITEMS', 'ADM_PERSON');
END;
/ 