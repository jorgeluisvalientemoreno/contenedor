CREATE OR REPLACE PACKAGE personalizaciones.pkg_duplicado_factura IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_duplicado_factura
      Autor       :   Jorge Valiente
      Fecha       :   21-05-2024
      Descripcion :   Paquete para realizar consulta a las bodegas asociadas
  
      Modificaciones   
      -----------------------------------------------------------------------
      Autor       Fecha       Caso       Descripcion
  *******************************************************************************/

  --Servicio para registrar DATA del duplicado de factura a financiar
  PROCEDURE prcRegsitraDuplicado(inuCupon     number,
                                 inuContrato  number,
                                 inuSolicitud number);

  --Servicio para eliminar DATA del duplicado que fue financiado
  PROCEDURE prcEliminaDuplicado(inuCupon number);

  --Servicio para actualizar observacion del duplicado que no fue financiado
  PROCEDURE prcActualizaObservacion(inuCupon       number,
                                    isbObservacion varchar2);

END pkg_duplicado_factura;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_duplicado_factura IS

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : prcRegsitraDuplicado
  Descripcion     : Servicio para registrar DATA del duplicado de factura a financiar
  Autor           : Jorge Valiente
  Fecha           : 15-07-2024
  
  Parametros
  Entrada
  inuCupon         Codigo Cupon
  inuCausal        Causal que genera el duplicado de la factura
  inuSolicitud     Solicitud del duplicado de factura
  
  Salida
  
  Modificaciones   
  -----------------------------------------------------------------------
  Autor           Fecha       Caso       Descripcion
  ***************************************************************************/
  PROCEDURE prcRegsitraDuplicado(inuCupon     number,
                                 inuContrato  number,
                                 inuSolicitud number) IS
  
    -- Nombre de ste mEtodo
    csbMetodo   VARCHAR2(70) := csbSP_NAME || '.prcRegsitraDuplicado';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error  
  
  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_traza.trace('Cupon: ' || inuCupon, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Contrato: ' || inuContrato, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Solicitud: ' || inuSolicitud,
                    pkg_traza.cnuNivelTrzDef);
  
    insert into duplicado_factura
      (cuponume, susccodi, package_id, fecha_registro, observacion)
    values
      (inuCupon, inuContrato, inuSolicitud, sysdate, null);
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
    
  END prcRegsitraDuplicado;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : prcEliminaDuplicado
  Descripcion     : Servicio para eliminar DATA del duplicado que fue financiado
  Autor           : Jorge Valiente
  Fecha           : 15-07-2024
  
  Parametros
  Entrada
  inuCupon         Codigo Cupon
  inuCausal        Causal que genera el duplicado de la factura
  inuSolicitud     Solicitud del duplicado de factura
  
  Salida
  
  Modificaciones   
  -----------------------------------------------------------------------
  Autor           Fecha       Caso       Descripcion
  ***************************************************************************/
  PROCEDURE prcEliminaDuplicado(inuCupon number) IS
  
    -- Nombre de ste mEtodo
    csbMetodo   VARCHAR2(70) := csbSP_NAME || '.prcEliminaDuplicado';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error  
  
  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_traza.trace('Cupon: ' || inuCupon, pkg_traza.cnuNivelTrzDef);
  
    delete duplicado_factura where cuponume = inuCupon;
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
    
  END prcEliminaDuplicado;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : prcActualizaObservacion
  Descripcion     : Servicio para actualizar observacion del duplicado que no fue financiado
  Autor           : Jorge Valiente
  Fecha           : 15-07-2024
  
  Parametros
  Entrada
  inuCupon         Codigo Cupon
  inuCausal        Causal que genera el duplicado de la factura
  inuSolicitud     Solicitud del duplicado de factura
  
  Salida
  
  Modificaciones   
  -----------------------------------------------------------------------
  Autor           Fecha       Caso       Descripcion
  ***************************************************************************/
  PROCEDURE prcActualizaObservacion(inuCupon       number,
                                    isbObservacion varchar2) IS
  
    -- Nombre de ste mEtodo
    csbMetodo   VARCHAR2(70) := csbSP_NAME || '.prcActualizaObservacion';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error  
  
    PRAGMA AUTONOMOUS_TRANSACTION;
  
  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_traza.trace('Cupon: ' || inuCupon, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Observacion: ' || isbObservacion,
                    pkg_traza.cnuNivelTrzDef);
  
    update duplicado_factura
       set observacion = isbObservacion
     where cuponume = inuCupon;
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
    Commit;
  
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
    
  END prcActualizaObservacion;

END pkg_duplicado_factura;
/
begin
  pkg_utilidades.praplicarpermisos('PKG_DUPLICADO_FACTURA',
                                   'PERSONALIZACIONES');
end;
/
