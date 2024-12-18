CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_REPORTES_TARIFA_TRANS
IS
/**************************************************************************
    Propiedad intelectual de Gases del Caribe S.A (c).
            
    Nombre      :   PKG_REPORTES_TARIFA_TRANS
    Descripción :   Paquete de primer nivel para la tabla REPORTES_TARIFA_TRANS
    Autor       :   jcatuchemvm
    Fecha       :   25/10/2024
            
    Historial de Modificaciones
    ---------------------------------------------------------------------------
    Fecha         Autor         Descripcion
    =====         =======       ===============================================
    25/10/2024    jcatuche      OSF-3387: Creación del paquete 
***************************************************************************/
    subtype styReporteTarifaTrans   is  REPORTES_TARIFA_TRANS%rowtype;   
    
    TYPE TYREPORTE           IS TABLE OF REPORTES_TARIFA_TRANS.REPORTE%TYPE INDEX BY BINARY_INTEGER;         
    TYPE TYCENTRO_BENEFICIO  IS TABLE OF REPORTES_TARIFA_TRANS.CENTRO_BENEFICIO%TYPE INDEX BY BINARY_INTEGER;
    TYPE TYLOCALIDAD         IS TABLE OF REPORTES_TARIFA_TRANS.LOCALIDAD%TYPE INDEX BY BINARY_INTEGER;
    TYPE TYLOCADESC          IS TABLE OF REPORTES_TARIFA_TRANS.LOCADESC%TYPE INDEX BY BINARY_INTEGER;        
    TYPE TYDEPADESC          IS TABLE OF REPORTES_TARIFA_TRANS.DEPADESC%TYPE INDEX BY BINARY_INTEGER;        
    TYPE TYCONTRATO          IS TABLE OF REPORTES_TARIFA_TRANS.CONTRATO%TYPE INDEX BY BINARY_INTEGER;        
    TYPE TYPRODUCTO          IS TABLE OF REPORTES_TARIFA_TRANS.PRODUCTO%TYPE INDEX BY BINARY_INTEGER;        
    TYPE TYCATEGORIA         IS TABLE OF REPORTES_TARIFA_TRANS.CATEGORIA%TYPE INDEX BY BINARY_INTEGER;       
    TYPE TYESTRATO           IS TABLE OF REPORTES_TARIFA_TRANS.ESTRATO%TYPE INDEX BY BINARY_INTEGER;         
    TYPE TYACTIVO            IS TABLE OF REPORTES_TARIFA_TRANS.ACTIVO%TYPE INDEX BY BINARY_INTEGER;          
    TYPE TYFECHA_ULTLIQ      IS TABLE OF REPORTES_TARIFA_TRANS.FECHA_ULTLIQ%TYPE INDEX BY BINARY_INTEGER;    
    TYPE TYFECHA_FINAL       IS TABLE OF REPORTES_TARIFA_TRANS.FECHA_FINAL%TYPE INDEX BY BINARY_INTEGER;     
    TYPE TYFECHA_CAMBIO      IS TABLE OF REPORTES_TARIFA_TRANS.FECHA_CAMBIO%TYPE INDEX BY BINARY_INTEGER;    
    TYPE TYFECHA_ANO         IS TABLE OF REPORTES_TARIFA_TRANS.FECHA_ANO%TYPE INDEX BY BINARY_INTEGER;       
    TYPE TYCUENTA            IS TABLE OF REPORTES_TARIFA_TRANS.CUENTA%TYPE INDEX BY BINARY_INTEGER;          
    TYPE TYVALOR_NOTA        IS TABLE OF REPORTES_TARIFA_TRANS.VALOR_NOTA%TYPE INDEX BY BINARY_INTEGER;      
    TYPE TYVALOR_CR          IS TABLE OF REPORTES_TARIFA_TRANS.VALOR_CR%TYPE INDEX BY BINARY_INTEGER;        
    TYPE TYVALOR_DB          IS TABLE OF REPORTES_TARIFA_TRANS.VALOR_DB%TYPE INDEX BY BINARY_INTEGER;        
    TYPE TYVALOR_L1TOTAL     IS TABLE OF REPORTES_TARIFA_TRANS.VALOR_L1TOTAL%TYPE INDEX BY BINARY_INTEGER;   
    TYPE TYVALOR_L1          IS TABLE OF REPORTES_TARIFA_TRANS.VALOR_L1%TYPE INDEX BY BINARY_INTEGER;        
    TYPE TYVALOR_L1SA        IS TABLE OF REPORTES_TARIFA_TRANS.VALOR_L1SA%TYPE INDEX BY BINARY_INTEGER;      
    TYPE TYVALOR_L1ANUL      IS TABLE OF REPORTES_TARIFA_TRANS.VALOR_L1ANUL%TYPE INDEX BY BINARY_INTEGER;    
    TYPE TYVALOR_L1DESC      IS TABLE OF REPORTES_TARIFA_TRANS.VALOR_L1DESC%TYPE INDEX BY BINARY_INTEGER;    
    TYPE TYVALOR_L1ING       IS TABLE OF REPORTES_TARIFA_TRANS.VALOR_L1ING%TYPE INDEX BY BINARY_INTEGER;     
    TYPE TYVALOR_CARGOTOTAL  IS TABLE OF REPORTES_TARIFA_TRANS.VALOR_CARGOTOTAL%TYPE INDEX BY BINARY_INTEGER;
    TYPE TYVALOR_CARGO       IS TABLE OF REPORTES_TARIFA_TRANS.VALOR_CARGO%TYPE INDEX BY BINARY_INTEGER;     
    TYPE TYCLASIFICACION     IS TABLE OF REPORTES_TARIFA_TRANS.CLASIFICACION%TYPE INDEX BY BINARY_INTEGER;   
    TYPE TYOBSERVACION       IS TABLE OF REPORTES_TARIFA_TRANS.OBSERVACION%TYPE INDEX BY BINARY_INTEGER;     
    TYPE TYERROR             IS TABLE OF REPORTES_TARIFA_TRANS.ERROR%TYPE INDEX BY BINARY_INTEGER;
    
    TYPE TYTBREPORTES_TARIFA_TRANS IS RECORD
    (
        REPORTE          TYREPORTE,         
        CENTRO_BENEFICIO TYCENTRO_BENEFICIO,
        LOCALIDAD        TYLOCALIDAD,       
        LOCADESC         TYLOCADESC,        
        DEPADESC         TYDEPADESC,        
        CONTRATO         TYCONTRATO,        
        PRODUCTO         TYPRODUCTO,        
        CATEGORIA        TYCATEGORIA,      
        ESTRATO          TYESTRATO,         
        ACTIVO           TYACTIVO,          
        FECHA_ULTLIQ     TYFECHA_ULTLIQ,    
        FECHA_FINAL      TYFECHA_FINAL,     
        FECHA_CAMBIO     TYFECHA_CAMBIO,    
        FECHA_ANO        TYFECHA_ANO,       
        CUENTA           TYCUENTA,          
        VALOR_NOTA       TYVALOR_NOTA,      
        VALOR_CR         TYVALOR_CR,        
        VALOR_DB         TYVALOR_DB,        
        VALOR_L1TOTAL    TYVALOR_L1TOTAL,   
        VALOR_L1         TYVALOR_L1,       
        VALOR_L1SA       TYVALOR_L1SA,      
        VALOR_L1ANUL     TYVALOR_L1ANUL,    
        VALOR_L1DESC     TYVALOR_L1DESC,   
        VALOR_L1ING      TYVALOR_L1ING,     
        VALOR_CARGOTOTAL TYVALOR_CARGOTOTAL,
        VALOR_CARGO      TYVALOR_CARGO,     
        CLASIFICACION    TYCLASIFICACION,   
        OBSERVACION      TYOBSERVACION,     
        ERROR            TYERROR
    );           
      
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
    --Inserta registro
    PROCEDURE prInsRegistro(ircRegistro IN styReporteTarifaTrans);
    
    --Inserta registros
    PROCEDURE prInsRegistros(irctbRegistro IN OUT NOCOPY TYTBREPORTES_TARIFA_TRANS);
    
    --Borra registro
    PROCEDURE prBorRegistro(isbReporte IN VARCHAR2, inuLocalidad IN NUMBER, inuProducto IN NUMBER, inuCuenta IN NUMBER);
    
    --Trunca tabla
    PROCEDURE prTruncaTabla;
    
    

