CREATE OR REPLACE PACKAGE adm_person.pkg_bogestionexclusionordenes IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_bogestionexclusionordenes
      Autor       :   Jorge Valiente
      Fecha       :   11/02/2220
      Descripcion :   Paquete para el manejo de exclusion de ordenes en acta
      Modificaciones  :
      Autor       Fecha       Caso    Descripcion
  *******************************************************************************/

  --Metodo para excluir orden instanciada por dias en la generacion de acta
  PROCEDURE prcexcluirordenpordias(inuDiasAExcluir   NUMBER,
                                   inuTipoComentario NUMBER,
                                   isbComentario     VARCHAR2);

END pkg_bogestionexclusionordenes;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bogestionexclusionordenes IS

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  cnuNVLTRC  CONSTANT NUMBER(2) := pkg_traza.cnuNivelTrzDef;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : prcexcluirordenpordias
  Descripcion     : Metodo para excluir orden instanciada por dias en la generacion de acta
  Autor           : Jorge Valiente
  Fecha           : 19/02/2025
  caso            : OSF-4027
  
  Parametros de Entrada
      inuDiasAExcluir     Numero de dias excluir
      inuTipoComentario   Codigo tipo de comentario
      isbComentario       Comentario
  
  Modificaciones  :
  Autor       Fecha       Caso     Descripcion
  ***************************************************************************/
  PROCEDURE prcexcluirordenpordias(inuDiasAExcluir   NUMBER,
                                   inuTipoComentario NUMBER,
                                   isbComentario     VARCHAR2) IS
    -- Nombre de este metodo
    csbMT_NAME     VARCHAR2(70) := csbSP_NAME || 'prcexcluirordenpordias';
    nuErrorCode    NUMBER; -- se almacena codigo de error
    sbErrorMessage VARCHAR2(2000); -- se almacena descripcion del error
  
    cnuNVLTRC CONSTANT NUMBER(2) := pkg_traza.cnuNivelTrzDef;
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
  
    pkg_traza.trace('Dias A Excluir: ' || inuDiasAExcluir, cnuNVLTRC);
    pkg_traza.trace('Tipo Comentario: ' || inuTipoComentario, cnuNVLTRC);
    pkg_traza.trace('Comentario: ' || isbComentario, cnuNVLTRC);
  
    pkg_traza.trace('CT_BOEXCLUSIONFUNCTIONS.EXCLUDEORDERFORDAYS',
                    cnuNVLTRC);
    ct_boexclusionfunctions.excludeorderfordays(inuDiasAExcluir,
                                                inuTipoComentario,
                                                isbComentario);
  
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
  
  EXCEPTION
  
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuErrorCode, sbErrorMessage);
      pkg_traza.trace('Error: ' || sbErrorMessage, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      RAISE pkg_error.CONTROLLED_ERROR;
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbErrorMessage);
      pkg_traza.trace('Error: ' || sbErrorMessage, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      RAISE pkg_error.CONTROLLED_ERROR;
    
  END prcexcluirordenpordias;

END pkg_bogestionexclusionordenes;
/
BEGIN
  pkg_utilidades.prAplicarPermisos(upper('pkg_bogestionexclusionordenes'),
                                   upper('adm_person'));
END;
/
