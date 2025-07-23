CREATE OR REPLACE PACKAGE personalizaciones.pkg_BcPuntoAtencion IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_BcPuntoAtencion
      Autor       :   Jorge Valiente
      Fecha       :   06/02/2025
      Descripcion :   Paquete para establecer la DATA sobre punto de atencion
      Modificaciones  :
      Autor       Fecha       Caso    Descripcion
  
  *******************************************************************************/

  --Validar que el cursor cuRecord este cerrado
  FUNCTION fsbValMedioRecepcion(nuPuntoAtencion  NUMBER,
                                nuMedioRecepcion NUMBER) RETURN VARCHAR2;

END pkg_BcPuntoAtencion;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_BcPuntoAtencion IS

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  cnuNVLTRC  CONSTANT NUMBER(2) := pkg_traza.cnuNivelTrzDef;
  csbINICIO  CONSTANT VARCHAR2(4) := pkg_traza.fsbINICIO;
  csbFIN     CONSTANT VARCHAR2(4) := pkg_traza.csbFIN;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : fsbValMedioRecepcion
  Descripcion     : Retorna Categoria del producto
  Autor           : 
  Fecha           : 
  Modificaciones  :
  Autor       Fecha       Caso        Descripcion
  ***************************************************************************/
  FUNCTION fsbValMedioRecepcion(nuPuntoAtencion  NUMBER,
                                nuMedioRecepcion NUMBER) RETURN VARCHAR2 IS
  
    -- Nombre de ste mEtodo
    csbMT_NAME VARCHAR2(70) := csbSP_NAME || '.fsbValMedioRecepcion';
  
    sbError VARCHAR2(4000);
    nuError NUMBER;
  
    CURSOR cuMedioRecepcion IS
      select count(1)
        from or_ope_uni_rece_type
       where or_ope_uni_rece_type.reception_type_id = nuMedioRecepcion
         and or_ope_uni_rece_type.operating_unit_id = nuPuntoAtencion;
  
    sbRetorno  VARCHAR2(1) := 'N';
    nuCantidad NUMBER;
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbINICIO);
  
    IF cuMedioRecepcion%ISOPEN THEN
      CLOSE cuMedioRecepcion;
    END IF;
  
    OPEN cuMedioRecepcion;
    FETCH cuMedioRecepcion
      INTO nuCantidad;
    CLOSE cuMedioRecepcion;
  
    pkg_traza.trace('Cantidad: ' || nuCantidad, cnuNVLTRC);
  
    IF nuCantidad > 0 THEN
      sbRetorno := 'S';
    END IF;
  
    pkg_traza.trace('Retorna: ' || sbRetorno, cnuNVLTRC);
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbFIN);
  
    RETURN sbRetorno;
  
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      RETURN sbRetorno;
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RETURN sbRetorno;
    
  END fsbValMedioRecepcion;

END pkg_BcPuntoAtencion;
/
begin
  pkg_utilidades.prAplicarPermisos(upper('pkg_BcPuntoAtencion'),
                                   upper('PERSONALIZACIONES'));
end;
/
