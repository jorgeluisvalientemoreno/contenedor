CREATE OR REPLACE PACKAGE adm_person.pkg_ldci_itemtmp IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_ldci_itemtmp
    Autor       :   Luis Felipe Valencia Hurtado
    Fecha       :   28-06-2024
    Descripcion :   Paquete con los metodos para manejo de información sobre las 
					tablas ldci_itemtmp

    Modificaciones  :
    Autor               Fecha           Caso        Descripcion
    felipe.valencia     28-06-2024      OSF-2793    Creacion
*******************************************************************************/

    FUNCTION fsbVersion RETURN VARCHAR2;

    -- Retorna la causal de la orden
    PROCEDURE prInsertaInformacionItemTmp
    (
        isbItem         IN  ldci_itemtmp.item_code%TYPE,
        isbDescripcion  IN  ldci_itemtmp.description%TYPE,
        inuUnidadMedida IN  ldci_itemtmp.measure_unit%TYPE, 
        isbRecuperado   IN  ldci_itemtmp.is_recovery%TYPE, 
        inuItemRecuperado   IN  ldci_itemtmp.recovery_item%TYPE, 
        inuEstadoInicial    IN ldci_itemtmp.init_status%TYPE,
        isbObsoleto     IN  ldci_itemtmp.obsolete%TYPE,
        inuCategoria    IN  ldci_itemtmp.items_gama%TYPE,
        onuError    OUT NUMBER,
        osbError    OUT VARCHAR2
    );

    PROCEDURE prEliminaTemporalItem;

END pkg_ldci_itemtmp;

/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldci_itemtmp IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-2793';

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35):= $$PLSQL_UNIT||'.';
    cnuNVLTRC 	CONSTANT NUMBER := 5;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 28/06/2024
    Modificaciones  :
    Autor               Fecha       Caso        Descripcion
    felipe.valencia     28/06/2024  OSF-2793    Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /**************************************************************************
    Autor       : Luis Felipe Valencia Hurtado
    Fecha       : 28/06/2024
    Ticket      : OSF-2793
    Proceso     : prInsertaInformacionItemTmp
    Descripcion : Inserta en información del item en la tabla temporal

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE prInsertaInformacionItemTmp
    (
        isbItem         IN  ldci_itemtmp.item_code%TYPE,
        isbDescripcion  IN  ldci_itemtmp.description%TYPE,
        inuUnidadMedida IN  ldci_itemtmp.measure_unit%TYPE, 
        isbRecuperado   IN  ldci_itemtmp.is_recovery%TYPE, 
        inuItemRecuperado   IN  ldci_itemtmp.recovery_item%TYPE, 
        inuEstadoInicial    IN ldci_itemtmp.init_status%TYPE,
        isbObsoleto     IN  ldci_itemtmp.obsolete%TYPE,
        inuCategoria    IN  ldci_itemtmp.items_gama%TYPE,
        onuError    OUT NUMBER,
        osbError    OUT VARCHAR2
    )
    IS
      
        csbMT_NAME VARCHAR2(100) := csbSP_NAME || '.prInsertaInformacionItemTmp';
    
    BEGIN
      
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_error.prInicializaError(onuError, osbError);

        INSERT INTO LDCI_ITEMTMP 
        (
            ITEM_CODE,
            DESCRIPTION,
            MEASURE_UNIT,
            IS_RECOVERY,
            RECOVERY_ITEM,
            INIT_STATUS,
            OBSOLETE,
            ITEMS_GAMA
        )
        VALUES 
        (
            isbItem,
            isbDescripcion,
            inuUnidadMedida,
            isbRecuperado,
            inuItemRecuperado,
            inuEstadoInicial,
            isbObsoleto,
            inuCategoria
        );

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(onuError, osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(onuError, osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END prInsertaInformacionItemTmp;

    /**************************************************************************
    Autor       : Luis Felipe Valencia Hurtado
    Fecha       : 28/06/2024
    Ticket      : OSF-2793
    Proceso     : prEliminaTemporalItem
    Descripcion : Inserta en información del item en la tabla temporal

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE prEliminaTemporalItem
    IS
      
        csbMT_NAME VARCHAR2(100) := csbSP_NAME || '.prEliminaTemporalItem';
        onuError    NUMBER;
        osbError    VARCHAR2(4000);
    BEGIN
      
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        DELETE FROM Ldci_Itemtmp;

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(onuError, osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(onuError, osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END prEliminaTemporalItem;
END pkg_ldci_itemtmp; 
/

PROMPT Otorgando permisos de ejecución para adm_person.pkg_ldci_itemtmp
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_LDCI_ITEMTMP', 'ADM_PERSON');
END;
/