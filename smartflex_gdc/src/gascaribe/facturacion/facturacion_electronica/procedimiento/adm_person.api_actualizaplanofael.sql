create or replace PROCEDURE adm_person.api_actualizaplanofael ( icblRequest IN CLOB,
                                                       inuCodLote  IN lote_fact_electronica.codigo_lote%type,
                                                       onuError    OUT  NUMBER,
                                                       osbError    OUT VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGenerarEstrFactElec
    Descripcion     : proceso para generar estructura de facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 17-01-2024

    Parametros de Entrada
      icblRequest       Facturas a actualizar formato (<DATOS><DOCUMENTOS><TIPO_DOCU></TIPO_DOCU><DOCUMENTO></DOCUMENTO></DOCUMENTOS></DATOS>)
      inuCodLote       codigo de lote
    Parametros de Salida
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        19-06-2024  OSF-2158    Creacion
  ***************************************************************************/
   csbSP_NAME              CONSTANT VARCHAR2(32) := $$PLSQL_UNIT;
   csbNivelTraza           CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
BEGIN
  pkg_traza.trace(csbSP_NAME, csbNivelTraza, pkg_traza.csbINICIO);
  pkg_traza.trace(' inuCodLote => ' || inuCodLote, pkg_traza.cnuNivelTrzDef);  
  pkg_error.prinicializaerror(onuError, osbError);
  PKG_BOACTUALIZAPLANOFAEL.prActualizaPlanoFael( icblRequest,
                                                 inuCodLote,
                                                 onuError,
                                                 osbError);
  
  pkg_traza.trace(csbSP_NAME, csbNivelTraza, pkg_traza.csbFIN);
EXCEPTION
  WHEN pkg_Error.Controlled_Error  THEN
        pkg_error.getError(onuError,osbError);
        pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbSP_NAME, csbNivelTraza, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_error.getError(onuError,osbError);
        pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbSP_NAME, csbNivelTraza, pkg_traza.csbFIN_ERR); 
END api_actualizaplanofael;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('API_ACTUALIZAPLANOFAEL','ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.API_ACTUALIZAPLANOFAEL TO ROLE_APPFACTURACION_ELECTRONIK
/
