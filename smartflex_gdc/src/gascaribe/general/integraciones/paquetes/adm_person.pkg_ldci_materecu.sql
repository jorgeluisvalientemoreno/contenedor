CREATE OR REPLACE PACKAGE adm_person.pkg_ldci_materecu IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_ldci_materecu
    Autor       :   Luis Felipe Valencia Hurtado
    Fecha       :   28-06-2024
    Descripcion :   Paquete con los metodos para manejo de información sobre las 
					tablas LDCI_MATERECU

    Modificaciones  :
    Autor               Fecha           Caso        Descripcion
    felipe.valencia     28-06-2024      OSF-2793    Creacion
*******************************************************************************/

    FUNCTION fsbVersion RETURN VARCHAR2;

    -- Retorna la causal de la orden
    PROCEDURE prInsertaMaterialRecuperado
    (
        inuItem             IN  ge_items.items_id%TYPE,
        isbTipoMaterial     IN  VARCHAR2,
        idtFechaRegistro    IN  DATE,
        onuError            OUT NUMBER,
        osbError            OUT VARCHAR2
    );

    PROCEDURE prActualizaMaterialRecuperado
    (
        inuItem             IN  ge_items.items_id%TYPE,
        isbTipoMaterial     IN  VARCHAR2,
        idtFechaRegistro    IN  DATE,
        onuError            OUT NUMBER,
        osbError            OUT VARCHAR2
    );

END pkg_ldci_materecu;

/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldci_materecu IS

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
    Proceso     : prInsertaControlMaterial
    Descripcion : Realiza el registro de material recuperado

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE prInsertaMaterialRecuperado
    (
        inuItem             IN  ge_items.items_id%TYPE,
        isbTipoMaterial     IN  VARCHAR2,
        idtFechaRegistro    IN  DATE,
        onuError            OUT NUMBER,
        osbError            OUT VARCHAR2
    ) 
    IS
      
        csbMT_NAME VARCHAR2(100) := csbSP_NAME || '.prInsertaMaterialRecuperado';
    
    BEGIN
      
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_error.prInicializaError(onuError, osbError);

        INSERT INTO LDCI_MATERECU (ITEMS_ID, TIPOMATE, FECHREGI)
        VALUES (inuItem, isbTipoMaterial, idtFechaRegistro);

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
    END prInsertaMaterialRecuperado;

    /**************************************************************************
    Autor       : Luis Felipe Valencia Hurtado
    Fecha       : 28/06/2024
    Ticket      : OSF-2793
    Proceso     : prActualizaMaterialRecuperado
    Descripcion : Realiza actualiza material recuperado

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE prActualizaMaterialRecuperado
    (
        inuItem             IN  ge_items.items_id%TYPE,
        isbTipoMaterial     IN  VARCHAR2,
        idtFechaRegistro    IN  DATE,
        onuError            OUT NUMBER,
        osbError            OUT VARCHAR2
    ) 
    IS
      
        csbMT_NAME VARCHAR2(100) := csbSP_NAME || '.prInsertaMaterialRecuperado';
    
    BEGIN
      
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_error.prInicializaError(onuError, osbError);

        UPDATE  LDCI_MATERECU
        SET     TIPOMATE = isbTipoMaterial, FECHREGI = idtFechaRegistro
        WHERE   ITEMS_ID = inuItem;

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
    END prActualizaMaterialRecuperado;
END pkg_ldci_materecu;
/

PROMPT Otorgando permisos de ejecución para adm_person.pkg_ldci_materecu
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_LDCI_MATERECU', 'ADM_PERSON');
END;
/