create or replace package ADM_PERSON.PKG_COMPONENTE_PRODUCTO IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PKG_COMPONENTE_PRODUCTO
    Descripcion     : Paquete para contener servicio realcioandos a las entidades PR_COMPONENT Y COMPSESU
    Autor           : Jorge Valiente
    Fecha           : 22-06-2023
  
    Parametros de Entrada
      isbProceso    nombre del proceso
      inuTotalRegi  total de registros a procesar
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso      Descripcion
    jeerazomvm  01-03-2024  OSF-2374  1. Se crea el procedimiento prcActEstadoPr_Component
    jpinedc     03-02-2025  OSF-3893  Se crea prcRetiroComponente
    PAcosta     21-04-2025  OSF-4270  Se crean variables globales
                                      Se crea metodo prcActSoloEstadoComponente
  ***************************************************************************/

  --OSF-2477
  --Estado Componente Producto
  cnuEstadoCompProductoRetirado CONSTANT number := 9;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PRACTUALIZAESTADOCOMPONENTE
    Descripcion     : proceso que actualiza estado de los componentes del producto
    Autor           : Jorge Valiente
    Fecha           : 22-06-2023
  
    Parametros de Entrada
      inuproduct_id         Identificador del producto.
      inucomponent_status_id    Identificador del estado del componente.
    
  Parametros de salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso      Descripcion
  jerazomvm 11/09/2023  OSF-1530  Se agrega actualización del estado del componente
                    de la tabla compsesu.
  ***************************************************************************/
  PROCEDURE PRACTUALIZAESTADOCOMPONENTE(inuproduct_id          IN pr_product.product_id%TYPE,
                                        inucomponent_status_id IN pr_component.component_status_id%TYPE);

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PRACTUALIZAFECHAINSTALACION
    Descripcion     : proceso que actualiza la fecha de instalación
    Autor           : Dsaltarin
    Fecha           : 15-09-2023
  
    Parametros de Entrada
      inuproduct_id             Identificador del producto.
      idtFechaInstalacion       Fecha de instalación
    
  Parametros de salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso      Descripcion
  ***************************************************************************/
  PROCEDURE PRACTUALIZAFECHAINSTALACION(inuproduct_id       IN pr_product.product_id%TYPE,
                                        idtFechaInstalacion IN pr_component.service_date%TYPE);

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcActEstadoPr_Component
    Descripcion     : Actualiza estado del componente del producto
    Autor           : Jhon Erazo
    Fecha           : 01-03-2024
  
    Parametros de Entrada
    inuComponenteId   Identificador del componente
    inuEstadoId     Identificador del estado
    
  Parametros de salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso      Descripcion
  jeerazomvm  01-03-2024  OSF-2374  Creación
  ***************************************************************************/
  PROCEDURE prcActEstadoPr_Component(inuComponenteId IN pr_component.component_id%TYPE,
                                     inuEstadoId     IN pr_component.component_status_id%TYPE);


    -- Retira un componente y lo registra  en pr_component_retire
    PROCEDURE prcRetiroComponente( inuComponente IN NUMBER, inuEstadoRetiro IN NUMBER);
    
    --Actualiza solo estado del componente mediante id del producto y id del componente
    PROCEDURE prcActSoloEstadoComponente(inuIdProducto       IN pr_component.product_id%TYPE,
                                         inuIdComponente     IN pr_component.component_id%TYPE,
                                         inuEstadoComponente IN pr_component.component_status_id%TYPE);
    
END PKG_COMPONENTE_PRODUCTO;
/

