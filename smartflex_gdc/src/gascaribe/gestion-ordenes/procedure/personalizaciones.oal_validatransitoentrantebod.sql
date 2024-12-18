create or replace procedure personalizaciones.oal_ValidaTransitoEntranteBod(inuOrden            IN NUMBER,
                                                                            inuCausal           IN NUMBER,
                                                                            inuPersona          IN NUMBER,
                                                                            idtFechIniEje       IN DATE,
                                                                            idtFechaFinEje      IN DATE,
                                                                            isbDatosAdic        IN VARCHAR2,
                                                                            isbActividades      IN VARCHAR2,
                                                                            isbItemsElementos   IN VARCHAR2,
                                                                            isbLecturaElementos IN VARCHAR2,
                                                                            isbComentariosOrden IN VARCHAR2) is

  /*****************************************************************************************************************
  Propiedad intelectual de PETI.
  
  Unidad         : oal_ValidaTransitoEntranteBod
  Descripcion    : Proceso para validar transito entrante en la bodega de unidad operativa
  
  
  Autor          : Jorge Valiente
  Fecha          : 05/04/2024
  
  Parametros              Descripcion
  ============         ===================      
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
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  *******************************************************************************************************************/

  csbMetodo   VARCHAR2(70) := 'oal_ValidaTransitoEntranteBod';
  nuErrorCode NUMBER; -- se almacena codigo de error
  sbMensError VARCHAR2(2000); -- se almacena descripcion del error 

  nuUnidadOperativa number;

  nuTotalTransitoEntrante number;

begin

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

  pkg_traza.trace('Orden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);

  --Obtiene Unidad Operativa
  nuUnidadOperativa := pkg_BcOrdenes.FnuObtieneUnidadOperativa(inuOrden);
  pkg_traza.trace('Unidad Operativa: ' || nuUnidadOperativa,
                  pkg_traza.cnuNivelTrzDef);

  nuTotalTransitoEntrante := pkg_bcbodega.fnuObtieneTransitoEntConCosto(nuUnidadOperativa);
  pkg_traza.trace('Cantiad de materiales en Transito Entrante: ' ||
                  nuTotalTransitoEntrante,
                  pkg_traza.cnuNivelTrzDef);

  if nuTotalTransitoEntrante > 0 then
    Pkg_Error.SetErrorMessage(isbMsgErrr => 'Existe(n) ' ||
                                            nuTotalTransitoEntrante ||
                                            ' material(es) en transito por recibir en la bodega de la unidad operativa ' ||
                                            nuUnidadOperativa);
  elsif nuTotalTransitoEntrante is null then
    Pkg_Error.SetErrorMessage(isbMsgErrr => 'Error en la ejecucion del servicio pkg_bcbodega.fnuObtieneTransitoEntConCosto');
  end if;

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION

  WHEN pkg_Error.Controlled_Error THEN
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
  
end oal_ValidaTransitoEntranteBod;
/
begin
  PKG_UTILIDADES.PRAPLICARPERMISOS('OAL_VALIDATRANSITOENTRANTEBOD',
                                   'PERSONALIZACIONES');
end;
/
