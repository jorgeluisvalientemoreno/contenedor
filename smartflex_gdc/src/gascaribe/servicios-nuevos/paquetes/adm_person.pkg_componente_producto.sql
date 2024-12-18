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

END PKG_COMPONENTE_PRODUCTO;
/
create or replace package body ADM_PERSON.PKG_COMPONENTE_PRODUCTO IS

  csbNOMPKG CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  cnuNVLTRC CONSTANT NUMBER := pkg_traza.cnuNivelTrzDef;
  csbInicio CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;

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
  
    csbMETODO CONSTANT VARCHAR2(100) := csbNOMPKG ||
                                        'PRACTUALIZAESTADOCOMPONENTE';
    nuError   NUMBER;
    sbmensaje VARCHAR2(1000);
  
  BEGIN
  
    pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
  
    pkg_traza.trace('inuproduct_id: ' || inuproduct_id || chr(10) ||
                    'inucomponent_status_id: ' || inucomponent_status_id,
                    cnuNVLTRC);
  
    UPDATE PR_COMPONENT
       SET COMPONENT_STATUS_ID = inucomponent_status_id,
           LAST_UPD_DATE       = sysdate
     WHERE PRODUCT_ID = inuproduct_id
       and component_status_id not in (cnuEstadoCompProductoRetirado);
  
    UPDATE COMPSESU
       SET CMSSESCM = inucomponent_status_id
     WHERE CMSSSESU = inuproduct_id
       and CMSSESCM not in (cnuEstadoCompProductoRetirado);
  
    pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.setError;
      pkg_Error.getError(nuError, sbmensaje);
      pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' ||
                      sbmensaje,
                      cnuNVLTRC);
      pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      RAISE pkg_error.CONTROLLED_ERROR;
    WHEN others THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbmensaje);
      pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' ||
                      sbmensaje,
                      cnuNVLTRC);
      pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
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
  
    csbMETODO CONSTANT VARCHAR2(100) := csbNOMPKG ||
                                        'PRACTUALIZAFECHAINSTALACION';
    nuError   NUMBER;
    sbmensaje VARCHAR2(1000);
  
  BEGIN
  
    pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
  
    pkg_traza.trace('inuproduct_id: ' || inuproduct_id || chr(10) ||
                    'idtFechaInstalacion: ' || idtFechaInstalacion,
                    cnuNVLTRC);
  
    UPDATE PR_COMPONENT
       SET SERVICE_DATE   = idtFechaInstalacion,
           LAST_UPD_DATE  = sysdate,
           MEDIATION_DATE = sysdate
     WHERE PRODUCT_ID = inuproduct_id;
  
    UPDATE COMPSESU
       SET CMSSFEIN = idtFechaInstalacion
     WHERE CMSSSESU = inuproduct_id;
  
    pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.setError;
      pkg_Error.getError(nuError, sbmensaje);
      pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' ||
                      sbmensaje,
                      cnuNVLTRC);
      pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      RAISE pkg_error.CONTROLLED_ERROR;
    WHEN others THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbmensaje);
      pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' ||
                      sbmensaje,
                      cnuNVLTRC);
      pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
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
  
    csbMETODO CONSTANT VARCHAR2(100) := csbNOMPKG ||
                                        'prcActEstadoPr_Component';
    nuError   NUMBER;
    sbmensaje VARCHAR2(1000);
  
  BEGIN
  
    pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
  
    pkg_traza.trace('inuComponenteId: ' || inuComponenteId || chr(10) ||
                    'inuEstadoId: ' || inuEstadoId,
                    cnuNVLTRC);
  
    UPDATE PR_COMPONENT
       SET COMPONENT_STATUS_ID = inuEstadoId, LAST_UPD_DATE = sysdate
     WHERE component_id = inuComponenteId;
  
    pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.setError;
      pkg_Error.getError(nuError, sbmensaje);
      pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' ||
                      sbmensaje,
                      cnuNVLTRC);
      pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      RAISE pkg_error.CONTROLLED_ERROR;
    WHEN others THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbmensaje);
      pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' ||
                      sbmensaje,
                      cnuNVLTRC);
      pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
  END prcActEstadoPr_Component;
END PKG_COMPONENTE_PRODUCTO;
/
begin
  pkg_utilidades.prAplicarPermisos('PKG_COMPONENTE_PRODUCTO', 'ADM_PERSON');
end;
/