END PKG_REPORTES_TARIFA_TRANS;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_REPORTES_TARIFA_TRANS
IS    
    -- Constantes para el control de la traza
    csbSP_NAME          CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';          -- Constante para nombre de objeto    
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para este objeto. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
    -------------------------
    --  PRIVATE VARIABLES
    -------------------------
    nuError             NUMBER;
    sbError             VARCHAR2(2000);
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsRegistro
    Descripcion     : Inserción de registro
    
    Parametros de Entrada 
    ==================== 
        ircRegistro     Registro a registrar
    
    Parametros de Salida
    ====================
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	25/10/2024      jcatuche            OSF-3387: Creación
    ***************************************************************************/
    PROCEDURE prInsRegistro(ircRegistro IN styReporteTarifaTrans) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        csbMetodo   VARCHAR2(100) := csbSP_NAME|| 'prInsRegistro';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        INSERT INTO REPORTES_TARIFA_TRANS
        (
            REPORTE,          
            CENTRO_BENEFICIO,
            LOCALIDAD,
            LOCADESC,       
            DEPADESC,        
            CONTRATO,        
            PRODUCTO,        
            CATEGORIA,        
            ESTRATO,       
            ACTIVO,         
            FECHA_ULTLIQ,     
            FECHA_FINAL,    
            FECHA_CAMBIO,     
            FECHA_ANO,    
            CUENTA,       
            VALOR_NOTA,       
            VALOR_CR,      
            VALOR_DB,        
            VALOR_L1TOTAL,    
            VALOR_L1,   
            VALOR_L1SA,       
            VALOR_L1ANUL,     
            VALOR_L1DESC,    
            VALOR_L1ING,    
            VALOR_CARGOTOTAL, 
            VALOR_CARGO,
            CLASIFICACION,    
            OBSERVACION,   
            ERROR          
        )
        VALUES
        (
            ircRegistro.REPORTE,          
            ircRegistro.CENTRO_BENEFICIO,
            ircRegistro.LOCALIDAD,
            ircRegistro.LOCADESC,       
            ircRegistro.DEPADESC,        
            ircRegistro.CONTRATO,        
            ircRegistro.PRODUCTO,        
            ircRegistro.CATEGORIA,        
            ircRegistro.ESTRATO,       
            ircRegistro.ACTIVO,         
            ircRegistro.FECHA_ULTLIQ,     
            ircRegistro.FECHA_FINAL,    
            ircRegistro.FECHA_CAMBIO,     
            ircRegistro.FECHA_ANO,    
            ircRegistro.CUENTA,       
            ircRegistro.VALOR_NOTA,       
            ircRegistro.VALOR_CR,      
            ircRegistro.VALOR_DB,        
            ircRegistro.VALOR_L1TOTAL,    
            ircRegistro.VALOR_L1,   
            ircRegistro.VALOR_L1SA,       
            ircRegistro.VALOR_L1ANUL,     
            ircRegistro.VALOR_L1DESC,    
            ircRegistro.VALOR_L1ING,    
            ircRegistro.VALOR_CARGOTOTAL, 
            ircRegistro.VALOR_CARGO,
            ircRegistro.CLASIFICACION,    
            ircRegistro.OBSERVACION,   
            ircRegistro.ERROR
        );
        
        COMMIT;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN DUP_VAL_ON_INDEX THEN
            sbError := 'El registro ya existe. Reporte ['||ircRegistro.REPORTE||'] - Localidad ['||ircRegistro.LOCALIDAD||'] - Producro ['||ircRegistro.PRODUCTO||'] - Cuenta ['||ircRegistro.CUENTA||']';
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            pkg_error.setErrorMessage( isbMsgErrr => sbError);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prInsRegistro;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsRegistros
    Descripcion     : Inserción de registros
    
    Parametros de Entrada 
    ==================== 
        irctbRegistro     Registro de tabla a registrar
    
    Parametros de Salida
    ====================
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	25/10/2024      jcatuche            OSF-3387: Creación
    ***************************************************************************/
    PROCEDURE prInsRegistros(irctbRegistro IN OUT NOCOPY TYTBREPORTES_TARIFA_TRANS) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        csbMetodo   VARCHAR2(100) := csbSP_NAME|| 'prInsRegistros';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        FORALL indx IN irctbRegistro.REPORTE.first..irctbRegistro.REPORTE.last
            INSERT INTO REPORTES_TARIFA_TRANS
            (
                REPORTE,          
                CENTRO_BENEFICIO,
                LOCALIDAD,
                LOCADESC,       
                DEPADESC,        
                CONTRATO,        
                PRODUCTO,        
                CATEGORIA,        
                ESTRATO,       
                ACTIVO,         
                FECHA_ULTLIQ,     
                FECHA_FINAL,    
                FECHA_CAMBIO,     
                FECHA_ANO,    
                CUENTA,       
                VALOR_NOTA,       
                VALOR_CR,      
                VALOR_DB,        
                VALOR_L1TOTAL,    
                VALOR_L1,   
                VALOR_L1SA,       
                VALOR_L1ANUL,     
                VALOR_L1DESC,    
                VALOR_L1ING,    
                VALOR_CARGOTOTAL, 
                VALOR_CARGO,
                CLASIFICACION,    
                OBSERVACION,   
                ERROR          
            )
            VALUES
            (
                irctbRegistro.REPORTE(indx),          
                irctbRegistro.CENTRO_BENEFICIO(indx),
                irctbRegistro.LOCALIDAD(indx),
                irctbRegistro.LOCADESC(indx),       
                irctbRegistro.DEPADESC(indx),        
                irctbRegistro.CONTRATO(indx),        
                irctbRegistro.PRODUCTO(indx),        
                irctbRegistro.CATEGORIA(indx),        
                irctbRegistro.ESTRATO(indx),       
                irctbRegistro.ACTIVO(indx),         
                irctbRegistro.FECHA_ULTLIQ(indx),     
                irctbRegistro.FECHA_FINAL(indx),    
                irctbRegistro.FECHA_CAMBIO(indx),     
                irctbRegistro.FECHA_ANO(indx),    
                irctbRegistro.CUENTA(indx),       
                irctbRegistro.VALOR_NOTA(indx),       
                irctbRegistro.VALOR_CR(indx),      
                irctbRegistro.VALOR_DB(indx),        
                irctbRegistro.VALOR_L1TOTAL(indx),    
                irctbRegistro.VALOR_L1(indx),   
                irctbRegistro.VALOR_L1SA(indx),       
                irctbRegistro.VALOR_L1ANUL(indx),     
                irctbRegistro.VALOR_L1DESC(indx),    
                irctbRegistro.VALOR_L1ING(indx),    
                irctbRegistro.VALOR_CARGOTOTAL(indx), 
                irctbRegistro.VALOR_CARGO(indx),
                irctbRegistro.CLASIFICACION(indx),    
                irctbRegistro.OBSERVACION(indx),   
                irctbRegistro.ERROR(indx)
            );
        
        COMMIT;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN DUP_VAL_ON_INDEX THEN
            sbError := 'El registro ya existe. Reporte ['||irctbRegistro.REPORTE(1)||']';
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            pkg_error.setErrorMessage( isbMsgErrr => sbError);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prInsRegistros;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prBorRegistro
    Descripcion     : Borrado de registro
    
    Parametros de Entrada 
    ====================   
        isbReporte      Tipo de reporte
        inuLocalidad    Identificador localidad
        inuCuenta       Identificador de la cuenta
    
    Parametros de Salida
    ====================
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	25/10/2024      jcatuche            OSF-3387: Creación
    ***************************************************************************/
    PROCEDURE prBorRegistro(isbReporte IN VARCHAR2, inuLocalidad IN NUMBER, inuProducto IN NUMBER, inuCuenta IN NUMBER) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        csbMetodo   VARCHAR2(100) := csbSP_NAME|| 'prBorRegistro';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        DELETE REPORTES_TARIFA_TRANS
        WHERE REPORTE = isbReporte
        AND LOCALIDAD = inuLocalidad
        AND PRODUCTO  = inuProducto
        AND CUENTA    = inuCuenta; 
        
        COMMIT;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prBorRegistro;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prTruncaTabla
    Descripcion     : Borrado de registro
    
    Parametros de Entrada 
    ====================   
        isbReporte      Tipo de reporte
        inuLocalidad    Identificador localidad
        inuCuenta       Identificador de la cuenta
    
    Parametros de Salida
    ====================
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	25/10/2024      jcatuche            OSF-3387: Creación
    ***************************************************************************/
    PROCEDURE prTruncaTabla IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        csbMetodo   VARCHAR2(100) := csbSP_NAME|| 'prTruncaTabla';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        EXECUTE IMMEDIATE 'TRUNCATE TABLE REPORTES_TARIFA_TRANS';
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prTruncaTabla;
       
END PKG_REPORTES_TARIFA_TRANS;
/
PROMPT Otorga Permisos de Ejecución a personalizaciones.PKG_REPORTES_TARIFA_TRANS
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_REPORTES_TARIFA_TRANS','PERSONALIZACIONES');
END;
/
