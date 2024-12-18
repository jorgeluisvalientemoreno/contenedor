create or replace package adm_person.pkg_ldc_ordentramiterp is

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : pkg_ldc_ordentramiterp
    Descripcion     : Paquete para realizar CRUD en la entidad ldc_ordentramiterp
    Autor           : Jorge Valiente
    Fecha           : 15-04-2024
  
    Parametros de Entrada
  
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

  --Proceso para registrar Orden legalizad y su Solicitud RP creada con esta legalizacion
  Procedure prcInsertaRegistro(inuOrden           number,
                               inuTipoTrabajo     number,
                               inuCausal          number,
                               inuSolicitud       number,
                               inuUnidadOperativa number);

END pkg_ldc_ordentramiterp;
/
create or replace package body adm_person.pkg_ldc_ordentramiterp is

  csbSP_NAME CONSTANT VARCHAR2(32) := $$PLSQL_UNIT || '.';

  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcInsertaRegistro
      Descripcion     : Proceso para registrar Orden legalizad y su Solicitud RP creada con esta legalizacion
      Autor           : Jorge Valiente
      Fecha           : 15-04-2024
  
      Parametros              Tipo      Descripcion
      ============            =====      ===================
      isbNombreParametro      Entrada    Codigo Parametro
      nuValor                 Salida     Valor del parametro
      
      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
  Procedure prcInsertaRegistro(inuOrden           number,
                               inuTipoTrabajo     number,
                               inuCausal          number,
                               inuSolicitud       number,
                               inuUnidadOperativa number) is
  
    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'prcInsertaRegistro';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error 
  
  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_traza.trace('Orden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Tipo Trabajo: ' || inuTipoTrabajo,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Causal: ' || inuCausal, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Solicitud: ' || inuSolicitud,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Unidad Operativa: ' || inuUnidadOperativa,
                    pkg_traza.cnuNivelTrzDef);
  
    INSERT INTO ldc_ordentramiterp
      (orden, tipotrabajo, causal, solicitud, unidadopera)
    VALUES
      (inuOrden,
       inuTipoTrabajo,
       inuCausal,
       inuSolicitud,
       inuUnidadOperativa);
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
    
      RAISE pkg_Error.Controlled_Error;
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
    
      RAISE pkg_Error.Controlled_Error;
  END prcInsertaRegistro;

END pkg_ldc_ordentramiterp;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_LDC_ORDENTRAMITERP', 'ADM_PERSON');
END;
/
