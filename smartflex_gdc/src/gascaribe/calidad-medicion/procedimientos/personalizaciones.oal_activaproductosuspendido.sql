CREATE OR REPLACE PROCEDURE personalizaciones.oal_activaproductosuspendido(inuOrden            IN NUMBER,
                                                                           inuCausal           IN NUMBER,
                                                                           inuPersona          IN NUMBER,
                                                                           idtFechIniEje       IN DATE,
                                                                           idtFechaFinEje      IN DATE,
                                                                           isbDatosAdic        IN VARCHAR2,
                                                                           isbActividades      IN VARCHAR2,
                                                                           isbItemsElementos   IN VARCHAR2,
                                                                           isbLecturaElementos IN VARCHAR2,
                                                                           isbComentariosOrden IN VARCHAR2) IS

  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : OAL_ACTIVAPRODUCTO
      Descripcion     : Servicio para activar el producto y componentes con la definicion de
                        fecha de instalacion en el servicio. (El estado de corte no sera cambiado en este servicio,
                        solo se necesita activar el producto para generar lectura y su respectivo cobro)
  
      Autor           : Jorge Valiente
      Fecha           : 23-04-2024
  
      Parametros de Entrada
        inuOrden              numero de orden
        InuCausal             causal de legalizacion
        InuPersona            persona que legaliza
        idtFechIniEje         fecha de inicio de ejecucion
        idtFechaFinEje        fecha fin de ejecucion
        IsbDatosAdic          datos adicionales
        IsbActividades        actividad principal y de apoyo
        IsbItemsElementos     items a legalizar
        IsbLecturaElementos   lecturas
        IsbComentariosOrden   comentario de la orden
      
      Parametros de Salida
  
  
      Modificaciones  :
      =========================================================
      Autor         Fecha       Caso      Descripcion
  ***************************************************************************/
  csbMetodo   VARCHAR2(70) := 'oal_activaproductosuspendido';
  nuErrorCode NUMBER; -- se almacena codigo de error
  sbMensError VARCHAR2(2000); -- se almacena descripcion del error 

  cursor cuData is
    select ooa.order_activity_id OrdenActividad,
           s.sesunuse Servicio,
           s.sesususc Contrato,
           s.sesuserv TipoServicio,
           s.sesuesco EstadoCorteServicio,
           sys_context('USERENV', 'TERMINAL') Terminal,
           sys_context('USERENV', 'SESSION_USER') Usuario,
           pp.product_status_id EstadoProducto,
           s.sesucicl ciclo
      from Or_Order_Activity ooa, servsusc s, or_order oo, pr_product pp
     where oo.order_id = inuOrden
       and oo.order_id = ooa.order_id
       and s.sesunuse = ooa.product_id
       and s.sesunuse = pp.product_id
       and ooa.final_date is null
       and ooa.task_type_id = oo.task_type_id;

  rfData cuData%rowtype;

BEGIN

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

  pkg_traza.trace('inuOrden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('inuCausal: ' || inuCausal, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('inuPersona: ' || inuPersona, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('idtFechIniEje: ' || idtFechIniEje,
                  pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('idtFechaFinEje: ' || idtFechaFinEje,
                  pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('isbDatosAdic: ' || isbDatosAdic,
                  pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('isbActividades: ' || isbActividades,
                  pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('isbItemsElementos: ' || isbItemsElementos,
                  pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('isbLecturaElementos: ' || isbLecturaElementos,
                  pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('isbComentariosOrden: ' || isbComentariosOrden,
                  pkg_traza.cnuNivelTrzDef);

  open cuData;
  fetch cuData
    into rfData;
  close cuData;

  pkg_gestion_producto.prcActivaProductoSuspendido(inuOrden,
                                                   rfData.Ordenactividad,
                                                   rfData.Contrato,
                                                   rfData.Servicio);

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
  WHEN PKG_ERROR.CONTROLLED_ERROR THEN
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERC);
  
    raise pkg_error.CONTROLLED_ERROR;
  
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERR);
  
    raise pkg_error.CONTROLLED_ERROR;
END;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('OAL_ACTIVAPRODUCTOSUSPENDIDO',
                                   'PERSONALIZACIONES');
END;
/