create or replace package body ADM_PERSON.PKG_COMPONENTE_PRODUCTO IS

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVersion      CONSTANT VARCHAR2(10)  := 'OSF-4270';
    csbPqt_nombre   CONSTANT VARCHAR2(100) := $$plsql_unit || '.';
    cnuNvlTrc       CONSTANT NUMBER        := pkg_traza.cnuNivelTrzDef;
    csbInicio       CONSTANT VARCHAR2(35)  := pkg_traza.csbInicio;
    csbFin          CONSTANT VARCHAR2(35)  := pkg_traza.csbFin;
    csbFin_err      CONSTANT VARCHAR2(35)  := pkg_traza.csbFin_err;
    csbFin_erc      CONSTANT VARCHAR2(35)  := pkg_traza.csbfin_erc;  
        
    -----------------------------------
    -- Tipos/Subtipos
    -----------------------------------
    TYPE  tytbEstCompRet IS TABLE OF NUMBER(1) INDEX BY BINARY_INTEGER;
    
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
    nuError		NUMBER;  		
    sbMensaje   VARCHAR2(1000);  
    
    gtbEstCompRet tytbEstCompRet;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PRACTUALIZAESTADOCOMPONENTE
    Descripcion     : proceso que actualiza estado de los componentes del producto
    Autor           : Jorge Valiente
    Fecha           : 22-06-2023
  
    Parametros de Entrada
      inuproduct_id         Identificador del producto.
      idtFechaInstalacion   Fecha de instalación
    
  Parametros de salida
  
    Modificaciones  :
    =========================================================
    Autor           Fecha       Caso      Descripcion
    Jorge Valiente  24/04/2024  OSF-2477  Se agrega condicion para que solo active componenetes del producto 
                                          si el estado es diferente a 9-retorado (cnuEstadoCompProductoRetirado)
  ***************************************************************************/
  PROCEDURE PRACTUALIZAESTADOCOMPONENTE(inuproduct_id          IN pr_product.product_id%TYPE,
                                        inucomponent_status_id IN pr_component.component_status_id%TYPE) IS
  
    csbMtd_nombre CONSTANT VARCHAR2(100) := csbPqt_nombre ||
                                        'PRACTUALIZAESTADOCOMPONENTE';
    nuError   NUMBER;
    sbmensaje VARCHAR2(1000);
  
  BEGIN
  
    pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio);
  
    pkg_traza.trace('inuproduct_id: ' || inuproduct_id || chr(10) ||
                    'inucomponent_status_id: ' || inucomponent_status_id,
                    cnuNvlTrc);
  
    UPDATE PR_COMPONENT
       SET COMPONENT_STATUS_ID = inucomponent_status_id,
           LAST_UPD_DATE       = sysdate
     WHERE PRODUCT_ID = inuproduct_id
       and component_status_id not in (cnuEstadoCompProductoRetirado);
  
    UPDATE COMPSESU
       SET CMSSESCM = inucomponent_status_id
     WHERE CMSSSESU = inuproduct_id
       and CMSSESCM not in (cnuEstadoCompProductoRetirado);
  
    pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);
  
  EXCEPTION
    WHEN pkg_error.controlled_error THEN
      pkg_error.setError;
      pkg_Error.getError(nuError, sbmensaje);
      pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' ||
                      sbmensaje,
                      cnuNvlTrc);
      pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_erc); 
      RAISE pkg_error.controlled_error;
    WHEN others THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbmensaje);
      pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' ||
                      sbmensaje,
                      cnuNvlTrc);
      pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_err);
      RAISE pkg_Error.controlled_error;
  END PRACTUALIZAESTADOCOMPONENTE;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PRACTUALIZAFECHAINSTALACION
    Descripcion     : proceso que actualiza la fecha de instalación
    Autor           : Dsaltarin
    Fecha           : 15-09-2023
  
    Parametros de Entrada
      inuproduct_id             Identificador del producto.
      inucomponent_status_id    Identificador del estado del componente.
    
  Parametros de salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso      Descripcion
  jerazomvm 11/09/2023  OSF-1530  Se agrega actualización del estado del componente
                    de la tabla compsesu.
  ***************************************************************************/
  PROCEDURE PRACTUALIZAFECHAINSTALACION(inuproduct_id       IN pr_product.product_id%TYPE,
                                        idtFechaInstalacion IN pr_component.service_date%TYPE) IS
  
    csbMtd_nombre CONSTANT VARCHAR2(100) := csbPqt_nombre ||
                                        'PRACTUALIZAFECHAINSTALACION';
    nuError   NUMBER;
    sbmensaje VARCHAR2(1000);
  
  BEGIN
  
    pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio);
  
    pkg_traza.trace('inuproduct_id: ' || inuproduct_id || chr(10) ||
                    'idtFechaInstalacion: ' || idtFechaInstalacion,
                    cnuNvlTrc);
  
    UPDATE PR_COMPONENT
       SET SERVICE_DATE   = idtFechaInstalacion,
           LAST_UPD_DATE  = sysdate,
           MEDIATION_DATE = sysdate
     WHERE PRODUCT_ID = inuproduct_id;
  
    UPDATE COMPSESU
       SET CMSSFEIN = idtFechaInstalacion
     WHERE CMSSSESU = inuproduct_id;
  
    pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);
  
  EXCEPTION
    WHEN pkg_error.controlled_error THEN
      pkg_error.setError;
      pkg_Error.getError(nuError, sbmensaje);
      pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' ||
                      sbmensaje,
                      cnuNvlTrc);
      pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_erc); 
      RAISE pkg_error.controlled_error;
    WHEN others THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbmensaje);
      pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' ||
                      sbmensaje,
                      cnuNvlTrc);
      pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_err);
      RAISE pkg_Error.controlled_error;
  END;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcActEstadoPr_Component
    Descripcion     : Actualiza estado del componente del producto
    Autor           : Jhon Erazo
    Fecha           : 01-03-2024
  
    Parametros de Entrada
    inuComponenteId   Identificador del componente
    inuEstadoId     Identificador del estado
    
  Parametros de salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso      Descripcion
  jeerazomvm  01-03-2024  OSF-2374  Creación
  ***************************************************************************/
  PROCEDURE prcActEstadoPr_Component(inuComponenteId IN pr_component.component_id%TYPE,
                                     inuEstadoId     IN pr_component.component_status_id%TYPE) IS
  
    csbMtd_nombre CONSTANT VARCHAR2(100) := csbPqt_nombre ||
                                        'prcActEstadoPr_Component';
    nuError   NUMBER;
    sbmensaje VARCHAR2(1000);
  
  BEGIN
  
    pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio);
  
    pkg_traza.trace('inuComponenteId: ' || inuComponenteId || chr(10) ||
                    'inuEstadoId: ' || inuEstadoId,
                    cnuNvlTrc);
  
    UPDATE PR_COMPONENT
       SET COMPONENT_STATUS_ID = inuEstadoId, LAST_UPD_DATE = sysdate
     WHERE component_id = inuComponenteId;
  
    pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);
  
  EXCEPTION
    WHEN pkg_error.controlled_error THEN
      pkg_error.setError;
      pkg_Error.getError(nuError, sbmensaje);
      pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' ||
                      sbmensaje,
                      cnuNvlTrc);
      pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_erc); 
      RAISE pkg_error.controlled_error;
    WHEN others THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbmensaje);
      pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' ||
                      sbmensaje,
                      cnuNvlTrc);
      pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_err);
      RAISE pkg_Error.controlled_error;
  END prcActEstadoPr_Component;
  
    -- Carga una tabla pl con los estados de retiro de los componentes
    PROCEDURE prCargaGtbEstCompRet
    IS

        csbMtd_nombre CONSTANT VARCHAR2(100) := csbPqt_nombre ||
                                            'prCargaGtbEstCompRet';
        nuError   NUMBER;
        sbmensaje VARCHAR2(1000);
        
        CURSOR cUEstCompRet
        IS
        SELECT  ps.product_status_id 
        FROM ps_product_status ps 
        WHERE ps.prod_status_type_id = 2
        AND ps.is_active_product = 'N'
        AND ps.is_final_status = 'Y';
            
    BEGIN

        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio);
            
        IF gtbEstCompRet.COUNT = 0 THEN
        
            FOR rgEstCompRet IN cUEstCompRet LOOP
                gtbEstCompRet(rgEstCompRet.product_status_id) := 1;
            END LOOP;
            
        END IF;

        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);
    
    END prCargaGtbEstCompRet;
  
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcActEstadoPr_Component
    Descripcion     : Retira un componente y lo registra  en pr_component_retire
    Autor           : Lubin Pineda
    Fecha           : 03-02-2025

    Parametros de Entrada
    inuComponenteId   Identificador del componente
    inuEstadoRetiro   Identificador del estado de retiro

    Parametros de salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso      Descripcion
    jeerazomvm  03-02-2025  OSF-3893  Creación
    ***************************************************************************/    
    PROCEDURE prcRetiroComponente( inuComponente IN NUMBER, inuEstadoRetiro IN NUMBER)
    IS
        csbMtd_nombre CONSTANT VARCHAR2(100) := csbPqt_nombre ||
                                            'prcRetiroComponente';
        nuError   NUMBER;
        sbmensaje VARCHAR2(1000);
                
        CURSOR cuCompProd
        IS
        SELECT pc.component_id, pc.component_status_id, pc.RowId Rid
        FROM pr_component pc
        WHERE pc.component_id = inuComponente;
        
        rcCompProd   cuCompProd%ROWTYPE; 

        CURSOR cuCompSeSu
        IS
        SELECT cs.cmssidco, cs.cmssescm, cs.RowId Rid
        FROM compsesu cs
        WHERE cs.cmssidco = inuComponente;
        
        rcCompSeSu   cuCompSeSu%ROWTYPE; 
            
    BEGIN

        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio);

        prCargaGtbEstCompRet;
        
        IF gtbEstCompRet.Exists( inuEstadoRetiro ) THEN
                        
            OPEN cuCompProd;
            FETCH cuCompProd INTO rcCompProd;
            CLOSE cuCompProd;

            OPEN cuCompSeSu;
            FETCH cuCompSeSu INTO rcCompSeSu;
            CLOSE cuCompSeSu;
        
            IF 
                rcCompProd.component_id IS NOT NULL AND 
                rcCompSeSu.cmssidco IS NOT NULL
            THEN
            
                IF Not gtbEstCompRet.Exists( rcCompProd.component_status_id ) THEN
                
                    UPDATE pr_component
                    SET component_status_id = inuEstadoRetiro,
                    LAST_UPD_DATE       = sysdate
                    WHERE rowid = rcCompProd.RId;
                    
                    IF NOT gtbEstCompRet.Exists( rcCompSeSu.cmssescm ) THEN
                    
                        UPDATE compsesu
                        SET cmssescm = inuEstadoRetiro,
                        cmssfere = sysdate
                        WHERE rowid = rcCompSeSu.RId;                
                                        
                    ELSE
                        pkg_traza.trace( 'El estado [' || rcCompProd.component_status_id || '] del componente de producto [' ||inuComponente  || '] es de retiro', cnuNvlTrc );                                    
                    END IF;
                    
                    pkg_pr_component_retire.prInsRegistro( inuComponente );                                   
                                    
                ELSE
                    pkg_traza.trace( 'El estado [' || rcCompProd.component_status_id || '] del componente de producto [' ||inuComponente  || '] es de retiro', cnuNvlTrc );                                    
                END IF;

            
            ELSE
                pkg_traza.trace( 'El componente de producto [' ||inuComponente  || '] no existe', cnuNvlTrc );                
            END IF;
        
        ELSE
            pkg_traza.trace( 'El estado al que se quiere pasar el componente [' || inuEstadoRetiro  || '] no es de retiro', cnuNvlTrc );            
        END IF;
        
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);
        
    END prcRetiroComponente;
    
        /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC <Empresa>">
    <Unidad> prcActSoloEstadoComponente </Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha> 21-04-2025 </Fecha>
    <Descripcion> 
        Actualiza solo estado del componente mediante id del producto y id del componente
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="21-04-2025" Inc="OSF-4270" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/    
    PROCEDURE prcActSoloEstadoComponente(inuIdProducto       IN pr_component.product_id%TYPE,
                                         inuIdComponente     IN pr_component.component_id%TYPE,
                                         inuEstadoComponente IN pr_component.component_status_id%TYPE)    
    IS
        --Constante
        csbMtd_nombre           CONSTANT VARCHAR2(70) := csbPqt_nombre || 'prcActSoloEstadoComponente';        
          
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio);
        
        UPDATE pr_component
        SET component_status_id = inuEstadoComponente,
            last_upd_date = sysdate
        WHERE product_id = inuIdProducto
          AND component_id = inuIdComponente;
          
        UPDATE compsesu
        SET cmssescm = inuEstadoComponente
        WHERE cmsssesu = inuIdProducto
          AND cmssidco = inuIdComponente;  
        
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_erc); 
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_err); 
            RAISE pkg_error.controlled_error;
    END prcActSoloEstadoComponente;
    
END PKG_COMPONENTE_PRODUCTO;
/

begin
  pkg_utilidades.prAplicarPermisos('PKG_COMPONENTE_PRODUCTO', 'ADM_PERSON');
end;
/

