create or replace package ADM_PERSON.PKG_PRODUCTO IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PKG_PRODUCTO
    Descripcion     : Paquete para contener servicio realcioandos a la entidad PR_PRODUCT y sus componentes
    Autor           : Jorge Valiente
    Fecha           : 22-06-2023
  
    Parametros de Entrada
      isbProceso    nombre del proceso
      inuTotalRegi  total de registros a procesar
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso      Descripcion
    dsaltarin   11/07/2024  OSF-3266  Se aegrega el método prActualizaMetodoAnVarCon
    jcatuche    04/07/2024  OSF-3266  Se agrega el método  prActualizaCiclos
    jerazomvm   07/09/2023  OSF-1530  Se crea el procedimiento PRACTUALIZAESTADOCORTE
  ***************************************************************************/

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PRACTUALIZAESTADOPRODUCTO
    Descripcion     : proceso que actualiza estado del producto
    Autor           : Jorge Valiente
    Fecha           : 22-06-2023
  
    Parametros de Entrada
      isbProceso    nombre del proceso
      inuTotalRegi  total de registros a procesar
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
  PROCEDURE prActualizaEstadoProducto(inuproduct_id        IN pr_product.product_id%TYPE,
                                      inuproduct_status_id IN pr_product.product_status_id%TYPE);

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PRACTUALIZAFECHAINSTALACION
    Descripcion     : proceso que actualiza fecha de instalacion del servicio
    Autor           : Jorge Valiente
    Fecha           : 22-06-2023
  
    Parametros de Entrada
      isbProceso    nombre del proceso
      inuTotalRegi  total de registros a procesar
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
  PROCEDURE prActualizaFechaInstalacion(inusesunuse IN servsusc.sesunuse%TYPE,
                                        idtsesufein IN servsusc.sesufein%TYPE);

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PRACTUALIZAESTADOCORTE
    Descripcion     : proceso que actualiza el estado de corte del servicio
    Autor           : Jhon Erazo
    Fecha           : 07/09/2023
  
    Parametros de Entrada
      inusesunuse Identificador del servicio suscrito
    inusesuesco Estado de corte
    idtFechaCorte Fecha de Corte
    
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso      Descripcion
  jerazomvm 07/09/2023  OSF-1530  Creación
  ***************************************************************************/
  PROCEDURE prActualizaEstadoCorte(inusesunuse   IN servsusc.sesunuse%TYPE,
                                   inusesuesco   IN servsusc.sesuesco%TYPE,
                                   idtFechaCorte date default null);

  --Actualiza Utilma Actividad Suspension
  PROCEDURE prcActualizaUltActSuspension(inuProducto            number,
                                         inuActividadSuspension number);

  --proceso que actualiza inclucion del servicio del producto
    PROCEDURE prcActualizaInclusion (inuProducto    NUMBER,
                                     isbInclusion   VARCHAR2);

    -- Actualiza ciclos
    PROCEDURE prActualizaCiclos 
    (
        inuProducto   IN servsusc.sesunuse%TYPE,
        inuCiclo      IN servsusc.sesucicl%TYPE,
        inuCico       IN servsusc.sesucico%TYPE
    );
    
    -- Actualiza método de ánalisis de variación de consumo
    PROCEDURE prActualizaMetodoAnVarCon 
    (
        inuProducto   IN servsusc.sesunuse%TYPE,
        inuMetodo     IN servsusc.sesumecv%TYPE
    );

    -- Actualiza categoría y subcategoría por contrato
    PROCEDURE prcActuCategoriaySubcategoria 
    (
        inucontrato       IN servsusc.sesususc%TYPE,
        inuCategoria      IN servsusc.sesucate%TYPE,
        inuSubCategoria   IN servsusc.sesusuca%TYPE
    );
