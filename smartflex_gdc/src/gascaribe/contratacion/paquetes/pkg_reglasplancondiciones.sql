CREATE OR REPLACE PACKAGE pkg_reglasplancondiciones IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_reglasplancondiciones
      Autor       :   
      Fecha       :   
      Descripcion :   
      Modificaciones  :
      Autor       Fecha       Caso    Descripcion
  
  *******************************************************************************/

  --MetMetodo para excluir orden con relacion a la documentacion de un proceso de venta
  PROCEDURE prcExcluirOrdenEstadoDocumento;

END pkg_reglasplancondiciones;
/
CREATE OR REPLACE PACKAGE BODY pkg_reglasplancondiciones IS

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  cnuNVLTRC  CONSTANT NUMBER(2) := pkg_traza.cnuNivelTrzDef;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : prcExcluirOrdenEstadoDocumento
  Descripcion     : Metodo para excluir orden con relacion a la documentacion de un proceso de venta
  Autor           : Jorge Valiente
  Fecha           : 08/02/2025
  
  Parametros de Entrada
  
  Parametros de Salida
  
  Modificaciones  :
  Autor       Fecha       Caso     Descripcion
  ***************************************************************************/
  PROCEDURE prcExcluirOrdenEstadoDocumento IS
    -- Nombre de este metodo
    csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||
                                '.prcExcluirOrdenEstadoDocumento';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error
  
    sbNombreInstancia VARCHAR2(4000);
    sbOrden           VARCHAR2(4000);
    nuOrden           NUMBER;
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
  
    sbNombreInstancia := CT_BOCONSTANTS.FSBGETCONTRACTORINSTANCENAME;
    pkg_traza.trace('Nombre Instancia: ' || sbNombreInstancia, cnuNVLTRC);
  
    GE_BSINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbNombreInstancia,
                                              NULL,
                                              'OR_ORDER',
                                              'ORDER_ID',
                                              sbOrden,
                                              nuErrorCode,
                                              sbMensError);
    nuOrden := TO_NUMBER(sbOrden);
  
    pkg_traza.trace('Orden Instanciada: ' || nuOrden, cnuNVLTRC);
  
    pkg_boexclusionordenes.prcExcluirOrdenEstadoDocumento(nuOrden);
  
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error => ' || sbMensError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error => ' || sbMensError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
  END prcExcluirOrdenEstadoDocumento;

END pkg_reglasplancondiciones;
/
