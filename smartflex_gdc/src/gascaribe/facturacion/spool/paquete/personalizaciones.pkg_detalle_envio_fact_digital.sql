CREATE OR REPLACE PACKAGE personalizaciones.PKG_DETALLE_ENVIO_FACT_DIGITAL IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bccontrato
    Autor       :   Luis Felipe Valencia - MVM
    Fecha       :   13-12-2023
    Descripcion :   Paquete con los métodos CRUD para manejo de información
                    sobre la tabla PERSONALIZACIONES.DETALLE_ENVIO_FACT_DIGITAL
    Modificaciones  :
    Autor               Fecha       Caso        Descripcion
    felipe.valencia     13-12-2023  OSF-1939    Creación
*******************************************************************************/

    -- Retona Identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion RETURN VARCHAR2;
    

	PROCEDURE prc_reg_envio_fact_digital
    (
        inuContrato         IN  detalle_envio_fact_digital.contrato%TYPE,
        inuFactura          IN  detalle_envio_fact_digital.factura%TYPE,
        inuPeriodoFact      IN  detalle_envio_fact_digital.periodo_facturacion%TYPE
    );

	PROCEDURE prc_borra_envio_fact_digital
    (
        inuContrato         IN  detalle_envio_fact_digital.contrato%TYPE,
        inuFactura          IN  detalle_envio_fact_digital.factura%TYPE,
        inuPeriodoFact      IN  detalle_envio_fact_digital.periodo_facturacion%TYPE
    );
END PKG_DETALLE_ENVIO_FACT_DIGITAL;
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.PKG_DETALLE_ENVIO_FACT_DIGITAL IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion                 VARCHAR2(15) := 'OSF-1939';

    -- Constantes para el control de la traza
    csbNOMPKG            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Luis Felipe Valencia Hurtado - MVM 
    Fecha           : 27-07-2023 
    Modificaciones  :
    Autor               Fecha       Caso        Descripcion
    felipe.valencia     13-12-2023  OSF-1939    Creación
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;


    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prc_reg_envio_fact_digital 
    Descripcion     : Registra en la tabla en la tabla DETALLE_ENVIO_FACT_DIGITAL
    Autor           : Luis Felipe Valencia Hurtado - MVM 
    Fecha           : 13-12-2023 
    Modificaciones  :
    Autor               Fecha       Caso        Descripcion
    felipe.valencia     13-12-2023  OSF-1939    Creación
    ***************************************************************************/      
	PROCEDURE prc_reg_envio_fact_digital
    (
        inuContrato         IN  detalle_envio_fact_digital.contrato%TYPE,
        inuFactura          IN  detalle_envio_fact_digital.factura%TYPE,
        inuPeriodoFact      IN  detalle_envio_fact_digital.periodo_facturacion%TYPE
    )
    IS

        -----------------------------------------------------------------------------
        --                              CONSTANTES                                 --
        -----------------------------------------------------------------------------
        csbMetodo   CONSTANT VARCHAR2(100) := csbNOMPKG||'prc_reg_envio_fact_digital';
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
        -----------------------------------------------------------------------------
        
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        INSERT INTO detalle_envio_fact_digital (contrato, factura, periodo_facturacion, fecha_registro)
        VALUES (inuContrato, inuFactura,inuPeriodoFact, sysdate);
            
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
    END prc_reg_envio_fact_digital;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prc_borra_envio_fact_digital 
    Descripcion     : Borra en la tabla en la tabla DETALLE_ENVIO_FACT_DIGITAL
    Autor           : Luis Felipe Valencia Hurtado - MVM 
    Fecha           : 13-12-2023 
    Modificaciones  :
    Autor               Fecha       Caso        Descripcion
    felipe.valencia     13-12-2023  OSF-1939    Creación
    ***************************************************************************/      
	PROCEDURE prc_borra_envio_fact_digital
    (
        inuContrato         IN  detalle_envio_fact_digital.contrato%TYPE,
        inuFactura          IN  detalle_envio_fact_digital.factura%TYPE,
        inuPeriodoFact      IN  detalle_envio_fact_digital.periodo_facturacion%TYPE
    )
    IS

        -----------------------------------------------------------------------------
        --                              CONSTANTES                                 --
        -----------------------------------------------------------------------------
        csbMetodo   CONSTANT VARCHAR2(100) := csbNOMPKG||'prc_borra_envio_fact_digital';
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
        -----------------------------------------------------------------------------
        
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
        DELETE
        FROM    detalle_envio_fact_digital
        WHERE   contrato = inuContrato
        AND     periodo_facturacion = inuPeriodoFact
        AND     factura = inuFactura;

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
    END prc_borra_envio_fact_digital;
    
    
END PKG_DETALLE_ENVIO_FACT_DIGITAL;
/

PROMPT Otorgando permisos de ejecución para personalizaciones.PKG_DETALLE_ENVIO_FACT_DIGITAL
BEGIN
    pkg_utilidades.prAplicarPermisos('PERSONALIZACIONES', upper('PKG_DETALLE_ENVIO_FACT_DIGITAL'));
END;
/