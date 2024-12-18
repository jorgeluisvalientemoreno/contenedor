CREATE OR REPLACE PACKAGE adm_person.pkg_bogestionsolicitudes AS

  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe y Efigas
      Autor : jvaliente
      Descr : Paquete para el manejo de servicios y logica relacioanda a una solicitud
      Caso  : OSF-3541
      Fecha : 19/11/2024 11:06:35
  ***************************************************************************/

  ---Servicio para realizar el llamado del metodo MO_BODATA.FNUGETVALUE
  FUNCTION fnuObtValorNumerico(isbEntidad   IN VARCHAR2,
                               isbAtributo  IN VARCHAR2,
                               inuSolicitud IN NUMBER) RETURN NUMBER;

  --Servicio para realizar el llamado del metodo MO_BODATA.FSBGETVALUE
  FUNCTION fnuObtValorCadena(isbEntidad   IN VARCHAR2,
                             isbAtributo  IN VARCHAR2,
                             inuSolicitud IN NUMBER) RETURN VARCHAR2;

  --Servicio para realizar el llamado del metodo MO_BODATA.FDTGETVALUE
  FUNCTION fnuObtValorFecha(isbEntidad   IN VARCHAR2,
                            isbAtributo  IN VARCHAR2,
                            inuSolicitud IN NUMBER) RETURN DATE;

  --Servicio para realizar el llamado del metodo MO_BOMOTIVEACTIONUTIL.EXECTRANSTATUSFORREQU
  PROCEDURE prcAtenderSolicitud(inuSolicitud IN NUMBER,
                                inuAccion    IN NUMBER);

  --Servicio para reemplazar el llamado del metodo MO_BOBILLINGDATACHANGE.GETCATEGORYSBYPACK
  PROCEDURE prcObtCategoriasPorSolicitud(inuSoliciutd       IN NUMBER,
                                         onuCategoriaActual OUT NUMBER,
                                         onuCategriaNueva   OUT NUMBER);

  --Servicio para reemplazar el llamado del metodo MO_BOBILLINGDATACHANGE.GETSUBCATEGORYSBYPACK
  PROCEDURE prcObtSubCategoriaPorSolicitud(inuSoliciutd            IN NUMBER,
                                           onuSubcategoriaAnterior OUT NUMBER,
                                           onuSubcategoriaNueva    OUT NUMBER);