END PKG_PRODUCTO;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_PRODUCTO
IS
    -- Constantes para el control de la traza
    csbSP_NAME           CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;                -- Constante para nombre de función    
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
    --Variables generales
    sberror             VARCHAR2(4000);
    nuerror             NUMBER;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PRACTUALIZAESTADOPRODUCTO
    Descripcion     : proceso que actualiza estado del producto
    Autor           : Jorge Valiente
    Fecha           : 22-06-2023
  
    Parametros de Entrada
      isbProceso    nombre del proceso
      inuTotalRegi  total de registros a procesar
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
    PROCEDURE prActualizaEstadoProducto (
        inuproduct_id          IN pr_product.product_id%TYPE,
        inuproduct_status_id   IN pr_product.product_status_id%TYPE)
    IS
        csbMetodo   VARCHAR2(70) := csbSP_NAME||'PRACTUALIZAESTADOPRODUCTO';
  BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuproduct_id          <= '||inuproduct_id, csbNivelTraza);
        pkg_traza.trace('inuproduct_status_id   <= '||inuproduct_status_id, csbNivelTraza);
        
    UPDATE pr_product
       SET product_status_id = inuproduct_status_id
     WHERE product_id = inuproduct_id;
  
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);        
  EXCEPTION
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' ||sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            raise pkg_Error.Controlled_Error;
  END prActualizaEstadoProducto;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PRACTUALIZAFECHAINSTALACION
    Descripcion     : proceso que actualiza fecha de instalacion del servicio
    Autor           : Jorge Valiente
    Fecha           : 22-06-2023
  
    Parametros de Entrada
      isbProceso    nombre del proceso
      inuTotalRegi  total de registros a procesar
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
    PROCEDURE prActualizaFechaInstalacion (
        inusesunuse   IN servsusc.sesunuse%TYPE,
        idtsesufein   IN servsusc.sesufein%TYPE)
    IS
        csbMetodo   VARCHAR2(70) := csbSP_NAME||'PRACTUALIZAFECHAINSTALACION';
  BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inusesunuse   <= '||inusesunuse, csbNivelTraza);
        pkg_traza.trace('idtsesufein   <= '||idtsesufein, csbNivelTraza);
  
    UPDATE servsusc
       SET sesufein = idtsesufein
     WHERE sesunuse = inusesunuse;
  
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
  EXCEPTION
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' ||sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            raise pkg_Error.Controlled_Error;
  END prActualizaFechaInstalacion;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PRACTUALIZAESTADOCORTE
    Descripcion     : proceso que actualiza el estado de corte del servicio
    Autor           : Jhon Erazo
    Fecha           : 07/09/2023
  
    Parametros de Entrada
      inusesunuse Identificador del servicio suscrito
    inusesuesco Estado de corte
    
    Parametros de Salida
  
    Modificaciones :
    =========================================================
    Autor       Fecha       Caso      Descripcion
  jerazomvm 07/09/2023  OSF-1530  Creación
  ***************************************************************************/
    PROCEDURE prActualizaEstadoCorte (
        inusesunuse     IN servsusc.sesunuse%TYPE,
                                   inusesuesco   IN servsusc.sesuesco%TYPE,
        idtFechaCorte      DATE DEFAULT NULL)
    IS
        csbMetodo   VARCHAR2(70) := csbSP_NAME||'PRACTUALIZAESTADOCORTE';
  BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inusesunuse   <= '||inusesunuse, csbNivelTraza);
        pkg_traza.trace('inusesuesco   <= '||inusesuesco, csbNivelTraza);
        pkg_traza.trace('idtFechaCorte <= '||idtFechaCorte, csbNivelTraza);
  
    UPDATE servsusc
       SET sesuesco = inusesuesco, sesufeco = idtFechaCorte
     WHERE sesunuse = inusesunuse;
  
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
  EXCEPTION
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' ||sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            raise pkg_Error.Controlled_Error;
  END PRACTUALIZAESTADOCORTE;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : prcActualizaUltActSuspension
  Descripcion     : Actualiza Utilma Actividad Suspension
  Autor           : Jorge Valiente
  Fecha           : 18/03/2024
  
  Parametros de Entrada
  inuProducto                 Codido del Producto
  inuActividadSuspension      Codigo de ultima actividad de suspension
  
  Parametros de Salida
  
  Modificaciones  :
  Autor       Fecha       Caso     Descripcion
  ***************************************************************************/
    PROCEDURE prcActualizaUltActSuspension (inuProducto              NUMBER,
                                            inuActividadSuspension   NUMBER)
    IS
    -- Nombre de este metodo
        csbMetodo   VARCHAR2(70) := csbSP_NAME||'prcActualizaUltActSuspension';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error
  BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto            <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuActividadSuspension <= '||inuActividadSuspension, csbNivelTraza);
  
    UPDATE PR_PRODUCT
       SET SUSPEN_ORD_ACT_ID = inuActividadSuspension
     WHERE PRODUCT_ID = inuProducto;
  
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);        
  EXCEPTION
    WHEN OTHERS THEN
      pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' ||sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
  END prcActualizaUltActSuspension;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcActualizaInclusion
    Descripcion     : proceso que actualiza inclucion del servicio del producto
    Autor           : Jorge Valiente
    Fecha           : 24-04-2024
  
    Parametros de Entrada
      inuProducto  Codigo del producto
      isbInclusion inclusion del producto
    
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso      Descripcion
  ***************************************************************************/
    PROCEDURE prcActualizaInclusion (inuProducto    NUMBER,
                                     isbInclusion   VARCHAR2)
    IS
        csbMetodo   VARCHAR2(70) := csbSP_NAME||'prcActualizaInclusion';
    nuError   NUMBER;
    sbmensaje VARCHAR2(1000);
  
  BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('isbInclusion   <= '||isbInclusion, csbNivelTraza);
  
    UPDATE servsusc
       SET sesuincl = isbInclusion
     WHERE sesunuse = inuProducto;
  
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' ||sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            raise pkg_Error.Controlled_Error;
    END prcActualizaInclusion;
  
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaCiclos 
    Descripcion     : Actualiza ciclos del producto
    Autor           : jcatuche
    Fecha           : 04-0172024 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jcatuche    04-07-2024  OSF-3266    Creacion
    ***************************************************************************/   
    PROCEDURE prActualizaCiclos 
    (
        inuProducto   IN servsusc.sesunuse%TYPE,
        inuCiclo      IN servsusc.sesucicl%TYPE,
        inuCico       IN servsusc.sesucico%TYPE
    )
	IS
        csbMetodo   VARCHAR2(70) := csbSP_NAME||'prActualizaCiclos';
		
	BEGIN    
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
		pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza); 
		pkg_traza.trace('inuCiclo       <= '||inuCiclo, csbNivelTraza);  
		pkg_traza.trace('inuCico        <= '||inuCico, csbNivelTraza);        
    
        UPDATE servsusc
		SET sesucicl = inuCiclo,sesucico = inuCico
		WHERE sesunuse = inuProducto;
            
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);        
  EXCEPTION
        WHEN OTHERS THEN
      pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' ||sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            raise pkg_Error.Controlled_Error;	
    END prActualizaCiclos;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaMetodoAnVarCon 
    Descripcion     : Actualiza metodo de analisis de variación de consumo del producto
    Autor           : dsaltarin
    Fecha           : 11-09-2024 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    dsaltarin    11-09-2024  OSF-3266    Creacion
    ***************************************************************************/   
    PROCEDURE prActualizaMetodoAnVarCon 
    (
        inuProducto   IN servsusc.sesunuse%TYPE,
        inuMetodo     IN servsusc.sesumecv%TYPE
    )
	IS
        csbMetodo   VARCHAR2(70) := csbSP_NAME||'prActualizaMetodoAnVarCon';
		
	BEGIN    
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
		pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza); 
		pkg_traza.trace('inuMetodo       <= '||inuMetodo, csbNivelTraza);       
    
    UPDATE servsusc
		SET sesumecv = inuMetodo
		WHERE sesunuse = inuProducto;
            
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);        
  EXCEPTION
        WHEN OTHERS THEN
      pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' ||sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            raise pkg_Error.Controlled_Error;	
    END prActualizaMetodoAnVarCon;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcActuCategoriaySubcategoria 
    Descripcion     : Actualiza categoria y subcategoria por contrato
    Autor           : felipe.valencia
    Fecha           : 25-11-2024 
    Modificaciones  :
    Autor               Fecha         Caso        Descripcion
    felipe.valencia     25-11-2024    OSF-3607    Creacion
    ***************************************************************************/   
    PROCEDURE prcActuCategoriaySubcategoria 
    (
        inucontrato       IN servsusc.sesususc%TYPE,
        inuCategoria      IN servsusc.sesucate%TYPE,
        inuSubCategoria   IN servsusc.sesusuca%TYPE
    )
    IS
          csbMetodo   VARCHAR2(70) := csbSP_NAME||'prcActuCategoriaySubcategoria';
      
    BEGIN    
      pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
      pkg_traza.trace('inucontrato    <= '||inucontrato, csbNivelTraza); 
      pkg_traza.trace('inuCategoria   <= '||inuCategoria, csbNivelTraza);     
      pkg_traza.trace('inuSubCategoria <= '||inuSubCategoria, csbNivelTraza);      
      
      pr_boproduct.updprodcatbycontract(inucontrato, inuCategoria, inuSubCategoria);
              
      pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);        
    EXCEPTION
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_Error.Controlled_Error;  
    WHEN OTHERS THEN
        pkg_Error.setError;
              pkg_Error.getError(nuError, sbError);
              pkg_traza.trace('sbError: ' ||sbError, csbNivelTraza);
              pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
              raise pkg_Error.Controlled_Error;	
    END prcActuCategoriaySubcategoria;

END PKG_PRODUCTO;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_PRODUCTO', 'ADM_PERSON');
END;
/