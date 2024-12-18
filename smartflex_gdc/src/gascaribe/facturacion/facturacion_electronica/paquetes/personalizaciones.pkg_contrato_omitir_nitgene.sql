CREATE OR REPLACE PACKAGE personalizaciones.pkg_contrato_omitir_nitgene IS
  subtype styContOmitirCeduGeneLog  is  contratos_omitir_nit_gene_log%rowtype;
   FUNCTION fsbVersion RETURN VARCHAR2;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 26-11-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      26-11-2024   OSF-3649    Creacion
  ***************************************************************************/
  
  PROCEDURE prInsertarExceContLog( iregContOmiCeduGeneLog IN  styContOmitirCeduGeneLog,
                                    onuError       OUT NUMBER,
                                    osbError       OUT VARCHAR2);
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsertarExceContLog
    Descripcion     : proceso que inserta en la tabla de log excepcion de contrato

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 26-11-2024

    Parametros de Entrada
      iregContOmiCeduGeneLog        registro de log excepcion de contrato
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       26-11-2024   OSF-3649    Creacion
  ***************************************************************************/
END pkg_contrato_omitir_nitgene;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.pkg_contrato_omitir_nitgene IS
   -- Constantes para el control de la traza
   csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
   -- Identificador del ultimo caso que hizo cambios
   csbVersion     CONSTANT VARCHAR2(15) := 'OSF-2158';
  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 26-11-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      26-11-2024   OSF-3649    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fsbVersion';
  BEGIN
    RETURN csbVersion;
  END fsbVersion;
  
  PROCEDURE prInsertarExceContLog( iregContOmiCeduGeneLog IN  styContOmitirCeduGeneLog,
                                    onuError       OUT NUMBER,
                                    osbError       OUT VARCHAR2) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsertarExceContLog
    Descripcion     : proceso que inserta en la tabla de log excepcion de contrato

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 26-11-2024

    Parametros de Entrada
      iregContOmiCeduGeneLog        registro de log excepcion de contrato
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       26-11-2024   OSF-3649    Creacion
  ***************************************************************************/
   csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prInsertarExceContLog';
 BEGIN
   pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
   pkg_error.prinicializaerror(onuError, osbError);
   INSERT INTO contratos_omitir_nit_gene_log (contrato, accion, usuario, terminal, fecha_registro)
        VALUES( iregContOmiCeduGeneLog.contrato,
                iregContOmiCeduGeneLog.accion,
                iregContOmiCeduGeneLog.usuario, 
                iregContOmiCeduGeneLog.terminal, 
                iregContOmiCeduGeneLog.fecha_registro);
   pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
 EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(onuError,osbError);
       pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(onuError,osbError);
       pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
 END prInsertarExceContLog;
END pkg_contrato_omitir_nitgene;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_CONTRATO_OMITIR_NITGENE','PERSONALIZACIONES');
END;
/