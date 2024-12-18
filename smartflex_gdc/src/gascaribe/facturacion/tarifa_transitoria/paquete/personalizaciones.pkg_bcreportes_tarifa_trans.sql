CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_BCREPORTES_TARIFA_TRANS
IS
/**************************************************************************
    Propiedad intelectual de Gases del Caribe S.A (c).
            
    Nombre      :   PKG_BCREPORTES_TARIFA_TRANS
    Descripción :   Paquete de servicios para reportes tarifa transitoria
    Autor       :   jcatuchemvm
    Fecha       :   25/10/2024
            
    Historial de Modificaciones
    ---------------------------------------------------------------------------
    Fecha         Autor         Descripcion
    =====         =======       ===============================================
    25/10/2024    jcatuche      OSF-3387: Creación del paquete 
***************************************************************************/
                
    --------------------------------------------
    -- Variables
    --------------------------------------------
    cursor cuAgrupaSaldos (isbReporte in reportes_tarifa_trans.reporte%type) is
    select reporte,centro_beneficio,localidad,locadesc,depadesc,clasificacion,
    sum(valor_nota)    valor_nota,
    sum(valor_cr)      valor_cr,
    sum(valor_db)      valor_db
    from reportes_tarifa_trans
    where reporte = isbReporte
    group by reporte,centro_beneficio,localidad,locadesc,depadesc,clasificacion;
    
    type tytbAgrupaSaldos is table of cuAgrupaSaldos%rowtype index by binary_integer;
    
    cursor cuAgrupaLiquidacion (isbReporte in reportes_tarifa_trans.reporte%type) is
    select reporte,centro_beneficio,localidad,locadesc,depadesc,
    max(fecha_ano)          fecha_ano,
    sum(valor_nota)         valor_nota,
    sum(valor_l1total)      valor_l1total,
    sum(valor_l1)           valor_l1,
    sum(valor_l1sa)         valor_l1sa,
    sum(valor_l1anul)       valor_l1anul,
    sum(valor_l1desc)       valor_l1desc,
    sum(valor_l1ing)        valor_l1ing,
    sum(valor_cargototal)   valor_cargototal,
    sum(valor_cargo)        valor_cargo
    from reportes_tarifa_trans
    where reporte = isbReporte
    group by reporte,centro_beneficio,localidad,locadesc,depadesc;
    
    type tytbAgrupaLiquidacion is table of cuAgrupaLiquidacion%rowtype index by binary_integer;
        
    
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
    --Obtiene saldos agrupados
    PROCEDURE prObtieneSaldos(isbReporte in reportes_tarifa_trans.reporte%type,otbSaldos out nocopy tytbAgrupaSaldos);
    
    --Obtiene liquidación agrupada
    PROCEDURE prObtieneLiquidacion(isbReporte in reportes_tarifa_trans.reporte%type,otbLiquidacion out nocopy tytbAgrupaLiquidacion);
    
    

END PKG_BCREPORTES_TARIFA_TRANS;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BCREPORTES_TARIFA_TRANS
IS    
    -- Constantes para el control de la traza
    csbSP_NAME          CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';           -- Constante para nombre de objeto    
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
    Programa        : prObtieneSaldos
    Descripcion     : Obtiene saldos tarifa transitoria agrupados
    
    Parametros de Entrada 
    ====================     
        isbReporte  Identificador del reporte a agrupar
    Parametros de Salida
    ====================
        otbSaldos   Tabla con saldos agrupados
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	25/10/2024      jcatuche            OSF-3387: Creación
    ***************************************************************************/
    PROCEDURE prObtieneSaldos(isbReporte in reportes_tarifa_trans.reporte%type,otbSaldos out nocopy tytbAgrupaSaldos) IS
        csbMetodo   VARCHAR2(100) := csbSP_NAME|| 'prObtieneSaldos';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        if cuAgrupaSaldos%isopen then close cuAgrupaSaldos; end if;
        
        open cuAgrupaSaldos(isbReporte);
        fetch cuAgrupaSaldos bulk collect into otbSaldos;
        close cuAgrupaSaldos;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            raise pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            raise pkg_Error.Controlled_Error;
    END prObtieneSaldos;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prObtieneLiquidacion
    Descripcion     : Obtiene liquidación tarifa transitoria agrupada
    
    Parametros de Entrada 
    ====================     
        isbReporte      Identificador del reporte a agrupar
    Parametros de Salida
    ====================
        otbLiquidacion  Tabla con liquidación tarifa transitoria agrupada
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	25/10/2024      jcatuche            OSF-3387: Creación
    ***************************************************************************/
    PROCEDURE prObtieneLiquidacion(isbReporte in reportes_tarifa_trans.reporte%type,otbLiquidacion out nocopy tytbAgrupaLiquidacion) IS
        csbMetodo   VARCHAR2(100) := csbSP_NAME|| 'prObtieneLiquidacion';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        if cuAgrupaLiquidacion%isopen then close cuAgrupaLiquidacion; end if;
        
        open cuAgrupaLiquidacion(isbReporte);
        fetch cuAgrupaLiquidacion bulk collect into otbLiquidacion;
        close cuAgrupaLiquidacion;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            raise pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            raise pkg_Error.Controlled_Error;
    END prObtieneLiquidacion;

END PKG_BCREPORTES_TARIFA_TRANS;
/
PROMPT Otorga Permisos de Ejecución a personalizaciones.PKG_BCREPORTES_TARIFA_TRANS
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BCREPORTES_TARIFA_TRANS','PERSONALIZACIONES');
END;
/