END pkg_bogestionsolicitudes;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bogestionsolicitudes AS

  csbSP_NAME    CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  csbNivelTraza CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtValorNumerico
    Descripcion     : Servicio para realizar el llamado del metodo MO_BODATA.FNUGETVALUE
    Caso            : OSF-3541    
    Autor           : Jorge Valiente
    Fecha           : 19-11-2024
  
    Parametros
      Entrada
        isbEntidad          Nombre Entidad
        isbAtributo         Nombre Atributo
        inuSolicitud        Codigo solicitud
        
      Salida
        nuRetorno           Valor del atributo en el entidad
  
    Modificaciones
    =========================================================
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  FUNCTION fnuObtValorNumerico(isbEntidad   IN VARCHAR2,
                               isbAtributo  IN VARCHAR2,
                               inuSolicitud IN NUMBER) RETURN NUMBER IS
  
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtValorNumerico';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  
    nuRetorno number;
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  
    pkg_traza.trace('Solicitud: ' || inuSolicitud, csbNivelTraza);
    pkg_traza.trace('Entidad: ' || isbEntidad, csbNivelTraza);
    pkg_traza.trace('Atributo: ' || isbAtributo, csbNivelTraza);
    pkg_traza.trace('Ejecucion del servicio MO_BODATA.FNUGETVALUE',
                    csbNivelTraza);
  
    nuRetorno := MO_BODATA.FNUGETVALUE(isbEntidad,
                                       isbAtributo,
                                       inuSolicitud);
  
    pkg_traza.trace('Valor a retornar: ' || nuRetorno, csbNivelTraza);
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  
    RETURN(nuRetorno);
  
  EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
  END fnuObtValorNumerico;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtValorCadena
    Descripcion     : Servicio para realizar el llamado del metodo MO_BODATA.FSBGETVALUE
    Caso            : OSF-3541
    Autor           : Jorge Valiente
    Fecha           : 19-11-2024
  
    Parametros
      Entrada
        isbEntidad          Nombre Entidad
        isbAtributo         Nombre Atributo
        inuSolicitud        Codigo solicitud
        
      Salida
        nuRetorno           Valor del atributo en el entidad
  
    Modificaciones
    =========================================================
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  FUNCTION fnuObtValorCadena(isbEntidad   IN VARCHAR2,
                             isbAtributo  IN VARCHAR2,
                             inuSolicitud IN NUMBER) RETURN VARCHAR2 IS
  
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtValorCadena';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  
    sbRetorno VARCHAR2(4000);
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  
    pkg_traza.trace('Solicitud: ' || inuSolicitud, csbNivelTraza);
    pkg_traza.trace('Entidad: ' || isbEntidad, csbNivelTraza);
    pkg_traza.trace('Atributo: ' || isbAtributo, csbNivelTraza);
    pkg_traza.trace('Ejecucion del servicio MO_BODATA.FSBGETVALUEK',
                    csbNivelTraza);
  
    sbRetorno := MO_BODATA.FSBGETVALUE(isbEntidad,
                                       isbAtributo,
                                       inuSolicitud);
  
    pkg_traza.trace('Cadena a retornar: ' || sbRetorno, csbNivelTraza);
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  
    RETURN(sbRetorno);
  
  EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
  END fnuObtValorCadena;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtValorFecha
    Descripcion     : Servicio para realizar el llamado del metodo MO_BODATA.FDTGETVALUE
    Caso            : OSF-3541
    Autor           : Jorge Valiente
    Fecha           : 15-11-2024
  
    Parametros
      Entrada
        isbEntidad          Nombre Entidad
        isbAtributo         Nombre Atributo
        inuSolicitud        Codigo solicitud
        
      Salida
        nuRetorno           Valor del atributo en el entidad
  
    Modificaciones
    =========================================================
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  FUNCTION fnuObtValorFecha(isbEntidad   IN VARCHAR2,
                            isbAtributo  IN VARCHAR2,
                            inuSolicitud IN NUMBER) RETURN DATE IS
  
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtValorFecha';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  
    dtRetorno DATE;
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  
    pkg_traza.trace('Solicitud: ' || inuSolicitud, csbNivelTraza);
    pkg_traza.trace('Entidad: ' || isbEntidad, csbNivelTraza);
    pkg_traza.trace('Atributo: ' || isbAtributo, csbNivelTraza);
    pkg_traza.trace('Ejecucion del servicio MO_BODATA.FDTGETVALUE',
                    csbNivelTraza);
  
    dtRetorno := MO_BODATA.FDTGETVALUE(isbEntidad,
                                       isbAtributo,
                                       inuSolicitud);
  
    pkg_traza.trace('Fecha a retornar: ' || dtRetorno, csbNivelTraza);
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  
    RETURN(dtRetorno);
  
  EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
  END fnuObtValorFecha;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcAtenderSolicitud
    Descripcion     : Servicio para realizar el llamado del metodo MO_BOMOTIVEACTIONUTIL.EXECTRANSTATUSFORREQU
    Caso            : OSF-3541
    Autor           : Jorge Valiente
    Fecha           : 19-11-2024
  
    Parametros
      Entrada
        inuSolicitud          Codigo solicitud
        inuAccion             Codigo Accion
        
    Modificaciones
    =========================================================
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  PROCEDURE prcAtenderSolicitud(inuSolicitud IN NUMBER,
                                inuAccion    IN NUMBER) IS
  
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcAtenderSolicitud';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  
    pkg_traza.trace('Solicitud: ' || inuSolicitud, csbNivelTraza);
    pkg_traza.trace('Accion: ' || inuAccion, csbNivelTraza);
    pkg_traza.trace('Inicio MO_BOMOTIVEACTIONUTIL.EXECTRANSTATUSFORREQU',
                    csbNivelTraza);
  
    MO_BOMOTIVEACTIONUTIL.EXECTRANSTATUSFORREQU(inuSolicitud, inuAccion);
  
    pkg_traza.trace('Fin MO_BOMOTIVEACTIONUTIL.EXECTRANSTATUSFORREQU',
                    csbNivelTraza);
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
  END prcAtenderSolicitud;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtCategoriasPorSolicitud
    Descripcion     : Servicio para reemplazar el llamado del metodo MO_BOBILLINGDATACHANGE.GETCATEGORYSBYPACK
    Caso            : OSF-3541
    Autor           : Jorge Valiente
    Fecha           : 19-11-2024
  
    Parametros
      Entrada
        inuSoliciutd        Codigo solicitud
        
      Salida
        onuCategiraAnterior  Codigo Categoria Actual
        onuCategotiaNueva    Codigo Categoria Nueva
  
    Modificaciones
    =========================================================
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  PROCEDURE prcObtCategoriasPorSolicitud(inuSoliciutd       IN NUMBER,
                                         onuCategoriaActual OUT NUMBER,
                                         onuCategriaNueva   OUT NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prcObtCategoriasPorSolicitud';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  
    pkg_traza.trace('Solicitud: ' || inuSoliciutd, csbNivelTraza);
  
    mo_bobillingdatachange.getcategorysbypack(inuSoliciutd,
                                              onuCategoriaActual,
                                              onuCategriaNueva);
  
    pkg_traza.trace('Categoria Actual: ' || onuCategoriaActual,
                    csbNivelTraza);
    pkg_traza.trace('Nueva Categoria: ' || onuCategriaNueva, csbNivelTraza);
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
  END prcObtCategoriasPorSolicitud;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtSubCategoriaPorSolicitud
    Descripcion     : Servicio para reemplazar el llamado del metodo MO_BOBILLINGDATACHANGE.GETSUBCATEGORYSBYPACK
    Caso            : OSF-3541
    Autor           : Jorge Valiente
    Fecha           : 19-11-2024
  
    Parametros
      Entrada
        inuSoliciutd        Codigo Motivo
        
      Salida
        onuSubcategoriaAnterior  Codigo Categoria Actual
        onuSubcategoriaNueva     Codigo Categoria Nueva
  
    Modificaciones
    =========================================================
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  PROCEDURE prcObtSubCategoriaPorSolicitud(inuSoliciutd            IN NUMBER,
                                           onuSubcategoriaAnterior OUT NUMBER,
                                           onuSubcategoriaNueva    OUT NUMBER) IS
  
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prcObtSubCategoriaPorSolicitud';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  
    pkg_traza.trace('Solicitud: ' || inuSoliciutd, csbNivelTraza);
  
    mo_bobillingdatachange.getsubcategorysbypack(inuSoliciutd,
                                                 onuSubcategoriaAnterior,
                                                 onuSubcategoriaNueva);
  
    pkg_traza.trace('SubCategoria Actual: ' || onuSubcategoriaAnterior,
                    csbNivelTraza);
    pkg_traza.trace('Nueva SubCategoria: ' || onuSubcategoriaNueva,
                    csbNivelTraza);
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
    
  END prcObtSubCategoriaPorSolicitud;

END pkg_bogestionsolicitudes;
/
BEGIN
  -- OSF-3541
  pkg_Utilidades.prAplicarPermisos(UPPER('pkg_bogestionsolicitudes'),
                                   UPPER('adm_person'));
END;
/
